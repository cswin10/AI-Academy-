import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';
import { useSupabase } from './useSupabase';

export interface Badge {
  id: string;
  slug: string;
  name: string;
  description: string;
  icon: string;
  rarity: 'common' | 'rare' | 'epic' | 'legendary';
  requirements: any;
  xp_reward: number;
  created_at: string;
}

export interface UserBadge extends Badge {
  earned_at: string;
}

export function useBadges() {
  const { user } = useSupabase();
  const [allBadges, setAllBadges] = useState<Badge[]>([]);
  const [userBadges, setUserBadges] = useState<UserBadge[]>([]);
  const [loading, setLoading] = useState(true);
  const supabase = createClient();

  useEffect(() => {
    async function fetchBadges() {
      try {
        setLoading(true);

        // Fetch all badges
        const { data: badges } = await supabase
          .from('badges')
          .select('*')
          .order('xp_reward', { ascending: true });

        if (badges) {
          setAllBadges(badges);
        }

        // Fetch user's badges if logged in
        if (user) {
          const { data: earned } = await supabase
            .from('user_badges')
            .select(`
              *,
              badge:badge_id (
                *
              )
            `)
            .eq('user_id', user.id);

          if (earned) {
            const formatted = earned.map((e: any) => ({
              ...e.badge,
              earned_at: e.earned_at,
            }));
            setUserBadges(formatted);
          }
        }
      } catch (err) {
        console.error('Error fetching badges:', err);
      } finally {
        setLoading(false);
      }
    }

    fetchBadges();

    if (user) {
      // Subscribe to new badges
      const subscription = supabase
        .channel(`user_badges:${user.id}`)
        .on(
          'postgres_changes',
          {
            event: 'INSERT',
            schema: 'public',
            table: 'user_badges',
            filter: `user_id=eq.${user.id}`,
          },
          async (payload) => {
            // Fetch the full badge details
            const { data: badge } = await supabase
              .from('badges')
              .select('*')
              .eq('id', payload.new.badge_id)
              .single();

            if (badge) {
              setUserBadges(prev => [
                ...prev,
                { ...badge, earned_at: payload.new.earned_at }
              ]);
            }
          }
        )
        .subscribe();

      return () => {
        subscription.unsubscribe();
      };
    }
  }, [user, supabase]);

  const hasBadge = (slug: string) => {
    return userBadges.some(b => b.slug === slug);
  };

  const getBadgesByRarity = (rarity: Badge['rarity']) => {
    return allBadges.filter(b => b.rarity === rarity);
  };

  const earnedBadgesByRarity = (rarity: Badge['rarity']) => {
    return userBadges.filter(b => b.rarity === rarity);
  };

  return {
    allBadges,
    userBadges,
    loading,
    hasBadge,
    getBadgesByRarity,
    earnedBadgesByRarity,
    badgeCount: userBadges.length,
    totalBadges: allBadges.length,
  };
}
