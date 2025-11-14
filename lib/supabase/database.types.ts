export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string
          username: string
          display_name: string | null
          avatar_url: string | null
          bio: string | null
          level: number
          xp: number
          streak_count: number
          longest_streak: number
          last_active_date: string
          tier: 'free' | 'premium'
          joined_at: string
          updated_at: string
        }
        Insert: {
          id: string
          username: string
          display_name?: string | null
          avatar_url?: string | null
          bio?: string | null
          level?: number
          xp?: number
          streak_count?: number
          longest_streak?: number
          last_active_date?: string
          tier?: 'free' | 'premium'
          joined_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          username?: string
          display_name?: string | null
          avatar_url?: string | null
          bio?: string | null
          level?: number
          xp?: number
          streak_count?: number
          longest_streak?: number
          last_active_date?: string
          tier?: 'free' | 'premium'
          joined_at?: string
          updated_at?: string
        }
      }
      module_progress: {
        Row: {
          id: string
          user_id: string
          module_id: string
          started_at: string
          completed_at: string | null
          time_spent_seconds: number
          completion_percentage: number
          last_accessed: string
        }
        Insert: {
          id?: string
          user_id: string
          module_id: string
          started_at?: string
          completed_at?: string | null
          time_spent_seconds?: number
          completion_percentage?: number
          last_accessed?: string
        }
        Update: {
          id?: string
          user_id?: string
          module_id?: string
          started_at?: string
          completed_at?: string | null
          time_spent_seconds?: number
          completion_percentage?: number
          last_accessed?: string
        }
      }
      checklist_progress: {
        Row: {
          id: string
          user_id: string
          module_id: string
          checklist_item_id: string
          completed_at: string
          xp_awarded: number
        }
        Insert: {
          id?: string
          user_id: string
          module_id: string
          checklist_item_id: string
          completed_at?: string
          xp_awarded?: number
        }
        Update: {
          id?: string
          user_id?: string
          module_id?: string
          checklist_item_id?: string
          completed_at?: string
          xp_awarded?: number
        }
      }
      badges: {
        Row: {
          id: string
          slug: string
          name: string
          description: string
          icon: string
          rarity: 'common' | 'rare' | 'epic' | 'legendary'
          requirements: Json | null
          xp_reward: number
          created_at: string
        }
        Insert: {
          id?: string
          slug: string
          name: string
          description: string
          icon: string
          rarity?: 'common' | 'rare' | 'epic' | 'legendary'
          requirements?: Json | null
          xp_reward?: number
          created_at?: string
        }
        Update: {
          id?: string
          slug?: string
          name?: string
          description?: string
          icon?: string
          rarity?: 'common' | 'rare' | 'epic' | 'legendary'
          requirements?: Json | null
          xp_reward?: number
          created_at?: string
        }
      }
      user_badges: {
        Row: {
          id: string
          user_id: string
          badge_id: string
          earned_at: string
        }
        Insert: {
          id?: string
          user_id: string
          badge_id: string
          earned_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          badge_id?: string
          earned_at?: string
        }
      }
      achievements: {
        Row: {
          id: string
          slug: string
          name: string
          description: string
          icon: string
          category: string
          points: number
          max_progress: number
          created_at: string
        }
        Insert: {
          id?: string
          slug: string
          name: string
          description: string
          icon: string
          category: string
          points?: number
          max_progress?: number
          created_at?: string
        }
        Update: {
          id?: string
          slug?: string
          name?: string
          description?: string
          icon?: string
          category?: string
          points?: number
          max_progress?: number
          created?: string
        }
      }
      user_achievements: {
        Row: {
          id: string
          user_id: string
          achievement_id: string
          progress: number
          unlocked_at: string | null
        }
        Insert: {
          id?: string
          user_id: string
          achievement_id: string
          progress?: number
          unlocked_at?: string | null
        }
        Update: {
          id?: string
          user_id?: string
          achievement_id?: string
          progress?: number
          unlocked_at?: string | null
        }
      }
      xp_transactions: {
        Row: {
          id: string
          user_id: string
          amount: number
          reason: string
          module_id: string | null
          metadata: Json | null
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          amount: number
          reason: string
          module_id?: string | null
          metadata?: Json | null
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          amount?: number
          reason?: string
          module_id?: string | null
          metadata?: Json | null
          created_at?: string
        }
      }
      certificates: {
        Row: {
          id: string
          user_id: string
          module_id: string
          issued_at: string
          certificate_url: string | null
        }
        Insert: {
          id?: string
          user_id: string
          module_id: string
          issued_at?: string
          certificate_url?: string | null
        }
        Update: {
          id?: string
          user_id?: string
          module_id?: string
          issued_at?: string
          certificate_url?: string | null
        }
      }
    }
    Views: {
      leaderboard: {
        Row: {
          id: string
          username: string
          display_name: string | null
          avatar_url: string | null
          level: number
          xp: number
          streak_count: number
          modules_completed: number
          rank: number
        }
      }
    }
    Functions: {
      award_xp: {
        Args: {
          p_user_id: string
          p_amount: number
          p_reason: string
          p_module_id?: string
        }
        Returns: void
      }
    }
  }
}
