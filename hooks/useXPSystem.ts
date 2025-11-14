import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';
import { useUserProfile } from './useUserProfile';
import { useSupabase } from './useSupabase';

export interface XPTransaction {
  id: string;
  user_id: string;
  amount: number;
  reason: string;
  module_id: string | null;
  metadata: any;
  created_at: string;
}

// XP required for each level
const LEVEL_THRESHOLDS: { [key: number]: number } = {
  1: 0,
  2: 100,
  3: 250,
  4: 450,
  5: 700,
  6: 1000,
  7: 1350,
  8: 1750,
  9: 2200,
  10: 2700,
  11: 3250,
  12: 3850,
  13: 4500,
  14: 5200,
  15: 5950,
  16: 6750,
  17: 7600,
  18: 8500,
  19: 9450,
  20: 10500,
  25: 15000,
  30: 20000,
  35: 26000,
  40: 33000,
  45: 41000,
  50: 50000,
};

export function useXPSystem() {
  const { profile } = useUserProfile();
  const { user } = useSupabase();
  const [recentTransactions, setRecentTransactions] = useState<XPTransaction[]>([]);
  const [loading, setLoading] = useState(false);
  const supabase = createClient();

  useEffect(() => {
    if (!user) {
      setRecentTransactions([]);
      return;
    }

    async function fetchRecent() {
      const { data } = await supabase
        .from('xp_transactions')
        .select('*')
        .eq('user_id', user!.id)
        .order('created_at', { ascending: false })
        .limit(10);

      if (data) {
        setRecentTransactions(data);
      }
    }

    fetchRecent();

    // Subscribe to new XP
    const subscription = supabase
      .channel(`xp_transactions:${user!.id}`)
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'xp_transactions',
          filter: `user_id=eq.${user!.id}`,
        },
        (payload) => {
          setRecentTransactions(prev => [payload.new as XPTransaction, ...prev].slice(0, 10));
        }
      )
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, [user, supabase]);

  const awardXP = async (amount: number, reason: string, moduleId?: string) => {
    if (!user) return;

    try {
      setLoading(true);
      const { error } = await supabase.rpc('award_xp', {
        p_user_id: user.id,
        p_amount: amount,
        p_reason: reason,
        p_module_id: moduleId || null,
      });

      if (error) throw error;
      return true;
    } catch (err) {
      console.error('Error awarding XP:', err);
      return false;
    } finally {
      setLoading(false);
    }
  };

  const getXPForNextLevel = () => {
    if (!profile) return 0;

    const currentLevel = profile.level;
    const nextLevel = currentLevel + 1;

    if (nextLevel > 50) return 0;

    // Find exact threshold for next level
    if (LEVEL_THRESHOLDS[nextLevel]) {
      return LEVEL_THRESHOLDS[nextLevel];
    }

    // Calculate based on formula
    if (nextLevel <= 10) {
      return nextLevel * 100;
    } else if (nextLevel <= 26) {
      return 1000 + (nextLevel - 10) * 250;
    } else if (nextLevel <= 46) {
      return 5000 + (nextLevel - 26) * 500;
    } else {
      return 15000 + (nextLevel - 46) * 1000;
    }
  };

  const getProgressToNextLevel = () => {
    if (!profile) return 0;

    const currentLevelXP = LEVEL_THRESHOLDS[profile.level] || 0;
    const nextLevelXP = getXPForNextLevel();

    if (nextLevelXP === 0) return 100; // Max level

    const xpInCurrentLevel = profile.xp - currentLevelXP;
    const xpNeededForLevel = nextLevelXP - currentLevelXP;

    return Math.floor((xpInCurrentLevel / xpNeededForLevel) * 100);
  };

  const getXPToNextLevel = () => {
    if (!profile) return 0;
    const nextLevelXP = getXPForNextLevel();
    return Math.max(0, nextLevelXP - profile.xp);
  };

  return {
    currentXP: profile?.xp || 0,
    currentLevel: profile?.level || 1,
    xpForNextLevel: getXPForNextLevel(),
    xpToNextLevel: getXPToNextLevel(),
    progressToNextLevel: getProgressToNextLevel(),
    recentTransactions,
    loading,
    awardXP,
  };
}
