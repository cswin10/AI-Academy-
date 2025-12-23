'use client'

import Link from 'next/link'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Progress } from '@/components/ui/progress'
import { Badge } from '@/components/ui/badge'
import {
  BookOpen,
  CheckCircle,
  Trophy,
  Flame,
  ArrowRight,
  Sparkles,
  Target,
  Zap,
} from 'lucide-react'
import type {
  Profile,
  Track,
  UserSectionProgress,
  UserModuleProgress,
  Achievement,
  UserAchievement,
  Section,
  Module,
} from '@/lib/types'
import { calculateLevel, getLevelTitle, formatXP, getRarityColor } from '@/lib/utils/gamification'
import { calculateTrackProgress, calculateModuleProgress } from '@/lib/utils/progress'

interface DashboardContentProps {
  profile: Profile | null
  tracks: (Track & { modules: Module[] })[]
  sectionProgress: UserSectionProgress[]
  moduleProgress: UserModuleProgress[]
  recentAchievements: (UserAchievement & { achievement: Achievement })[]
  lastAccessedSection: (Section & { module: Module & { track: Track } }) | null
}

export function DashboardContent({
  profile,
  tracks,
  sectionProgress,
  moduleProgress,
  recentAchievements,
  lastAccessedSection,
}: DashboardContentProps) {
  const levelInfo = profile ? calculateLevel(profile.xp_total) : null

  const stats = [
    {
      label: 'Modules Completed',
      value: profile?.total_modules_completed || 0,
      icon: BookOpen,
      color: 'text-primary',
    },
    {
      label: 'Sections Completed',
      value: profile?.total_sections_completed || 0,
      icon: CheckCircle,
      color: 'text-success',
    },
    {
      label: 'Quizzes Passed',
      value: profile?.total_quizzes_passed || 0,
      icon: Target,
      color: 'text-secondary',
    },
    {
      label: 'Perfect Quizzes',
      value: profile?.perfect_quiz_count || 0,
      icon: Trophy,
      color: 'text-warning',
    },
  ]

  // Find the first available module from the first track
  const firstTrack = tracks[0]
  const firstModule = firstTrack?.modules?.[0]

  return (
    <div className="space-y-8">
      {/* Welcome Section */}
      <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
        <div>
          <h1 className="text-3xl font-bold">
            Welcome back, {profile?.display_name || 'Learner'}!
          </h1>
          <p className="text-muted-foreground mt-1">
            Continue your journey to becoming an AI operator.
          </p>
        </div>
        {profile && profile.current_streak > 0 && (
          <div className="flex items-center gap-2 px-4 py-2 rounded-full bg-warning/10 text-warning">
            <Flame className="h-5 w-5 streak-fire" />
            <span className="font-semibold">{profile.current_streak} day streak!</span>
          </div>
        )}
      </div>

      {/* XP and Level Card */}
      {levelInfo && (
        <Card className="border-border bg-gradient-to-br from-primary/10 to-secondary/10">
          <CardContent className="pt-6">
            <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-6">
              <div className="flex items-center gap-4">
                <div className="p-4 rounded-full bg-primary/20">
                  <Sparkles className="h-8 w-8 text-primary" />
                </div>
                <div>
                  <div className="text-sm text-muted-foreground">Current Level</div>
                  <div className="text-2xl font-bold">
                    Level {levelInfo.level} - {getLevelTitle(levelInfo.level)}
                  </div>
                </div>
              </div>
              <div className="flex-1 max-w-md">
                <div className="flex justify-between text-sm mb-2">
                  <span className="text-muted-foreground">Progress to Level {levelInfo.level + 1}</span>
                  <span className="font-medium">{formatXP(profile?.xp_total || 0)} XP</span>
                </div>
                <Progress value={levelInfo.progress} className="h-3" />
                <div className="flex justify-between text-xs text-muted-foreground mt-1">
                  <span>{formatXP(levelInfo.xpForCurrentLevel)} XP</span>
                  <span>{formatXP(levelInfo.xpForNextLevel)} XP</span>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
      )}

      {/* Stats Grid */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        {stats.map((stat) => (
          <Card key={stat.label} className="border-border">
            <CardContent className="pt-6">
              <div className="flex items-center gap-3">
                <div className={`p-2 rounded-lg bg-muted ${stat.color}`}>
                  <stat.icon className="h-5 w-5" />
                </div>
                <div>
                  <div className="text-2xl font-bold">{stat.value}</div>
                  <div className="text-xs text-muted-foreground">{stat.label}</div>
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <div className="grid lg:grid-cols-2 gap-6">
        {/* Continue Learning */}
        <Card className="border-border">
          <CardHeader>
            <CardTitle className="text-lg">Continue Learning</CardTitle>
            <CardDescription>Pick up where you left off</CardDescription>
          </CardHeader>
          <CardContent>
            {lastAccessedSection ? (
              <div className="space-y-4">
                <div className="flex items-start gap-3">
                  <div className="p-2 rounded-lg bg-primary/10">
                    <BookOpen className="h-5 w-5 text-primary" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="text-sm text-muted-foreground">
                      {lastAccessedSection.module?.track?.name} / {lastAccessedSection.module?.title}
                    </div>
                    <div className="font-medium truncate">{lastAccessedSection.title}</div>
                  </div>
                </div>
                <Link href={`/sections/${lastAccessedSection.slug}`}>
                  <Button className="w-full gap-2">
                    Resume Section
                    <ArrowRight className="h-4 w-4" />
                  </Button>
                </Link>
              </div>
            ) : firstModule ? (
              <div className="space-y-4">
                <div className="flex items-start gap-3">
                  <div className="p-2 rounded-lg bg-primary/10">
                    <Zap className="h-5 w-5 text-primary" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="text-sm text-muted-foreground">
                      {firstTrack?.name}
                    </div>
                    <div className="font-medium">{firstModule.title}</div>
                    <div className="text-sm text-muted-foreground mt-1">
                      {firstModule.short_description}
                    </div>
                  </div>
                </div>
                <Link href={`/modules/${firstModule.slug}`}>
                  <Button className="w-full gap-2">
                    Start Learning
                    <ArrowRight className="h-4 w-4" />
                  </Button>
                </Link>
              </div>
            ) : (
              <div className="text-center py-8 text-muted-foreground">
                <BookOpen className="h-12 w-12 mx-auto mb-3 opacity-50" />
                <p>No content available yet.</p>
              </div>
            )}
          </CardContent>
        </Card>

        {/* Recent Achievements */}
        <Card className="border-border">
          <CardHeader className="flex flex-row items-center justify-between">
            <div>
              <CardTitle className="text-lg">Recent Achievements</CardTitle>
              <CardDescription>Your latest accomplishments</CardDescription>
            </div>
            <Link href="/achievements">
              <Button variant="ghost" size="sm">
                View all
              </Button>
            </Link>
          </CardHeader>
          <CardContent>
            {recentAchievements.length > 0 ? (
              <div className="space-y-3">
                {recentAchievements.map((ua) => (
                  <div
                    key={ua.id}
                    className="flex items-center gap-3 p-3 rounded-lg bg-muted/50"
                  >
                    <span className="text-2xl">{ua.achievement?.icon}</span>
                    <div className="flex-1 min-w-0">
                      <div className="font-medium">{ua.achievement?.name}</div>
                      <div className="text-xs text-muted-foreground">
                        {ua.achievement?.description}
                      </div>
                    </div>
                    <Badge
                      variant="outline"
                      style={{ borderColor: getRarityColor(ua.achievement?.rarity || 'common') }}
                      className="text-xs"
                    >
                      +{ua.achievement?.xp_reward} XP
                    </Badge>
                  </div>
                ))}
              </div>
            ) : (
              <div className="text-center py-8 text-muted-foreground">
                <Trophy className="h-12 w-12 mx-auto mb-3 opacity-50" />
                <p>Complete sections to earn achievements!</p>
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      {/* Tracks Progress */}
      <Card className="border-border">
        <CardHeader className="flex flex-row items-center justify-between">
          <div>
            <CardTitle className="text-lg">Learning Tracks</CardTitle>
            <CardDescription>Your progress across all tracks</CardDescription>
          </div>
          <Link href="/tracks">
            <Button variant="ghost" size="sm">
              View all
            </Button>
          </Link>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {tracks.map((track) => {
              const modules = track.modules || []
              const allModuleIds = modules.map((m) => m.id)
              const completedModules = moduleProgress.filter(
                (mp) => allModuleIds.includes(mp.module_id) && mp.is_completed
              ).length
              const progress = modules.length > 0
                ? Math.round((completedModules / modules.length) * 100)
                : 0

              return (
                <Link key={track.id} href={`/tracks/${track.slug}`}>
                  <div className="p-4 rounded-lg bg-muted/50 hover:bg-muted transition-colors">
                    <div className="flex items-center justify-between mb-3">
                      <div className="flex items-center gap-3">
                        <span className="text-2xl">{track.icon}</span>
                        <div>
                          <div className="font-medium">{track.name}</div>
                          <div className="text-sm text-muted-foreground">
                            {completedModules} / {modules.length} modules
                          </div>
                        </div>
                      </div>
                      <Badge variant={progress === 100 ? 'success' : 'muted'}>
                        {progress}%
                      </Badge>
                    </div>
                    <Progress value={progress} className="h-2" />
                  </div>
                </Link>
              )
            })}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
