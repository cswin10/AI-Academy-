import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';

export interface LeaderboardEntry {
  id: string;
  username: string;
  display_name: string | null;
  avatar_url: string | null;
  level: number;
  xp: number;
  streak_count: number;
  modules_completed: number;
  rank: number;
}

export function useLeaderboard(limit: number = 100) {
  const [entries, setEntries] = useState<LeaderboardEntry[]>([]);
  const [loading, setLoading] = useState(true);
  const supabase = createClient();

  useEffect(() => {
    async function fetchLeaderboard() {
      try {
        setLoading(true);
        const { data, error } = await supabase
          .from('leaderboard')
          .select('*')
          .limit(limit);

        if (error) throw error;
        setEntries(data || []);
      } catch (err) {
        console.error('Error fetching leaderboard:', err);
      } finally {
        setLoading(false);
      }
    }

    fetchLeaderboard();

    // Refresh every 5 minutes
    const interval = setInterval(fetchLeaderboard, 5 * 60 * 1000);

    return () => clearInterval(interval);
  }, [limit, supabase]);

  return {
    entries,
    loading,
  };
}
