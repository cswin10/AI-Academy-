import { createClient } from './supabase/client';

// XP Rewards Configuration
export const XP_REWARDS = {
  COMPLETE_CHECKLIST_ITEM: 10,
  COMPLETE_SECTION: 25,
  COMPLETE_MODULE: 100,
  COMPLETE_PROJECT: 250,
  COMPLETE_ALL_MODULES: 1000,
  DAILY_LOGIN: 5,
  STREAK_7_DAYS: 50,
  STREAK_14_DAYS: 100,
  STREAK_30_DAYS: 200,
  STREAK_60_DAYS: 400,
  STREAK_100_DAYS: 750,
  FIRST_MODULE: 50,
  HELP_ANOTHER_USER: 15,
  SHARE_PROJECT: 25,
} as const;

// Level Thresholds (XP required to reach each level)
export const LEVEL_THRESHOLDS: { [level: number]: number } = {
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

// Calculate level from XP
export const calculateLevel = (xp: number): number => {
  let level = 1;
  for (let l = 50; l >= 1; l--) {
    if (xp >= (LEVEL_THRESHOLDS[l] || 0)) {
      level = l;
      break;
    }
  }
  return level;
};

// Get XP required for next level
export const getXPForNextLevel = (currentLevel: number): number => {
  if (currentLevel >= 50) return LEVEL_THRESHOLDS[50];
  return LEVEL_THRESHOLDS[currentLevel + 1] || LEVEL_THRESHOLDS[50];
};

// Get XP progress to next level (0-100%)
export const getLevelProgress = (xp: number, currentLevel: number): number => {
  if (currentLevel >= 50) return 100;

  const currentLevelXP = LEVEL_THRESHOLDS[currentLevel];
  const nextLevelXP = LEVEL_THRESHOLDS[currentLevel + 1];
  const progressXP = xp - currentLevelXP;
  const requiredXP = nextLevelXP - currentLevelXP;

  return Math.min(100, Math.round((progressXP / requiredXP) * 100));
};

// Award XP to user
export const awardXP = async (
  userId: string,
  amount: number,
  reason: string,
  moduleId?: string
): Promise<{ success: boolean; newXP: number; newLevel: number; leveledUp: boolean }> => {
  const supabase = createClient();

  try {
    // Get current user data
    const { data: profile, error: profileError } = await supabase
      .from('profiles')
      .select('xp, level')
      .eq('id', userId)
      .single() as { data: { xp: number; level: number } | null; error: any };

    if (profileError || !profile) {
      throw new Error('Failed to fetch user profile');
    }

    const oldLevel = profile.level;
    const newXP = profile.xp + amount;
    const newLevel = calculateLevel(newXP);
    const leveledUp = newLevel > oldLevel;

    // Update user XP and level
    const { error: updateError } = await supabase
      .from('profiles')
      .update({ xp: newXP, level: newLevel })
      .eq('id', userId);

    if (updateError) {
      throw updateError;
    }

    // Insert XP transaction
    await supabase.from('xp_transactions').insert({
      user_id: userId,
      amount,
      reason,
      module_id: moduleId || null,
    });

    // Check for new badges/achievements
    await checkAndAwardBadges(userId);

    return {
      success: true,
      newXP,
      newLevel,
      leveledUp,
    };
  } catch (error) {
    console.error('Error awarding XP:', error);
    return {
      success: false,
      newXP: 0,
      newLevel: 1,
      leveledUp: false,
    };
  }
};

// Update user streak
export const updateStreak = async (userId: string): Promise<void> => {
  const supabase = createClient();

  try {
    const { data: profile, error } = await supabase
      .from('profiles')
      .select('last_active_date, streak_count, longest_streak')
      .eq('id', userId)
      .single();

    if (error || !profile) return;

    const today = new Date().toISOString().split('T')[0];
    const lastActive = profile.last_active_date;

    // Check if already logged in today
    if (lastActive === today) return;

    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    const yesterdayStr = yesterday.toISOString().split('T')[0];

    let newStreak = 1;
    if (lastActive === yesterdayStr) {
      // Continuing streak
      newStreak = profile.streak_count + 1;
    }

    const longestStreak = Math.max(profile.longest_streak, newStreak);

    // Update profile
    await supabase
      .from('profiles')
      .update({
        streak_count: newStreak,
        longest_streak: longestStreak,
        last_active_date: today,
      })
      .eq('id', userId);

    // Award streak XP
    if (newStreak === 7) {
      await awardXP(userId, XP_REWARDS.STREAK_7_DAYS, '7-day streak');
    } else if (newStreak === 14) {
      await awardXP(userId, XP_REWARDS.STREAK_14_DAYS, '14-day streak');
    } else if (newStreak === 30) {
      await awardXP(userId, XP_REWARDS.STREAK_30_DAYS, '30-day streak');
    } else if (newStreak === 60) {
      await awardXP(userId, XP_REWARDS.STREAK_60_DAYS, '60-day streak');
    } else if (newStreak === 100) {
      await awardXP(userId, XP_REWARDS.STREAK_100_DAYS, '100-day streak');
    } else {
      // Daily login bonus
      await awardXP(userId, XP_REWARDS.DAILY_LOGIN, 'Daily login');
    }
  } catch (error) {
    console.error('Error updating streak:', error);
  }
};

// Check and award badges based on user progress
export const checkAndAwardBadges = async (userId: string): Promise<void> => {
  const supabase = createClient();

  try {
    // Get user data
    const { data: profile } = await supabase
      .from('profiles')
      .select('xp, level, streak_count')
      .eq('id', userId)
      .single();

    if (!profile) return;

    // Get completed modules count
    const { data: completedModules } = await supabase
      .from('module_progress')
      .select('id')
      .eq('user_id', userId)
      .not('completed_at', 'is', null);

    const modulesCompleted = completedModules?.length || 0;

    // Get all badges
    const { data: badges } = await supabase
      .from('badges')
      .select('id, slug, xp_reward');

    if (!badges) return;

    // Get user's current badges
    const { data: userBadges } = await supabase
      .from('user_badges')
      .select('badge_id')
      .eq('user_id', userId);

    const earnedBadgeIds = new Set(userBadges?.map(ub => ub.badge_id) || []);

    // Check badge conditions and award if met
    const badgesToAward: string[] = [];

    for (const badge of badges) {
      if (earnedBadgeIds.has(badge.id)) continue;

      let shouldAward = false;

      switch (badge.slug) {
        case 'first-steps':
          shouldAward = modulesCompleted >= 1;
          break;
        case 'getting-started':
          shouldAward = modulesCompleted >= 3;
          break;
        case 'dedicated-learner':
          shouldAward = modulesCompleted >= 5;
          break;
        case 'week-warrior':
          shouldAward = profile.streak_count >= 7;
          break;
        case 'dedicated':
          shouldAward = profile.streak_count >= 14;
          break;
        case 'unstoppable':
          shouldAward = profile.streak_count >= 30;
          break;
        case 'legendary-streak':
          shouldAward = profile.streak_count >= 100;
          break;
        case 'completionist':
          shouldAward = modulesCompleted >= 15;
          break;
        case 'rising-star':
          shouldAward = profile.xp >= 1000;
          break;
        case 'experienced':
          shouldAward = profile.xp >= 5000;
          break;
        case 'expert':
          shouldAward = profile.xp >= 10000;
          break;
        case 'master':
          shouldAward = profile.xp >= 25000;
          break;
        case 'level-10':
          shouldAward = profile.level >= 10;
          break;
        case 'level-20':
          shouldAward = profile.level >= 20;
          break;
        case 'level-30':
          shouldAward = profile.level >= 30;
          break;
        case 'level-40':
          shouldAward = profile.level >= 40;
          break;
        case 'level-50':
          shouldAward = profile.level >= 50;
          break;
      }

      if (shouldAward) {
        badgesToAward.push(badge.id);

        // Award badge XP
        if (badge.xp_reward > 0) {
          await awardXP(userId, badge.xp_reward, `Earned badge: ${badge.slug}`);
        }
      }
    }

    // Insert earned badges
    if (badgesToAward.length > 0) {
      await supabase.from('user_badges').insert(
        badgesToAward.map(badgeId => ({
          user_id: userId,
          badge_id: badgeId,
        }))
      );
    }
  } catch (error) {
    console.error('Error checking badges:', error);
  }
};

// Get user's gamification stats
export interface GamificationStats {
  level: number;
  xp: number;
  xpForNextLevel: number;
  levelProgress: number;
  streakCount: number;
  longestStreak: number;
  badgesEarned: number;
  modulesCompleted: number;
  rank: number | null;
}

export const getGamificationStats = async (userId: string): Promise<GamificationStats | null> => {
  const supabase = createClient();

  try {
    // Get profile
    const { data: profile } = await supabase
      .from('profiles')
      .select('level, xp, streak_count, longest_streak')
      .eq('id', userId)
      .single();

    if (!profile) return null;

    // Get badges count
    const { data: badges } = await supabase
      .from('user_badges')
      .select('id')
      .eq('user_id', userId);

    // Get completed modules count
    const { data: modules } = await supabase
      .from('module_progress')
      .select('id')
      .eq('user_id', userId)
      .not('completed_at', 'is', null);

    // Get user rank from leaderboard
    const { data: leaderboard } = await supabase
      .from('leaderboard')
      .select('rank')
      .eq('id', userId)
      .single();

    const xpForNextLevel = getXPForNextLevel(profile.level);
    const levelProgress = getLevelProgress(profile.xp, profile.level);

    return {
      level: profile.level,
      xp: profile.xp,
      xpForNextLevel,
      levelProgress,
      streakCount: profile.streak_count,
      longestStreak: profile.longest_streak,
      badgesEarned: badges?.length || 0,
      modulesCompleted: modules?.length || 0,
      rank: leaderboard?.rank || null,
    };
  } catch (error) {
    console.error('Error fetching gamification stats:', error);
    return null;
  }
};
