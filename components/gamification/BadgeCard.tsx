'use client';

import type { Badge } from '@/hooks/useBadges';
import { Lock, Sparkles } from 'lucide-react';

interface BadgeCardProps {
  badge: Badge;
  earned?: boolean;
  earnedAt?: string;
  size?: 'sm' | 'md' | 'lg';
}

const rarityColors = {
  common: {
    bg: 'from-gray-600 to-gray-700',
    border: 'border-gray-500',
    text: 'text-gray-400',
  },
  rare: {
    bg: 'from-blue-600 to-blue-700',
    border: 'border-blue-500',
    text: 'text-blue-400',
  },
  epic: {
    bg: 'from-purple-600 to-purple-700',
    border: 'border-purple-500',
    text: 'text-purple-400',
  },
  legendary: {
    bg: 'from-yellow-600 to-orange-600',
    border: 'border-yellow-500',
    text: 'text-yellow-400',
  },
};

export function BadgeCard({ badge, earned = false, earnedAt, size = 'md' }: BadgeCardProps) {
  const colors = rarityColors[badge.rarity];
  const sizeClasses = {
    sm: 'w-16 h-16 text-2xl',
    md: 'w-20 h-20 text-3xl',
    lg: 'w-24 h-24 text-4xl',
  };

  return (
    <div
      className={`
        relative group cursor-pointer transition-all duration-300
        ${earned ? 'opacity-100 hover:scale-105' : 'opacity-50 hover:opacity-70'}
      `}
    >
      <div
        className={`
          ${sizeClasses[size]}
          rounded-full
          bg-gradient-to-br ${colors.bg}
          border-2 ${colors.border}
          flex items-center justify-center
          shadow-lg
          ${earned ? 'animate-none' : ''}
        `}
      >
        {earned ? (
          <span className="relative">
            {badge.icon}
            {badge.rarity === 'legendary' && (
              <Sparkles className="absolute -top-1 -right-1 w-3 h-3 text-yellow-400 animate-pulse" />
            )}
          </span>
        ) : (
          <Lock className="w-8 h-8 text-gray-500" />
        )}
      </div>

      {/* Tooltip */}
      <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-3 py-2 bg-gray-900 rounded-lg shadow-xl opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-10 w-48">
        <div className="text-sm font-bold text-text-primary mb-1">{badge.name}</div>
        <div className="text-xs text-text-secondary mb-2">{badge.description}</div>
        <div className={`text-xs font-medium ${colors.text} capitalize`}>
          {badge.rarity}
        </div>
        {badge.xp_reward > 0 && (
          <div className="text-xs text-green-400 mt-1">
            +{badge.xp_reward} XP
          </div>
        )}
        {earnedAt && (
          <div className="text-xs text-text-secondary mt-1">
            Earned {new Date(earnedAt).toLocaleDateString()}
          </div>
        )}
        {/* Tooltip arrow */}
        <div className="absolute top-full left-1/2 -translate-x-1/2 -mt-px">
          <div className="border-4 border-transparent border-t-gray-900" />
        </div>
      </div>
    </div>
  );
}
