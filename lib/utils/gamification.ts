import { LevelInfo, StreakInfo, Profile, Achievement } from '@/lib/types'

// XP thresholds for each level
const LEVEL_THRESHOLDS = [
  0,      // Level 1: 0-100
  100,    // Level 2: 100-250
  250,    // Level 3: 250-500
  500,    // Level 4: 500-1000
  1000,   // Level 5: 1000-2000
  2000,   // Level 6: 2000-3500
  3500,   // Level 7: 3500-5500
  5500,   // Level 8: 5500-8000
  8000,   // Level 9: 8000-12000
  12000,  // Level 10: 12000+
]

export function calculateLevel(xp: number): LevelInfo {
  let level = 1

  for (let i = 1; i < LEVEL_THRESHOLDS.length; i++) {
    if (xp >= LEVEL_THRESHOLDS[i]) {
      level = i + 1
    } else {
      break
    }
  }

  const xpForCurrentLevel = LEVEL_THRESHOLDS[level - 1] || 0
  const xpForNextLevel = LEVEL_THRESHOLDS[level] || xpForCurrentLevel + 5000
  const xpIntoLevel = xp - xpForCurrentLevel
  const xpNeededForLevel = xpForNextLevel - xpForCurrentLevel
  const progress = Math.min(100, (xpIntoLevel / xpNeededForLevel) * 100)

  return {
    level,
    currentXP: xp,
    xpForCurrentLevel,
    xpForNextLevel,
    progress,
  }
}

export function getStreakInfo(profile: Profile): StreakInfo {
  const today = new Date().toISOString().split('T')[0]
  const isActiveToday = profile.last_active_date === today

  return {
    currentStreak: profile.current_streak,
    longestStreak: profile.longest_streak,
    lastActiveDate: profile.last_active_date,
    isActiveToday,
  }
}

export function shouldUpdateStreak(lastActiveDate: string | null): 'increment' | 'reset' | 'none' {
  if (!lastActiveDate) {
    return 'increment'
  }

  const today = new Date()
  today.setHours(0, 0, 0, 0)

  const lastActive = new Date(lastActiveDate)
  lastActive.setHours(0, 0, 0, 0)

  const diffDays = Math.floor((today.getTime() - lastActive.getTime()) / (1000 * 60 * 60 * 24))

  if (diffDays === 0) {
    return 'none' // Already active today
  } else if (diffDays === 1) {
    return 'increment' // Consecutive day
  } else {
    return 'reset' // Streak broken
  }
}

// Achievement checking logic
export interface AchievementCheckResult {
  unlocked: Achievement[]
  updated: { achievementId: string; progress: number }[]
}

export function getStreakAchievementCodes(streak: number): string[] {
  const codes: string[] = []
  if (streak >= 3) codes.push('STREAK_3')
  if (streak >= 7) codes.push('STREAK_7')
  if (streak >= 14) codes.push('STREAK_14')
  if (streak >= 30) codes.push('STREAK_30')
  return codes
}

export function getCompletionAchievementCodes(
  type: 'section' | 'module',
  count: number
): string[] {
  const codes: string[] = []

  if (type === 'section') {
    if (count >= 1) codes.push('FIRST_SECTION')
  } else if (type === 'module') {
    if (count >= 1) codes.push('FIRST_MODULE')
    if (count >= 5) codes.push('FIVE_MODULES')
  }

  return codes
}

export function getPerfectionAchievementCodes(perfectQuizCount: number): string[] {
  const codes: string[] = []
  if (perfectQuizCount >= 1) codes.push('PERFECT_QUIZ')
  if (perfectQuizCount >= 5) codes.push('PERFECT_FIVE')
  return codes
}

// Format XP for display
export function formatXP(xp: number): string {
  if (xp >= 1000000) {
    return `${(xp / 1000000).toFixed(1)}M`
  } else if (xp >= 1000) {
    return `${(xp / 1000).toFixed(1)}K`
  }
  return xp.toString()
}

// Get level title based on level number
export function getLevelTitle(level: number): string {
  const titles: Record<number, string> = {
    1: 'Novice',
    2: 'Apprentice',
    3: 'Operator',
    4: 'Specialist',
    5: 'Expert',
    6: 'Master',
    7: 'Architect',
    8: 'Virtuoso',
    9: 'Legend',
    10: 'Grandmaster',
  }
  return titles[level] || 'Grandmaster'
}

// Get rarity color
export function getRarityColor(rarity: Achievement['rarity']): string {
  const colors: Record<Achievement['rarity'], string> = {
    common: '#94a3b8',
    rare: '#3b82f6',
    epic: '#a855f7',
    legendary: '#f59e0b',
  }
  return colors[rarity]
}

// Get rarity gradient
export function getRarityGradient(rarity: Achievement['rarity']): string {
  const gradients: Record<Achievement['rarity'], string> = {
    common: 'from-slate-400 to-slate-600',
    rare: 'from-blue-400 to-blue-600',
    epic: 'from-purple-400 to-purple-600',
    legendary: 'from-amber-400 to-amber-600',
  }
  return gradients[rarity]
}
