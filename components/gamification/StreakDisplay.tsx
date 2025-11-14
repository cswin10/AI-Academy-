'use client';

import { useStreak } from '@/hooks/useStreak';
import { Flame } from 'lucide-react';

export function StreakDisplay() {
  const { currentStreak, longestStreak } = useStreak();

  if (currentStreak === 0) return null;

  return (
    <div className="flex items-center gap-2 px-3 py-2 rounded-lg bg-gradient-to-r from-orange-500/20 to-red-500/20 border border-orange-500/30">
      <Flame className="w-5 h-5 text-orange-500 animate-pulse" />
      <div className="flex flex-col">
        <span className="text-sm font-bold text-orange-500">
          {currentStreak} day streak
        </span>
        {longestStreak > currentStreak && (
          <span className="text-xs text-text-secondary">
            Best: {longestStreak} days
          </span>
        )}
      </div>
    </div>
  );
}
