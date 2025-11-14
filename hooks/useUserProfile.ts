import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';
import { useSupabase } from './useSupabase';

export interface UserProfile {
  id: string;
  username: string;
  display_name: string | null;
  avatar_url: string | null;
  bio: string | null;
  level: number;
  xp: number;
  streak_count: number;
  longest_streak: number;
  last_active_date: string;
  tier: 'free' | 'premium';
  joined_at: string;
  updated_at: string;
}

export function useUserProfile() {
  const { user } = useSupabase();
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const supabase = createClient();

  useEffect(() => {
    if (!user) {
      setProfile(null);
      setLoading(false);
      return;
    }

    async function fetchProfile() {
      try {
        setLoading(true);
        const { data, error } = await supabase
          .from('profiles')
          .select('*')
          .eq('id', user!.id)
          .single();

        if (error) throw error;
        setProfile(data);
      } catch (err: any) {
        console.error('Error fetching profile:', err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    fetchProfile();

    // Subscribe to profile changes
    const subscription = supabase
      .channel(`profile:${user!.id}`)
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'profiles',
          filter: `id=eq.${user!.id}`,
        },
        (payload) => {
          setProfile(payload.new as UserProfile);
        }
      )
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, [user, supabase]);

  return { profile, loading, error };
}
