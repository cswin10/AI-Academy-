import { redirect, notFound } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Progress } from '@/components/ui/progress'
import { Button } from '@/components/ui/button'
import { BookOpen, Clock, ChevronLeft, Lock, CheckCircle, ArrowRight } from 'lucide-react'
import { getLevelBgColor } from '@/lib/utils/formatting'

interface PageProps {
  params: Promise<{ slug: string }>
}

export default async function TrackDetailPage({ params }: PageProps) {
  const { slug } = await params
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Fetch track with modules first
  const { data: track } = await supabase
    .from('tracks')
    .select(`
      *,
      modules:modules(*)
    `)
    .eq('slug', slug)
    .eq('is_active', true)
    .single()

  if (!track) {
    notFound()
  }

  // Sort modules by order_index
  const modules = (track.modules || []).sort((a: any, b: any) => a.order_index - b.order_index)
  const moduleIds = modules.map((m: any) => m.id)

  // Run remaining queries in parallel
  const [{ data: moduleProgress }, { data: sections }] = await Promise.all([
    supabase
      .from('user_module_progress')
      .select('*')
      .eq('user_id', user.id)
      .in('module_id', moduleIds),
    supabase
      .from('sections')
      .select('module_id')
      .in('module_id', moduleIds),
  ])

  const sectionCountByModule: Record<string, number> = {}
  sections?.forEach((s) => {
    sectionCountByModule[s.module_id] = (sectionCountByModule[s.module_id] || 0) + 1
  })

  const completedModules = moduleProgress?.filter((mp) => mp.is_completed).length || 0
  const totalModules = modules.length
  const overallProgress = totalModules > 0 ? Math.round((completedModules / totalModules) * 100) : 0

  return (
    <div className="space-y-8">
      {/* Breadcrumb */}
      <div className="flex items-center gap-2 text-sm text-muted-foreground">
        <Link href="/tracks" className="hover:text-foreground transition-colors">
          Tracks
        </Link>
        <span>/</span>
        <span className="text-foreground">{track.name}</span>
      </div>

      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-start md:justify-between gap-6">
        <div className="flex items-start gap-4">
          <span className="text-5xl">{track.icon}</span>
          <div>
            <h1 className="text-3xl font-bold">{track.name}</h1>
            <p className="text-muted-foreground mt-1 max-w-2xl">
              {track.description}
            </p>
            <div className="flex items-center gap-4 mt-3 text-sm text-muted-foreground">
              <span className="flex items-center gap-1">
                <BookOpen className="h-4 w-4" />
                {totalModules} modules
              </span>
              {track.estimated_hours && (
                <span className="flex items-center gap-1">
                  <Clock className="h-4 w-4" />
                  {track.estimated_hours} hours
                </span>
              )}
              {track.is_required && (
                <Badge variant="default">Required</Badge>
              )}
            </div>
          </div>
        </div>
        <div className="flex flex-col items-end gap-2">
          <div className="text-3xl font-bold text-primary">{overallProgress}%</div>
          <div className="text-sm text-muted-foreground">
            {completedModules} of {totalModules} modules complete
          </div>
        </div>
      </div>

      {/* Progress */}
      <Progress value={overallProgress} className="h-3" />

      {/* Modules List */}
      <div className="space-y-4">
        <h2 className="text-xl font-semibold">Modules</h2>
        <div className="space-y-3">
          {modules.map((module: any, index: number) => {
            const progress = moduleProgress?.find((mp) => mp.module_id === module.id)
            const sectionCount = sectionCountByModule[module.id] || 0
            const sectionsCompleted = progress?.sections_completed || 0
            const isCompleted = progress?.is_completed
            const isStarted = progress && sectionsCompleted > 0

            // Check if module is unlocked (no prereqs or all prereqs completed)
            const prereqs = module.prerequisite_module_ids || []
            const isUnlocked = prereqs.length === 0 || prereqs.every((prereqId: string) =>
              moduleProgress?.find((mp) => mp.module_id === prereqId && mp.is_completed)
            )

            return (
              <Link
                key={module.id}
                href={isUnlocked ? `/modules/${module.slug}` : '#'}
                className={!isUnlocked ? 'cursor-not-allowed' : ''}
              >
                <Card className={`border-border bg-card ${isUnlocked ? 'card-hover' : 'opacity-60'}`}>
                  <CardContent className="p-6">
                    <div className="flex items-center gap-4">
                      {/* Module Number */}
                      <div className={`flex-shrink-0 w-10 h-10 rounded-full flex items-center justify-center text-lg font-bold ${
                        isCompleted
                          ? 'bg-success text-white'
                          : isUnlocked
                          ? 'bg-primary text-white'
                          : 'bg-muted text-muted-foreground'
                      }`}>
                        {isCompleted ? (
                          <CheckCircle className="h-5 w-5" />
                        ) : !isUnlocked ? (
                          <Lock className="h-4 w-4" />
                        ) : (
                          index + 1
                        )}
                      </div>

                      {/* Module Info */}
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-2 mb-1">
                          <h3 className="font-semibold truncate">{module.title}</h3>
                          <Badge className={getLevelBgColor(module.level)}>
                            {module.level}
                          </Badge>
                        </div>
                        <p className="text-sm text-muted-foreground line-clamp-1">
                          {module.short_description}
                        </p>
                        <div className="flex items-center gap-4 mt-2 text-xs text-muted-foreground">
                          <span>{sectionCount} sections</span>
                          {module.estimated_hours && (
                            <span>{module.estimated_hours} hours</span>
                          )}
                          <span>+{module.xp_reward} XP</span>
                        </div>
                      </div>

                      {/* Progress / Status */}
                      <div className="flex-shrink-0 flex items-center gap-4">
                        {isStarted && !isCompleted && (
                          <div className="text-right">
                            <div className="text-sm font-medium">
                              {sectionsCompleted} / {sectionCount}
                            </div>
                            <div className="text-xs text-muted-foreground">sections</div>
                          </div>
                        )}
                        {isUnlocked && (
                          <ArrowRight className="h-5 w-5 text-muted-foreground" />
                        )}
                      </div>
                    </div>

                    {/* Progress Bar */}
                    {isStarted && sectionCount > 0 && (
                      <div className="mt-4">
                        <Progress
                          value={(sectionsCompleted / sectionCount) * 100}
                          className="h-1.5"
                        />
                      </div>
                    )}
                  </CardContent>
                </Card>
              </Link>
            )
          })}
        </div>
      </div>
    </div>
  )
}
