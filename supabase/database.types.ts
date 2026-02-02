export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "13.0.5"
  }
  public: {
    Tables: {
      authors: {
        Row: {
          bio_short: string | null
          birth_year: number | null
          created_at: string | null
          death_year: number | null
          entity_type: Database["public"]["Enums"]["author_entity_type"] | null
          full_name: string
          id: number
          is_published: boolean | null
          slug: string
          updated_at: string | null
          website_url: string | null
          wiki_url: string | null
        }
        Insert: {
          bio_short?: string | null
          birth_year?: number | null
          created_at?: string | null
          death_year?: number | null
          entity_type?: Database["public"]["Enums"]["author_entity_type"] | null
          full_name: string
          id?: number
          is_published?: boolean | null
          slug: string
          updated_at?: string | null
          website_url?: string | null
          wiki_url?: string | null
        }
        Update: {
          bio_short?: string | null
          birth_year?: number | null
          created_at?: string | null
          death_year?: number | null
          entity_type?: Database["public"]["Enums"]["author_entity_type"] | null
          full_name?: string
          id?: number
          is_published?: boolean | null
          slug?: string
          updated_at?: string | null
          website_url?: string | null
          wiki_url?: string | null
        }
        Relationships: []
      }
      features: {
        Row: {
          created_at: string | null
          description: string | null
          id: number
          is_published: boolean | null
          slug: string
          sort_order: number | null
          title_en: string | null
          title_ru: string
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          description?: string | null
          id?: number
          is_published?: boolean | null
          slug: string
          sort_order?: number | null
          title_en?: string | null
          title_ru: string
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          description?: string | null
          id?: number
          is_published?: boolean | null
          slug?: string
          sort_order?: number | null
          title_en?: string | null
          title_ru?: string
          updated_at?: string | null
        }
        Relationships: []
      }
      media_assets: {
        Row: {
          caption_original: string | null
          caption_ru: string | null
          created_at: string | null
          credit: string | null
          description_ru: string | null
          height: number | null
          id: number
          is_published: boolean | null
          kind: Database["public"]["Enums"]["media_kind"] | null
          license: string | null
          mime_type: string | null
          public_url: string | null
          slug: string | null
          source_url: string | null
          storage_bucket: string
          storage_path: string
          updated_at: string | null
          width: number | null
        }
        Insert: {
          caption_original?: string | null
          caption_ru?: string | null
          created_at?: string | null
          credit?: string | null
          description_ru?: string | null
          height?: number | null
          id?: number
          is_published?: boolean | null
          kind?: Database["public"]["Enums"]["media_kind"] | null
          license?: string | null
          mime_type?: string | null
          public_url?: string | null
          slug?: string | null
          source_url?: string | null
          storage_bucket?: string
          storage_path: string
          updated_at?: string | null
          width?: number | null
        }
        Update: {
          caption_original?: string | null
          caption_ru?: string | null
          created_at?: string | null
          credit?: string | null
          description_ru?: string | null
          height?: number | null
          id?: number
          is_published?: boolean | null
          kind?: Database["public"]["Enums"]["media_kind"] | null
          license?: string | null
          mime_type?: string | null
          public_url?: string | null
          slug?: string | null
          source_url?: string | null
          storage_bucket?: string
          storage_path?: string
          updated_at?: string | null
          width?: number | null
        }
        Relationships: []
      }
      phenomena: {
        Row: {
          color: string | null
          created_at: string | null
          date_end_year: number | null
          date_start_year: number | null
          id: number
          image_media_id: number | null
          is_published: boolean | null
          short_definition: string | null
          slug: string
          sort_order: number | null
          title_en: string | null
          title_ru: string
          updated_at: string | null
        }
        Insert: {
          color?: string | null
          created_at?: string | null
          date_end_year?: number | null
          date_start_year?: number | null
          id?: number
          image_media_id?: number | null
          is_published?: boolean | null
          short_definition?: string | null
          slug: string
          sort_order?: number | null
          title_en?: string | null
          title_ru: string
          updated_at?: string | null
        }
        Update: {
          color?: string | null
          created_at?: string | null
          date_end_year?: number | null
          date_start_year?: number | null
          id?: number
          image_media_id?: number | null
          is_published?: boolean | null
          short_definition?: string | null
          slug?: string
          sort_order?: number | null
          title_en?: string | null
          title_ru?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "phenomena_image_media_id_fkey"
            columns: ["image_media_id"]
            isOneToOne: false
            referencedRelation: "media_assets"
            referencedColumns: ["id"]
          },
        ]
      }
      phenomenon_style: {
        Row: {
          is_primary: boolean | null
          note: string | null
          phenomenon_id: number
          sort_order: number | null
          style_id: number
        }
        Insert: {
          is_primary?: boolean | null
          note?: string | null
          phenomenon_id: number
          sort_order?: number | null
          style_id: number
        }
        Update: {
          is_primary?: boolean | null
          note?: string | null
          phenomenon_id?: number
          sort_order?: number | null
          style_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "phenomenon_style_phenomenon_id_fkey"
            columns: ["phenomenon_id"]
            isOneToOne: false
            referencedRelation: "phenomena"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "phenomenon_style_style_id_fkey"
            columns: ["style_id"]
            isOneToOne: false
            referencedRelation: "styles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "phenomenon_style_style_id_fkey"
            columns: ["style_id"]
            isOneToOne: false
            referencedRelation: "v_style_card_published"
            referencedColumns: ["id"]
          },
        ]
      }
      project_author: {
        Row: {
          author_id: number
          project_id: number
          role: string
        }
        Insert: {
          author_id: number
          project_id: number
          role?: string
        }
        Update: {
          author_id?: number
          project_id?: number
          role?: string
        }
        Relationships: [
          {
            foreignKeyName: "project_author_author_id_fkey"
            columns: ["author_id"]
            isOneToOne: false
            referencedRelation: "authors"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "project_author_project_id_fkey"
            columns: ["project_id"]
            isOneToOne: false
            referencedRelation: "projects"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "project_author_project_id_fkey"
            columns: ["project_id"]
            isOneToOne: false
            referencedRelation: "v_project_card_published"
            referencedColumns: ["id"]
          },
        ]
      }
      project_feature: {
        Row: {
          feature_id: number
          note: string | null
          project_id: number
        }
        Insert: {
          feature_id: number
          note?: string | null
          project_id: number
        }
        Update: {
          feature_id?: number
          note?: string | null
          project_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "project_feature_feature_id_fkey"
            columns: ["feature_id"]
            isOneToOne: false
            referencedRelation: "features"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "project_feature_project_id_fkey"
            columns: ["project_id"]
            isOneToOne: false
            referencedRelation: "projects"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "project_feature_project_id_fkey"
            columns: ["project_id"]
            isOneToOne: false
            referencedRelation: "v_project_card_published"
            referencedColumns: ["id"]
          },
        ]
      }
      project_media: {
        Row: {
          is_cover: boolean | null
          media_id: number
          note: string | null
          project_id: number
          sort_order: number | null
        }
        Insert: {
          is_cover?: boolean | null
          media_id: number
          note?: string | null
          project_id: number
          sort_order?: number | null
        }
        Update: {
          is_cover?: boolean | null
          media_id?: number
          note?: string | null
          project_id?: number
          sort_order?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "project_media_media_id_fkey"
            columns: ["media_id"]
            isOneToOne: false
            referencedRelation: "media_assets"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "project_media_project_id_fkey"
            columns: ["project_id"]
            isOneToOne: false
            referencedRelation: "projects"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "project_media_project_id_fkey"
            columns: ["project_id"]
            isOneToOne: false
            referencedRelation: "v_project_card_published"
            referencedColumns: ["id"]
          },
        ]
      }
      project_style: {
        Row: {
          confidence: string | null
          note: string | null
          project_id: number
          style_id: number
        }
        Insert: {
          confidence?: string | null
          note?: string | null
          project_id: number
          style_id: number
        }
        Update: {
          confidence?: string | null
          note?: string | null
          project_id?: number
          style_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "project_style_project_id_fkey"
            columns: ["project_id"]
            isOneToOne: false
            referencedRelation: "projects"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "project_style_project_id_fkey"
            columns: ["project_id"]
            isOneToOne: false
            referencedRelation: "v_project_card_published"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "project_style_style_id_fkey"
            columns: ["style_id"]
            isOneToOne: false
            referencedRelation: "styles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "project_style_style_id_fkey"
            columns: ["style_id"]
            isOneToOne: false
            referencedRelation: "v_style_card_published"
            referencedColumns: ["id"]
          },
        ]
      }
      projects: {
        Row: {
          city: string | null
          country: string | null
          created_at: string | null
          description_short: string | null
          id: number
          is_published: boolean | null
          lat: number | null
          lon: number | null
          project_kind: Database["public"]["Enums"]["project_kind"] | null
          slogan_language: string | null
          slogan_original: string | null
          slogan_ru: string | null
          slogan_source_url: string | null
          slug: string
          title_original: string
          title_ru: string | null
          typology: string | null
          updated_at: string | null
          wiki_url: string | null
          year_end: number | null
          year_start: number | null
        }
        Insert: {
          city?: string | null
          country?: string | null
          created_at?: string | null
          description_short?: string | null
          id?: number
          is_published?: boolean | null
          lat?: number | null
          lon?: number | null
          project_kind?: Database["public"]["Enums"]["project_kind"] | null
          slogan_language?: string | null
          slogan_original?: string | null
          slogan_ru?: string | null
          slogan_source_url?: string | null
          slug: string
          title_original: string
          title_ru?: string | null
          typology?: string | null
          updated_at?: string | null
          wiki_url?: string | null
          year_end?: number | null
          year_start?: number | null
        }
        Update: {
          city?: string | null
          country?: string | null
          created_at?: string | null
          description_short?: string | null
          id?: number
          is_published?: boolean | null
          lat?: number | null
          lon?: number | null
          project_kind?: Database["public"]["Enums"]["project_kind"] | null
          slogan_language?: string | null
          slogan_original?: string | null
          slogan_ru?: string | null
          slogan_source_url?: string | null
          slug?: string
          title_original?: string
          title_ru?: string | null
          typology?: string | null
          updated_at?: string | null
          wiki_url?: string | null
          year_end?: number | null
          year_start?: number | null
        }
        Relationships: []
      }
      reference_author: {
        Row: {
          author_id: number
          reference_id: number
          role: string
        }
        Insert: {
          author_id: number
          reference_id: number
          role?: string
        }
        Update: {
          author_id?: number
          reference_id?: number
          role?: string
        }
        Relationships: [
          {
            foreignKeyName: "reference_author_author_id_fkey"
            columns: ["author_id"]
            isOneToOne: false
            referencedRelation: "authors"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "reference_author_reference_id_fkey"
            columns: ["reference_id"]
            isOneToOne: false
            referencedRelation: "reference_entries"
            referencedColumns: ["id"]
          },
        ]
      }
      reference_entries: {
        Row: {
          commentary: string | null
          created_at: string | null
          href: string | null
          id: number
          is_published: boolean | null
          kind: Database["public"]["Enums"]["reference_kind"]
          original_language: string | null
          reliability: string | null
          slug: string
          subtype: string | null
          text_original: string | null
          text_ru: string | null
          title_original: string | null
          title_ru: string | null
          updated_at: string | null
          year: number | null
        }
        Insert: {
          commentary?: string | null
          created_at?: string | null
          href?: string | null
          id?: number
          is_published?: boolean | null
          kind: Database["public"]["Enums"]["reference_kind"]
          original_language?: string | null
          reliability?: string | null
          slug: string
          subtype?: string | null
          text_original?: string | null
          text_ru?: string | null
          title_original?: string | null
          title_ru?: string | null
          updated_at?: string | null
          year?: number | null
        }
        Update: {
          commentary?: string | null
          created_at?: string | null
          href?: string | null
          id?: number
          is_published?: boolean | null
          kind?: Database["public"]["Enums"]["reference_kind"]
          original_language?: string | null
          reliability?: string | null
          slug?: string
          subtype?: string | null
          text_original?: string | null
          text_ru?: string | null
          title_original?: string | null
          title_ru?: string | null
          updated_at?: string | null
          year?: number | null
        }
        Relationships: []
      }
      style_reference: {
        Row: {
          is_primary: boolean | null
          note: string | null
          reference_id: number
          relation_type: string
          sort_order: number | null
          style_id: number
        }
        Insert: {
          is_primary?: boolean | null
          note?: string | null
          reference_id: number
          relation_type: string
          sort_order?: number | null
          style_id: number
        }
        Update: {
          is_primary?: boolean | null
          note?: string | null
          reference_id?: number
          relation_type?: string
          sort_order?: number | null
          style_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "style_reference_reference_id_fkey"
            columns: ["reference_id"]
            isOneToOne: false
            referencedRelation: "reference_entries"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "style_reference_style_id_fkey"
            columns: ["style_id"]
            isOneToOne: false
            referencedRelation: "styles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "style_reference_style_id_fkey"
            columns: ["style_id"]
            isOneToOne: false
            referencedRelation: "v_style_card_published"
            referencedColumns: ["id"]
          },
        ]
      }
      styles: {
        Row: {
          color: string | null
          created_at: string | null
          date_end_year: number | null
          date_start_year: number | null
          description: string | null
          id: number
          image_media_id: number | null
          is_published: boolean | null
          one_liner: string | null
          slug: string
          title_en: string | null
          title_ru: string
          updated_at: string | null
        }
        Insert: {
          color?: string | null
          created_at?: string | null
          date_end_year?: number | null
          date_start_year?: number | null
          description?: string | null
          id?: number
          image_media_id?: number | null
          is_published?: boolean | null
          one_liner?: string | null
          slug: string
          title_en?: string | null
          title_ru: string
          updated_at?: string | null
        }
        Update: {
          color?: string | null
          created_at?: string | null
          date_end_year?: number | null
          date_start_year?: number | null
          description?: string | null
          id?: number
          image_media_id?: number | null
          is_published?: boolean | null
          one_liner?: string | null
          slug?: string
          title_en?: string | null
          title_ru?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "styles_image_media_id_fkey"
            columns: ["image_media_id"]
            isOneToOne: false
            referencedRelation: "media_assets"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      v_project_card_published: {
        Row: {
          authors: Json | null
          city: string | null
          country: string | null
          description_short: string | null
          id: number | null
          slug: string | null
          styles: Json | null
          title_original: string | null
          title_ru: string | null
          typology: string | null
          wiki_url: string | null
          year_end: number | null
          year_start: number | null
        }
        Insert: {
          authors?: never
          city?: string | null
          country?: string | null
          description_short?: string | null
          id?: number | null
          slug?: string | null
          styles?: never
          title_original?: string | null
          title_ru?: string | null
          typology?: string | null
          wiki_url?: string | null
          year_end?: number | null
          year_start?: number | null
        }
        Update: {
          authors?: never
          city?: string | null
          country?: string | null
          description_short?: string | null
          id?: number | null
          slug?: string | null
          styles?: never
          title_original?: string | null
          title_ru?: string | null
          typology?: string | null
          wiki_url?: string | null
          year_end?: number | null
          year_start?: number | null
        }
        Relationships: []
      }
      v_style_card_published: {
        Row: {
          date_end_year: number | null
          date_start_year: number | null
          description: string | null
          id: number | null
          key_text: Json | null
          one_liner: string | null
          phenomena: Json | null
          projects: Json | null
          slogans: Json | null
          slug: string | null
          title_en: string | null
          title_ru: string | null
        }
        Insert: {
          date_end_year?: number | null
          date_start_year?: number | null
          description?: string | null
          id?: number | null
          key_text?: never
          one_liner?: string | null
          phenomena?: never
          projects?: never
          slogans?: never
          slug?: string | null
          title_en?: string | null
          title_ru?: string | null
        }
        Update: {
          date_end_year?: number | null
          date_start_year?: number | null
          description?: string | null
          id?: number | null
          key_text?: never
          one_liner?: string | null
          phenomena?: never
          projects?: never
          slogans?: never
          slug?: string | null
          title_en?: string | null
          title_ru?: string | null
        }
        Relationships: []
      }
    }
    Functions: {
      whoami: { Args: never; Returns: Json }
    }
    Enums: {
      author_entity_type: "person" | "organization"
      media_kind:
        | "photo"
        | "sketch"
        | "drawing"
        | "technical_scheme"
        | "render"
        | "other"
      project_kind:
        | "urban_concept"
        | "environment_object"
        | "architecture_object"
        | "memorandum"
        | "theory_concept"
        | "competition_entry"
        | "study_work"
      reference_kind: "quote" | "text"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      author_entity_type: ["person", "organization"],
      media_kind: [
        "photo",
        "sketch",
        "drawing",
        "technical_scheme",
        "render",
        "other",
      ],
      project_kind: [
        "urban_concept",
        "environment_object",
        "architecture_object",
        "memorandum",
        "theory_concept",
        "competition_entry",
        "study_work",
      ],
      reference_kind: ["quote", "text"],
    },
  },
} as const
