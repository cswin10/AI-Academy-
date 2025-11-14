'use client';

import { useBadges } from '@/hooks/useBadges';
import { BadgeCard } from './BadgeCard';
import { Trophy } from 'lucide-react';

interface BadgeGridProps {
  rarity?: 'common' | 'rare' | 'epic' | 'legendary';
  limit?: number;
}

export function BadgeGrid({ rarity, limit }: BadgeGridProps) {
  const { allBadges, userBadges, loading } = useBadges();

  if (loading) {
    return (
      <div className="grid grid-cols-3 md:grid-cols-5 lg:grid-cols-6 gap-4">
        {Array.from({ length: 12 }).map((_, i) => (
          <div
            key={i}
            className="w-20 h-20 rounded-full bg-gray-800 animate-pulse"
          />
        ))}
      </div>
    );
  }

  let badges = allBadges;
  if (rarity) {
    badges = badges.filter(b => b.rarity === rarity);
  }
  if (limit) {
    badges = badges.slice(0, limit);
  }

  const earnedBadgeIds = new Set(userBadges.map(b => b.id));
  const earnedMap = new Map(userBadges.map(b => [b.id, b.earned_at]));

  return (
    <div>
      <div className="flex items-center justify-between mb-4">
        <div className="flex items-center gap-2">
          <Trophy className="w-5 h-5 text-purple-primary" />
          <h3 className="text-lg font-bold text-text-primary">
            Badges {rarity && `(${rarity})`}
          </h3>
        </div>
        <span className="text-sm text-text-secondary">
          {userBadges.length} / {allBadges.length} earned
        </span>
      </div>

      <div className="grid grid-cols-3 md:grid-cols-5 lg:grid-cols-6 gap-4">
        {badges.map(badge => (
          <div key={badge.id} className="flex justify-center">
            <BadgeCard
              badge={badge}
              earned={earnedBadgeIds.has(badge.id)}
              earnedAt={earnedMap.get(badge.id)}
            />
          </div>
        ))}
      </div>

      {badges.length === 0 && (
        <div className="text-center py-8 text-text-secondary">
          No badges in this category yet
        </div>
      )}
    </div>
  );
}
