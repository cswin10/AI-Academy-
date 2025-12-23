import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Progress } from '@/components/ui/progress'
import { Trophy, Lock } from 'lucide-react'
import { getRarityColor, getRarityGradient } from '@/lib/utils/gamification'
import { formatDate } from '@/lib/utils/formatting'
import { cn } from '@/lib/utils/cn'
import type { Achievement, UserAchievement } from '@/lib/types'

const categories = [
  { value: 'all', label: 'All' },
  { value: 'completion', label: 'Completion' },
  { value: 'streak', label: 'Streak' },
  { value: 'perfection', label: 'Perfection' },
  { value: 'speed', label: 'Speed' },
]

export default async function AchievementsPage() {
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Fetch all achievements
  const { data: allAchievements } = await supabase
    .from('achievements')
    .select('*')
    .eq('is_active', true)
    .order('rarity')

  // Fetch user's achievements
  const { data: userAchievements } = await supabase
    .from('user_achievements')
    .select('*')
    .eq('user_id', user.id)

  const earnedAchievementIds = new Set(userAchievements?.map((ua) => ua.achievement_id) || [])
  const userAchievementMap = new Map(userAchievements?.map((ua) => [ua.achievement_id, ua]) || [])

  const earnedCount = earnedAchievementIds.size
  const totalCount = allAchievements?.length || 0

  // Group achievements by category
  const achievementsByCategory: Record<string, Achievement[]> = {
    all: allAchievements || [],
  }

  allAchievements?.forEach((a) => {
    if (!achievementsByCategory[a.category]) {
      achievementsByCategory[a.category] = []
    }
    achievementsByCategory[a.category].push(a)
  })

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-bold">Achievements</h1>
        <p className="text-muted-foreground mt-1">
          Track your progress and unlock rewards as you learn.
        </p>
      </div>

      {/* Progress Overview */}
      <Card className="border-border bg-gradient-to-br from-primary/10 to-secondary/10">
        <CardContent className="pt-6">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-6">
            <div className="flex items-center gap-4">
              <div className="p-4 rounded-full bg-primary/20">
                <Trophy className="h-8 w-8 text-primary" />
              </div>
              <div>
                <div className="text-sm text-muted-foreground">Achievements Earned</div>
                <div className="text-3xl font-bold">
                  {earnedCount} / {totalCount}
                </div>
              </div>
            </div>
            <div className="flex-1 max-w-md">
              <div className="flex justify-between text-sm mb-2">
                <span className="text-muted-foreground">Progress</span>
                <span className="font-medium">
                  {totalCount > 0 ? Math.round((earnedCount / totalCount) * 100) : 0}%
                </span>
              </div>
              <Progress
                value={totalCount > 0 ? (earnedCount / totalCount) * 100 : 0}
                className="h-3"
              />
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Achievement Tabs */}
      <Tabs defaultValue="all" className="space-y-6">
        <TabsList className="flex flex-wrap h-auto gap-2">
          {categories.map((cat) => (
            <TabsTrigger
              key={cat.value}
              value={cat.value}
              className="data-[state=active]:bg-primary data-[state=active]:text-primary-foreground"
            >
              {cat.label}
              {cat.value !== 'all' && (
                <span className="ml-2 text-xs opacity-70">
                  {achievementsByCategory[cat.value]?.filter((a) => earnedAchievementIds.has(a.id)).length || 0}/
                  {achievementsByCategory[cat.value]?.length || 0}
                </span>
              )}
            </TabsTrigger>
          ))}
        </TabsList>

        {categories.map((cat) => (
          <TabsContent key={cat.value} value={cat.value}>
            <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {achievementsByCategory[cat.value]?.map((achievement) => {
                const isEarned = earnedAchievementIds.has(achievement.id)
                const userAchievement = userAchievementMap.get(achievement.id)

                return (
                  <Card
                    key={achievement.id}
                    className={cn(
                      'border-border transition-all',
                      isEarned
                        ? 'bg-card'
                        : 'bg-card/50 opacity-60'
                    )}
                  >
                    <CardContent className="pt-6">
                      <div className="flex items-start gap-4">
                        <div
                          className={cn(
                            'text-4xl p-3 rounded-lg',
                            isEarned
                              ? `bg-gradient-to-br ${getRarityGradient(achievement.rarity)}`
                              : 'bg-muted grayscale'
                          )}
                        >
                          {isEarned ? achievement.icon : <Lock className="h-8 w-8" />}
                        </div>
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2 mb-1">
                            <h3 className="font-semibold truncate">{achievement.name}</h3>
                            {isEarned && (
                              <Badge
                                variant="outline"
                                style={{ borderColor: getRarityColor(achievement.rarity) }}
                                className="text-xs capitalize"
                              >
                                {achievement.rarity}
                              </Badge>
                            )}
                          </div>
                          <p className="text-sm text-muted-foreground line-clamp-2">
                            {achievement.description}
                          </p>
                          <div className="flex items-center gap-4 mt-2 text-xs">
                            <span className="text-primary font-medium">
                              +{achievement.xp_reward} XP
                            </span>
                            {isEarned && userAchievement && (
                              <span className="text-muted-foreground">
                                Earned {formatDate(userAchievement.earned_at)}
                              </span>
                            )}
                          </div>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                )
              })}
            </div>

            {(!achievementsByCategory[cat.value] || achievementsByCategory[cat.value].length === 0) && (
              <div className="text-center py-12 text-muted-foreground">
                <Trophy className="h-12 w-12 mx-auto mb-3 opacity-50" />
                <p>No achievements in this category yet.</p>
              </div>
            )}
          </TabsContent>
        ))}
      </Tabs>
    </div>
  )
}
