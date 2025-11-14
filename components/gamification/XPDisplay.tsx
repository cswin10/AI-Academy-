'use client';

import { useXPSystem } from '@/hooks/useXPSystem';
import { useUserProfile } from '@/hooks/useUserProfile';
import { Zap, TrendingUp } from 'lucide-react';

export function XPDisplay() {
  const { profile } = useUserProfile();
  const { progressToNextLevel, xpToNextLevel } = useXPSystem();

  if (!profile) return null;

  return (
    <div className="flex items-center gap-3">
      {/* Level Badge */}
      <div className="flex items-center justify-center w-12 h-12 rounded-full bg-gradient-to-br from-purple-600 to-blue-600 text-white font-bold shadow-lg">
        <span className="text-lg">{profile.level}</span>
      </div>

      {/* XP Info */}
      <div className="flex flex-col">
        <div className="flex items-center gap-1 text-sm font-medium text-text-primary">
          <Zap className="w-4 h-4 text-yellow-500" />
          <span>{profile.xp.toLocaleString()} XP</span>
        </div>
        <div className="flex items-center gap-1 text-xs text-text-secondary">
          <TrendingUp className="w-3 h-3" />
          <span>{xpToNextLevel.toLocaleString()} to level {profile.level + 1}</span>
        </div>
      </div>

      {/* Progress Bar */}
      <div className="hidden md:flex flex-col gap-1 w-32">
        <div className="h-2 bg-gray-700 rounded-full overflow-hidden">
          <div
            className="h-full bg-gradient-to-r from-purple-600 to-blue-600 transition-all duration-500"
            style={{ width: `${progressToNextLevel}%` }}
          />
        </div>
        <span className="text-xs text-text-secondary text-right">
          {progressToNextLevel}%
        </span>
      </div>
    </div>
  );
}
