"""Convert a Postgres DDL.sql into a Mermaid ER diagram.

Goals:
- Produce a single ```mermaid erDiagram``` block suitable for Notion.
- Best-effort parsing (handles common "CREATE TABLE (...)" style).
- Extract:
  - tables
  - columns (+ simple PK detection)
  - foreign keys from inline "REFERENCES ..." and table-level constraints
  - foreign keys from "ALTER TABLE ... ADD CONSTRAINT ... FOREIGN KEY ... REFERENCES ..." statements

Limitations:
- Not a full SQL parser; tuned for typical pg_dump / hand-written DDL.
- Complex expressions/types are simplified.
"""

from __future__ import annotations

import argparse
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Sequence, Set, Tuple


FK = Tuple[str, str, str]  # (from_table, to_table, label/column)


def _norm_ident(name: str) -> str:
    """Normalize identifier for Mermaid:

    - drop surrounding quotes
    - replace schema separator '.' with '__'
    - replace other non [A-Za-z0-9_] with '_'
    """

    name = name.strip().strip('"')
    name = name.replace(".", "__")
    return re.sub(r"[^0-9A-Za-z_]", "_", name)


def _split_top_level_commas(s: str) -> List[str]:
    """Split on commas not inside parentheses."""

    out: List[str] = []
    cur: List[str] = []
    depth = 0
    for ch in s:
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth = max(0, depth - 1)
        if ch == "," and depth == 0:
            seg = "".join(cur).strip()
            if seg:
                out.append(seg)
            cur = []
        else:
            cur.append(ch)
    seg = "".join(cur).strip()
    if seg:
        out.append(seg)
    return out


@dataclass
class Table:
    name: str
    columns: List[Tuple[str, str]] = field(default_factory=list)  # (col, type)
    pk: Set[str] = field(default_factory=set)


def _extract_create_table_blocks(sql: str) -> List[Tuple[str, str]]:
    """Return list of (table_name, body_inside_parentheses)."""

    starts = [m.start() for m in re.finditer(r"(?im)^create\s+table\s+", sql)]
    blocks: List[Tuple[str, str]] = []
    for i, s in enumerate(starts):
        end = starts[i + 1] if i + 1 < len(starts) else len(sql)
        chunk = sql[s:end]
        m = re.search(r"(?im)^create\s+table\s+([^\s(]+)", chunk)
        if not m:
            continue
        raw_name = m.group(1)
        body_start = chunk.find("(", m.end())
        if body_start < 0:
            continue
        depth = 0
        body_chars: List[str] = []
        j = body_start
        while j < len(chunk):
            ch = chunk[j]
            if ch == "(":
                depth += 1
                if depth == 1:
                    j += 1
                    continue
            elif ch == ")":
                depth -= 1
                if depth == 0:
                    break

            if depth >= 1:
                body_chars.append(ch)
            j += 1

        if depth != 0:
            continue

        blocks.append((raw_name, "".join(body_chars)))
    return blocks


_CONSTRAINT_KEYWORDS = {
    "not",
    "null",
    "default",
    "primary",
    "references",
    "constraint",
    "check",
    "unique",
    "generated",
    "collate",
}


def _infer_col_type(rest: str) -> str:
    """Best-effort type extraction from the column tail."""

    tokens: List[str] = []
    for tok in rest.strip().split():
        if tok.lower() in _CONSTRAINT_KEYWORDS:
            break
        tokens.append(tok)

    if not tokens:
        return "text"
    # Mermaid is happier with short type names; keep 1-2 tokens max
    # (e.g., "timestamp with time zone" -> "timestamp")
    t = " ".join(tokens)
    t = t.replace("with time zone", "")
    t = t.replace("without time zone", "")
    t = re.sub(r"\s+", " ", t).strip()
    return t or "text"


def _parse_table_body(raw_table_name: str, body: str) -> Tuple[Table, Set[FK]]:
    tname = _norm_ident(raw_table_name)
    table = Table(name=tname)
    fks: Set[FK] = set()

    # DDL here is mostly line-based, but commas are more reliable.
    items = _split_top_level_commas(body)
    for item in items:
        line = item.strip()
        if not line:
            continue
        lline = line.lower().strip()

        # table-level PK
        mpk = re.search(r"(?i)primary\s+key\s*\(([^)]+)\)", line)
        if mpk:
            for c in mpk.group(1).split(","):
                table.pk.add(_norm_ident(c))
            continue

        # table-level FK: FOREIGN KEY (a) REFERENCES t(b)
        mfk = re.search(
            r"(?i)foreign\s+key\s*\(([^)]+)\)\s+references\s+([^\s(]+)", line
        )
        if mfk:
            col = _norm_ident(mfk.group(1).split(",")[0])
            ref_tbl = _norm_ident(mfk.group(2))
            fks.add((tname, ref_tbl, col))
            continue

        # constraints / checks we ignore
        if lline.startswith("constraint ") or lline.startswith("unique ") or lline.startswith("check "):
            continue

        # column definition (first token is column name)
        parts = line.split(None, 1)
        if len(parts) < 2:
            continue
        col = _norm_ident(parts[0])
        rest = parts[1]
        ctype = _infer_col_type(rest)
        table.columns.append((col, ctype))

        if re.search(r"(?i)\bprimary\s+key\b", rest):
            table.pk.add(col)

        mref = re.search(r"(?i)\breferences\s+([^\s(]+)", rest)
        if mref:
            ref_tbl = _norm_ident(mref.group(1))
            fks.add((tname, ref_tbl, col))

    # If a table has no columns parsed (edge case), add a placeholder
    if not table.columns:
        table.columns.append(("id", "text"))
        table.pk.add("id")

    return table, fks


def _extract_alter_table_fks(sql: str) -> Set[FK]:
    """Parse ALTER TABLE ... FOREIGN KEY(...) REFERENCES ... statements."""

    fks: Set[FK] = set()
    # Collapses whitespace to make the regex easier.
    compact = re.sub(r"\s+", " ", sql)

    # Example:
    # alter table only v2.attachments
    #   add constraint ... foreign key (target_id) references v2.targets(id) on delete cascade;
    pat = re.compile(
        r"(?i)alter table(?: only)?\s+([^\s]+)\s+add\s+constraint\s+[^\s]+\s+foreign\s+key\s*\(([^)]+)\)\s+references\s+([^\s(]+)",  # noqa: E501
    )
    for m in pat.finditer(compact):
        frm = _norm_ident(m.group(1))
        col = _norm_ident(m.group(2).split(",")[0])
        to = _norm_ident(m.group(3))
        fks.add((frm, to, col))
    return fks


def ddl_to_mermaid(sql: str) -> str:
    blocks = _extract_create_table_blocks(sql)
    tables: Dict[str, Table] = {}
    fks: Set[FK] = set()

    for raw_name, body in blocks:
        t, tfks = _parse_table_body(raw_name, body)
        tables[t.name] = t
        fks |= tfks

    fks |= _extract_alter_table_fks(sql)

    # Create placeholders for referenced tables that are not defined in the DDL
    for _, ref, _ in list(fks):
        if ref not in tables:
            tables[ref] = Table(name=ref, columns=[("id", "text")], pk={"id"})

    # Mermaid output
    out: List[str] = []
    out.append("```mermaid")
    out.append("erDiagram")

    for tname in sorted(tables.keys()):
        t = tables[tname]
        out.append(f"  {t.name} {{")
        for col, ctype in t.columns:
            suffix = " PK" if col in t.pk else ""
            out.append(f"    {ctype} {col}{suffix}")
        out.append("  }")

    # Relationships: referenced_table ||--o{ referencing_table
    for frm, to, col in sorted(fks):
        out.append(f"  {to} ||--o{{ {frm} : \"{col}\"")

    out.append("```")
    return "\n".join(out) + "\n"


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("ddl", type=Path, help="Path to DDL.sql")
    args = ap.parse_args()
    sql = args.ddl.read_text(encoding="utf-8", errors="ignore")
    print(ddl_to_mermaid(sql), end="")


if __name__ == "__main__":
    main()
