import { useEffect } from 'react';
import { createClient } from '@/lib/supabase/client';
import { useUserProfile } from './useUserProfile';
import { useSupabase } from './useSupabase';

export function useStreak() {
  const { profile } = useUserProfile();
  const { user } = useSupabase();
  const supabase = createClient();

  // Update streak on mount (daily login)
  useEffect(() => {
    if (!user) return;

    async function updateStreak() {
      try {
        const { error } = await supabase.rpc('update_user_streak', {
          p_user_id: user.id,
        });

        if (error) throw error;
      } catch (err) {
        console.error('Error updating streak:', err);
      }
    }

    // Only update once per session
    const hasUpdatedToday = sessionStorage.getItem('streak_updated_today');
    if (!hasUpdatedToday) {
      updateStreak();
      sessionStorage.setItem('streak_updated_today', 'true');
    }
  }, [user, supabase]);

  return {
    currentStreak: profile?.streak_count || 0,
    longestStreak: profile?.longest_streak || 0,
    lastActive: profile?.last_active_date,
  };
}
