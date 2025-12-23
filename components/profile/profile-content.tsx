'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Progress } from '@/components/ui/progress'
import { Badge } from '@/components/ui/badge'
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar'
import { Separator } from '@/components/ui/separator'
import {
  Sparkles,
  Flame,
  Trophy,
  BookOpen,
  CheckCircle,
  Target,
  Calendar,
  Edit2,
  Save,
  Loader2,
} from 'lucide-react'
import type {
  Profile,
  Achievement,
  UserAchievement,
  Track,
  Module,
  UserModuleProgress,
} from '@/lib/types'
import { calculateLevel, getLevelTitle, formatXP, getRarityColor } from '@/lib/utils/gamification'
import { formatDate } from '@/lib/utils/formatting'

interface ProfileContentProps {
  profile: Profile | null
  userAchievements: (UserAchievement & { achievement: Achievement })[]
  allAchievements: Achievement[]
  tracks: (Track & { modules: { id: string }[] })[]
  moduleProgress: UserModuleProgress[]
}

export function ProfileContent({
  profile,
  userAchievements,
  allAchievements,
  tracks,
  moduleProgress,
}: ProfileContentProps) {
  const [isEditing, setIsEditing] = useState(false)
  const [displayName, setDisplayName] = useState(profile?.display_name || '')
  const [isSaving, setIsSaving] = useState(false)

  const router = useRouter()
  const supabase = createClient()
  const levelInfo = profile ? calculateLevel(profile.xp_total) : null

  const earnedAchievementIds = userAchievements.map((ua) => ua.achievement_id)

  const handleSave = async () => {
    if (!profile) return

    setIsSaving(true)
    try {
      await supabase
        .from('profiles')
        .update({ display_name: displayName })
        .eq('id', profile.id)

      setIsEditing(false)
      router.refresh()
    } catch (error) {
      console.error('Error saving profile:', error)
    } finally {
      setIsSaving(false)
    }
  }

  if (!profile || !levelInfo) {
    return <div>Loading...</div>
  }

  const stats = [
    {
      label: 'Total XP',
      value: formatXP(profile.xp_total),
      icon: Sparkles,
      color: 'text-primary',
    },
    {
      label: 'Current Streak',
      value: `${profile.current_streak} days`,
      icon: Flame,
      color: 'text-warning',
    },
    {
      label: 'Longest Streak',
      value: `${profile.longest_streak} days`,
      icon: Trophy,
      color: 'text-warning',
    },
    {
      label: 'Modules Completed',
      value: profile.total_modules_completed,
      icon: BookOpen,
      color: 'text-primary',
    },
    {
      label: 'Sections Completed',
      value: profile.total_sections_completed,
      icon: CheckCircle,
      color: 'text-success',
    },
    {
      label: 'Quizzes Passed',
      value: profile.total_quizzes_passed,
      icon: Target,
      color: 'text-secondary',
    },
    {
      label: 'Perfect Quizzes',
      value: profile.perfect_quiz_count,
      icon: Trophy,
      color: 'text-warning',
    },
    {
      label: 'Member Since',
      value: formatDate(profile.created_at),
      icon: Calendar,
      color: 'text-muted-foreground',
    },
  ]

  return (
    <div className="max-w-4xl mx-auto space-y-8">
      <h1 className="text-3xl font-bold">Profile</h1>

      {/* Profile Card */}
      <Card className="border-border bg-card">
        <CardContent className="pt-6">
          <div className="flex flex-col md:flex-row gap-6">
            <div className="flex flex-col items-center">
              <Avatar className="h-24 w-24">
                <AvatarImage src={profile.avatar_url || undefined} />
                <AvatarFallback className="text-2xl bg-primary text-primary-foreground">
                  {(profile.display_name || profile.email)?.[0]?.toUpperCase()}
                </AvatarFallback>
              </Avatar>
            </div>

            <div className="flex-1 space-y-4">
              {isEditing ? (
                <div className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="displayName">Display Name</Label>
                    <Input
                      id="displayName"
                      value={displayName}
                      onChange={(e) => setDisplayName(e.target.value)}
                      placeholder="Your name"
                    />
                  </div>
                  <div className="flex gap-2">
                    <Button onClick={handleSave} disabled={isSaving}>
                      {isSaving ? (
                        <Loader2 className="h-4 w-4 animate-spin" />
                      ) : (
                        <Save className="h-4 w-4" />
                      )}
                      <span className="ml-2">Save</span>
                    </Button>
                    <Button variant="outline" onClick={() => setIsEditing(false)}>
                      Cancel
                    </Button>
                  </div>
                </div>
              ) : (
                <div className="flex items-start justify-between">
                  <div>
                    <h2 className="text-2xl font-bold">{profile.display_name || 'Learner'}</h2>
                    <p className="text-muted-foreground">{profile.email}</p>
                    <div className="flex items-center gap-2 mt-2">
                      <Badge variant="default" className="bg-primary">
                        Level {levelInfo.level}
                      </Badge>
                      <span className="text-sm text-muted-foreground">
                        {getLevelTitle(levelInfo.level)}
                      </span>
                    </div>
                  </div>
                  <Button variant="outline" size="sm" onClick={() => setIsEditing(true)}>
                    <Edit2 className="h-4 w-4 mr-2" />
                    Edit
                  </Button>
                </div>
              )}

              <div className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="text-muted-foreground">Progress to Level {levelInfo.level + 1}</span>
                  <span className="font-medium">{formatXP(profile.xp_total)} XP</span>
                </div>
                <Progress value={levelInfo.progress} className="h-3" />
                <div className="flex justify-between text-xs text-muted-foreground">
                  <span>{formatXP(levelInfo.xpForCurrentLevel)} XP</span>
                  <span>{formatXP(levelInfo.xpForNextLevel)} XP</span>
                </div>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Stats Grid */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {stats.map((stat) => (
          <Card key={stat.label} className="border-border">
            <CardContent className="pt-6">
              <div className="flex items-center gap-3">
                <div className={`p-2 rounded-lg bg-muted ${stat.color}`}>
                  <stat.icon className="h-4 w-4" />
                </div>
                <div>
                  <div className="text-lg font-bold">{stat.value}</div>
                  <div className="text-xs text-muted-foreground">{stat.label}</div>
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Recent Achievements */}
      <Card className="border-border bg-card">
        <CardHeader>
          <CardTitle className="text-lg">Recent Achievements</CardTitle>
          <CardDescription>
            {userAchievements.length} of {allAchievements.length} achievements earned
          </CardDescription>
        </CardHeader>
        <CardContent>
          {userAchievements.length > 0 ? (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
              {userAchievements.slice(0, 6).map((ua) => (
                <div
                  key={ua.id}
                  className="flex items-center gap-3 p-3 rounded-lg bg-muted/50"
                >
                  <span className="text-2xl">{ua.achievement?.icon}</span>
                  <div className="flex-1 min-w-0">
                    <div className="font-medium">{ua.achievement?.name}</div>
                    <div className="text-xs text-muted-foreground">
                      {formatDate(ua.earned_at)}
                    </div>
                  </div>
                  <Badge
                    variant="outline"
                    style={{ borderColor: getRarityColor(ua.achievement?.rarity || 'common') }}
                    className="text-xs"
                  >
                    {ua.achievement?.rarity}
                  </Badge>
                </div>
              ))}
            </div>
          ) : (
            <div className="text-center py-8 text-muted-foreground">
              <Trophy className="h-12 w-12 mx-auto mb-3 opacity-50" />
              <p>Complete sections and quizzes to earn achievements!</p>
            </div>
          )}
        </CardContent>
      </Card>

      {/* Track Progress */}
      <Card className="border-border bg-card">
        <CardHeader>
          <CardTitle className="text-lg">Track Progress</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          {tracks.map((track) => {
            const totalModules = track.modules?.length || 0
            const completedModules = moduleProgress.filter(
              (mp) => track.modules?.some((m) => m.id === mp.module_id) && mp.is_completed
            ).length
            const progress = totalModules > 0 ? Math.round((completedModules / totalModules) * 100) : 0

            return (
              <div key={track.id} className="space-y-2">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <span className="text-xl">{track.icon}</span>
                    <span className="font-medium">{track.name}</span>
                  </div>
                  <span className="text-sm text-muted-foreground">
                    {completedModules} / {totalModules} modules
                  </span>
                </div>
                <Progress value={progress} className="h-2" />
              </div>
            )
          })}
        </CardContent>
      </Card>
    </div>
  )
}
