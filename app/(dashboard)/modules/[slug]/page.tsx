import { redirect, notFound } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { Card, CardContent } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Progress } from '@/components/ui/progress'
import { Button } from '@/components/ui/button'
import { Clock, ChevronLeft, Lock, CheckCircle, ArrowRight, PlayCircle } from 'lucide-react'
import { getLevelBgColor } from '@/lib/utils/formatting'

interface PageProps {
  params: Promise<{ slug: string }>
}

export default async function ModuleDetailPage({ params }: PageProps) {
  const { slug } = await params
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Fetch module with track
  const { data: module } = await supabase
    .from('modules')
    .select(`
      *,
      track:tracks(*)
    `)
    .eq('slug', slug)
    .eq('is_active', true)
    .single()

  if (!module) {
    notFound()
  }

  // Fetch sections for this module
  const { data: sections } = await supabase
    .from('sections')
    .select(`
      *,
      quiz:quizzes(*)
    `)
    .eq('module_id', module.id)
    .order('order_index')

  // Fetch user's section progress
  const { data: sectionProgress } = await supabase
    .from('user_section_progress')
    .select('*')
    .eq('user_id', user.id)
    .eq('module_id', module.id)

  // Fetch quiz attempts for sections in this module
  const sectionIds = sections?.map((s) => s.id) || []
  const { data: quizAttempts } = await supabase
    .from('quiz_attempts')
    .select('*')
    .eq('user_id', user.id)
    .in('section_id', sectionIds)

  const completedSections = sectionProgress?.filter((sp) => sp.is_completed).length || 0
  const totalSections = sections?.length || 0
  const overallProgress = totalSections > 0 ? Math.round((completedSections / totalSections) * 100) : 0

  // Find the next unlocked section to continue
  const firstIncompleteSectionIndex = sections?.findIndex((section, index) => {
    const progress = sectionProgress?.find((sp) => sp.section_id === section.id)
    return !progress?.is_completed
  })

  return (
    <div className="space-y-8">
      {/* Breadcrumb */}
      <div className="flex items-center gap-2 text-sm text-muted-foreground">
        <Link href="/tracks" className="hover:text-foreground transition-colors">
          Tracks
        </Link>
        <span>/</span>
        <Link href={`/tracks/${module.track?.slug}`} className="hover:text-foreground transition-colors">
          {module.track?.name}
        </Link>
        <span>/</span>
        <span className="text-foreground">{module.title}</span>
      </div>

      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-start md:justify-between gap-6">
        <div>
          <div className="flex items-center gap-3 mb-2">
            <h1 className="text-3xl font-bold">{module.title}</h1>
            <Badge className={getLevelBgColor(module.level)}>
              {module.level}
            </Badge>
          </div>
          <p className="text-muted-foreground max-w-2xl">
            {module.short_description}
          </p>
          <div className="flex items-center gap-4 mt-3 text-sm text-muted-foreground">
            <span>{totalSections} sections</span>
            {module.estimated_hours && (
              <span className="flex items-center gap-1">
                <Clock className="h-4 w-4" />
                {module.estimated_hours} hours
              </span>
            )}
            <span>+{module.xp_reward} XP on completion</span>
          </div>
        </div>
        <div className="flex flex-col items-end gap-2">
          <div className="text-3xl font-bold text-primary">{overallProgress}%</div>
          <div className="text-sm text-muted-foreground">
            {completedSections} of {totalSections} sections complete
          </div>
        </div>
      </div>

      {/* Progress */}
      <Progress value={overallProgress} className="h-3" />

      {/* Sections List */}
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h2 className="text-xl font-semibold">Sections</h2>
          {firstIncompleteSectionIndex !== undefined && firstIncompleteSectionIndex >= 0 && sections && (
            <Link href={`/sections/${sections[firstIncompleteSectionIndex].slug}`}>
              <Button className="gap-2">
                <PlayCircle className="h-4 w-4" />
                {firstIncompleteSectionIndex === 0 ? 'Start Module' : 'Continue'}
              </Button>
            </Link>
          )}
        </div>

        <div className="space-y-3">
          {sections?.map((section, index) => {
            const progress = sectionProgress?.find((sp) => sp.section_id === section.id)
            const isCompleted = progress?.is_completed

            // Section is unlocked if it's the first one or the previous one is completed
            const previousSection = index > 0 ? sections[index - 1] : null
            const previousProgress = previousSection
              ? sectionProgress?.find((sp) => sp.section_id === previousSection.id)
              : null
            const isUnlocked = index === 0 || previousProgress?.is_completed

            // Check if quiz was passed
            const quizPassed = section.quiz_id
              ? quizAttempts?.some((qa) => qa.section_id === section.id && qa.passed)
              : null

            return (
              <Link
                key={section.id}
                href={isUnlocked ? `/sections/${section.slug}` : '#'}
                className={!isUnlocked ? 'cursor-not-allowed' : ''}
              >
                <Card className={`border-border bg-card ${isUnlocked ? 'card-hover' : 'opacity-60'}`}>
                  <CardContent className="p-4">
                    <div className="flex items-center gap-4">
                      {/* Section Number */}
                      <div className={`flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold ${
                        isCompleted
                          ? 'bg-success text-white'
                          : isUnlocked
                          ? 'bg-primary/10 text-primary'
                          : 'bg-muted text-muted-foreground'
                      }`}>
                        {isCompleted ? (
                          <CheckCircle className="h-4 w-4" />
                        ) : !isUnlocked ? (
                          <Lock className="h-3 w-3" />
                        ) : (
                          index + 1
                        )}
                      </div>

                      {/* Section Info */}
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-2">
                          <h3 className="font-medium truncate">{section.title}</h3>
                          {section.quiz_id && (
                            <Badge variant={quizPassed ? 'success' : 'outline'} className="text-xs">
                              {quizPassed ? 'Quiz Passed' : 'Has Quiz'}
                            </Badge>
                          )}
                        </div>
                        <div className="flex items-center gap-3 mt-1 text-xs text-muted-foreground">
                          {section.estimated_minutes && (
                            <span>{section.estimated_minutes} min</span>
                          )}
                          <Badge className={`${getLevelBgColor(section.level)} text-xs`}>
                            {section.level}
                          </Badge>
                        </div>
                      </div>

                      {/* Arrow */}
                      {isUnlocked && (
                        <ArrowRight className="h-4 w-4 text-muted-foreground flex-shrink-0" />
                      )}
                    </div>
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
