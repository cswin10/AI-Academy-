'use client';

import React from 'react';
import { useRouter } from 'next/navigation';
import { Card } from '../ui/Card';
import { Button } from '../ui/Button';
import { XPDisplay } from '../gamification/XPDisplay';
import { StreakDisplay } from '../gamification/StreakDisplay';
import { BadgeGrid } from '../gamification/BadgeGrid';
import { useSupabase } from '@/hooks/useSupabase';
import { useUserProfile } from '@/hooks/useUserProfile';
import { useModuleProgress } from '@/hooks/useModuleProgress';
import { Trophy, BookOpen, Target, TrendingUp } from 'lucide-react';

export function DashboardClient() {
  const router = useRouter();
  const { user, loading: authLoading } = useSupabase();
  const { profile, loading: profileLoading } = useUserProfile();
  const { progress } = useModuleProgress();

  if (authLoading || profileLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-purple-primary mx-auto mb-4"></div>
          <p className="text-text-secondary">Loading your dashboard...</p>
        </div>
      </div>
    );
  }

  if (!user) {
    return (
      <div className="min-h-screen flex items-center justify-center px-4">
        <Card className="p-8 max-w-md text-center">
          <h2 className="text-2xl font-bold text-text-primary mb-4">
            Sign In Required
          </h2>
          <p className="text-text-secondary mb-6">
            Please sign in to view your dashboard and track your progress.
          </p>
          <Button
            onClick={() => router.push('/')}
            variant="primary"
            className="w-full"
          >
            Go to Home
          </Button>
        </Card>
      </div>
    );
  }

  if (!profile) {
    return (
      <div className="min-h-screen flex items-center justify-center px-4">
        <Card className="p-8 max-w-md text-center">
          <h2 className="text-2xl font-bold text-text-primary mb-4">
            Profile Not Found
          </h2>
          <p className="text-text-secondary mb-6">
            Your profile is being created. Please refresh the page.
          </p>
          <Button
            onClick={() => window.location.reload()}
            variant="primary"
            className="w-full"
          >
            Refresh Page
          </Button>
        </Card>
      </div>
    );
  }

  // Calculate stats
  const completedModules = progress.filter(p => p.completed_at).length;
  const startedModules = progress.filter(p => !p.completed_at).length;
  const totalModules = 17; // Update based on actual count

  return (
    <div className="min-h-screen pb-20">
      {/* Header */}
      <div className="bg-surface border-b border-gray-800">
        <div className="container mx-auto max-w-7xl px-4 py-8">
          <h1 className="text-4xl font-bold text-text-primary mb-2">
            Welcome back, {profile.display_name || profile.username}!
          </h1>
          <p className="text-text-secondary">
            Track your progress and achievements
          </p>
        </div>
      </div>

      {/* Main Content */}
      <div className="container mx-auto max-w-7xl px-4 py-8">
        {/* Stats Overview */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
          {/* XP & Level */}
          <Card className="p-6">
            <div className="flex items-center gap-3 mb-3">
              <div className="w-10 h-10 rounded-full bg-gradient-to-br from-purple-600 to-blue-600 flex items-center justify-center text-white font-bold">
                {profile.level}
              </div>
              <div>
                <div className="text-sm text-text-secondary">Level</div>
                <div className="text-xl font-bold text-text-primary">
                  {profile.level}
                </div>
              </div>
            </div>
            <XPDisplay />
          </Card>

          {/* Modules Completed */}
          <Card className="p-6">
            <div className="flex items-center gap-3 mb-2">
              <BookOpen className="w-8 h-8 text-success" />
              <div>
                <div className="text-sm text-text-secondary">Modules Completed</div>
                <div className="text-2xl font-bold text-text-primary">
                  {completedModules}/{totalModules}
                </div>
              </div>
            </div>
            <div className="mt-2">
              <div className="h-2 bg-gray-800 rounded-full overflow-hidden">
                <div
                  className="h-full bg-success transition-all"
                  style={{ width: `${(completedModules / totalModules) * 100}%` }}
                />
              </div>
            </div>
          </Card>

          {/* Streak */}
          <Card className="p-6">
            <div className="flex items-center gap-3 mb-2">
              <Target className="w-8 h-8 text-orange-500" />
              <div>
                <div className="text-sm text-text-secondary">Current Streak</div>
                <div className="text-2xl font-bold text-text-primary">
                  {profile.streak_count} days
                </div>
              </div>
            </div>
            <StreakDisplay />
          </Card>

          {/* Total XP */}
          <Card className="p-6">
            <div className="flex items-center gap-3 mb-2">
              <TrendingUp className="w-8 h-8 text-purple-primary" />
              <div>
                <div className="text-sm text-text-secondary">Total XP</div>
                <div className="text-2xl font-bold text-text-primary">
                  {profile.xp.toLocaleString()}
                </div>
              </div>
            </div>
            <p className="text-xs text-text-secondary mt-2">
              Rank: #{profile.leaderboard_rank || 'N/A'}
            </p>
          </Card>
        </div>

        {/* Recent Activity */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Progress Overview */}
          <div className="lg:col-span-2">
            <Card className="p-6">
              <h2 className="text-2xl font-bold text-text-primary mb-4 flex items-center gap-2">
                <Trophy className="w-6 h-6 text-yellow-500" />
                Your Progress
              </h2>

              <div className="space-y-4">
                {/* Completed Modules */}
                {completedModules > 0 && (
                  <div>
                    <h3 className="text-lg font-semibold text-text-primary mb-2">
                      Completed Modules ({completedModules})
                    </h3>
                    <div className="flex flex-wrap gap-2">
                      {progress
                        .filter(p => p.completed_at)
                        .map(p => (
                          <div
                            key={p.module_id}
                            className="px-3 py-1 bg-success/10 text-success text-sm rounded-full"
                          >
                            Module {p.module_id}
                          </div>
                        ))}
                    </div>
                  </div>
                )}

                {/* In Progress */}
                {startedModules > 0 && (
                  <div>
                    <h3 className="text-lg font-semibold text-text-primary mb-2">
                      In Progress ({startedModules})
                    </h3>
                    <div className="space-y-2">
                      {progress
                        .filter(p => !p.completed_at)
                        .map(p => (
                          <div
                            key={p.module_id}
                            className="flex items-center justify-between p-3 bg-gray-800/50 rounded-lg"
                          >
                            <span className="text-sm text-text-primary">
                              Module {p.module_id}
                            </span>
                            <div className="flex items-center gap-2">
                              <div className="w-24 h-2 bg-gray-700 rounded-full overflow-hidden">
                                <div
                                  className="h-full bg-warning"
                                  style={{ width: `${p.progress_percentage || 0}%` }}
                                />
                              </div>
                              <span className="text-xs text-text-secondary">
                                {p.progress_percentage || 0}%
                              </span>
                            </div>
                          </div>
                        ))}
                    </div>
                  </div>
                )}

                {completedModules === 0 && startedModules === 0 && (
                  <div className="text-center py-12">
                    <BookOpen className="w-16 h-16 text-gray-600 mx-auto mb-4" />
                    <p className="text-text-secondary mb-4">
                      You haven't started any modules yet
                    </p>
                    <Button
                      onClick={() => router.push('/')}
                      variant="primary"
                    >
                      Start Learning
                    </Button>
                  </div>
                )}
              </div>
            </Card>
          </div>

          {/* Badges Sidebar */}
          <div>
            <Card className="p-6">
              <h2 className="text-xl font-bold text-text-primary mb-4">
                Your Badges
              </h2>
              <BadgeGrid limit={6} />
              <Button
                onClick={() => router.push('/dashboard/badges')}
                variant="outline"
                className="w-full mt-4"
              >
                View All Badges
              </Button>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
}
