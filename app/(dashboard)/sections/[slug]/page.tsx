import { redirect, notFound } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Separator } from '@/components/ui/separator'
import {
  ChevronLeft,
  ChevronRight,
  Clock,
  ExternalLink,
  Video,
  FileText,
  BookOpen,
  Github,
  Wrench,
  CheckCircle,
} from 'lucide-react'
import { MarkdownContent } from '@/components/shared/markdown-content'
import { QuizComponent } from '@/components/quiz/quiz-component'
import { getLevelBgColor, getResourceTypeIcon } from '@/lib/utils/formatting'

interface PageProps {
  params: Promise<{ slug: string }>
}

const resourceIcons: Record<string, React.ElementType> = {
  video: Video,
  article: FileText,
  documentation: BookOpen,
  github: Github,
  tool: Wrench,
}

export default async function SectionPage({ params }: PageProps) {
  const { slug } = await params
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Fetch section with relations
  const { data: section } = await supabase
    .from('sections')
    .select(`
      *,
      module:modules(
        *,
        track:tracks(*)
      ),
      quiz:quizzes(
        *,
        questions:quiz_questions(*)
      )
    `)
    .eq('slug', slug)
    .single()

  if (!section) {
    notFound()
  }

  // Fetch external resources
  const { data: resources } = await supabase
    .from('external_resources')
    .select('*')
    .eq('section_id', section.id)
    .order('order_index')

  // Fetch all sections in this module for navigation
  const { data: allSections } = await supabase
    .from('sections')
    .select('id, slug, title, order_index')
    .eq('module_id', section.module_id)
    .order('order_index')

  // Find previous and next sections
  const currentIndex = allSections?.findIndex((s) => s.id === section.id) ?? -1
  const previousSection = currentIndex > 0 ? allSections?.[currentIndex - 1] : null
  const nextSection = currentIndex < (allSections?.length ?? 0) - 1 ? allSections?.[currentIndex + 1] : null

  // Check if user has passed the quiz
  const { data: quizAttempts } = await supabase
    .from('quiz_attempts')
    .select('*')
    .eq('user_id', user.id)
    .eq('section_id', section.id)
    .eq('passed', true)

  const hasPassedQuiz = (quizAttempts?.length ?? 0) > 0

  // Update/create section progress
  const { data: existingProgress } = await supabase
    .from('user_section_progress')
    .select('*')
    .eq('user_id', user.id)
    .eq('section_id', section.id)
    .single()

  if (existingProgress) {
    await supabase
      .from('user_section_progress')
      .update({ last_accessed_at: new Date().toISOString() })
      .eq('id', existingProgress.id)
  } else {
    await supabase.from('user_section_progress').insert({
      user_id: user.id,
      section_id: section.id,
      module_id: section.module_id,
      track_id: section.module?.track_id,
    })
  }

  const module = section.module
  const track = module?.track

  return (
    <div className="max-w-4xl mx-auto space-y-8">
      {/* Breadcrumb */}
      <div className="flex items-center gap-2 text-sm text-muted-foreground flex-wrap">
        <Link href="/tracks" className="hover:text-foreground transition-colors">
          Tracks
        </Link>
        <span>/</span>
        <Link href={`/tracks/${track?.slug}`} className="hover:text-foreground transition-colors">
          {track?.name}
        </Link>
        <span>/</span>
        <Link href={`/modules/${module?.slug}`} className="hover:text-foreground transition-colors">
          {module?.title}
        </Link>
        <span>/</span>
        <span className="text-foreground">{section.title}</span>
      </div>

      {/* Header */}
      <div className="space-y-4">
        <div className="flex items-start justify-between gap-4">
          <div>
            <h1 className="text-3xl font-bold">{section.title}</h1>
            <div className="flex items-center gap-3 mt-2">
              <Badge className={getLevelBgColor(section.level)}>
                {section.level}
              </Badge>
              {section.estimated_minutes && (
                <span className="flex items-center gap-1 text-sm text-muted-foreground">
                  <Clock className="h-4 w-4" />
                  {section.estimated_minutes} min
                </span>
              )}
              {hasPassedQuiz && (
                <Badge variant="success" className="gap-1">
                  <CheckCircle className="h-3 w-3" />
                  Completed
                </Badge>
              )}
            </div>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <Card className="border-border bg-card">
        <CardContent className="p-6 md:p-8">
          <MarkdownContent content={section.content_markdown} />
        </CardContent>
      </Card>

      {/* External Resources */}
      {resources && resources.length > 0 && (
        <Card className="border-border bg-card">
          <CardHeader>
            <CardTitle className="text-lg">Additional Resources</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            {resources.map((resource) => {
              const Icon = resourceIcons[resource.resource_type] || ExternalLink
              return (
                <a
                  key={resource.id}
                  href={resource.url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center gap-3 p-3 rounded-lg bg-muted/50 hover:bg-muted transition-colors"
                >
                  <div className="p-2 rounded-lg bg-primary/10">
                    <Icon className="h-4 w-4 text-primary" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="font-medium truncate">{resource.title}</div>
                    <div className="text-xs text-muted-foreground capitalize">
                      {resource.resource_type}
                    </div>
                  </div>
                  <ExternalLink className="h-4 w-4 text-muted-foreground flex-shrink-0" />
                </a>
              )
            })}
          </CardContent>
        </Card>
      )}

      {/* Exercise */}
      {section.exercise_markdown && (
        <Card className="border-border bg-card border-l-4 border-l-primary">
          <CardHeader>
            <CardTitle className="text-lg">Exercise</CardTitle>
          </CardHeader>
          <CardContent>
            <MarkdownContent content={section.exercise_markdown} />
          </CardContent>
        </Card>
      )}

      {/* Quiz */}
      {section.quiz && (
        <div className="space-y-4">
          <Separator />
          <h2 className="text-xl font-semibold">Section Quiz</h2>
          <QuizComponent
            quiz={section.quiz}
            section={section}
            userId={user.id}
            hasPassedBefore={hasPassedQuiz}
            nextSectionSlug={nextSection?.slug}
          />
        </div>
      )}

      {/* Navigation */}
      <div className="flex items-center justify-between pt-4">
        {previousSection ? (
          <Link href={`/sections/${previousSection.slug}`}>
            <Button variant="outline" className="gap-2">
              <ChevronLeft className="h-4 w-4" />
              Previous
            </Button>
          </Link>
        ) : (
          <Link href={`/modules/${module?.slug}`}>
            <Button variant="outline" className="gap-2">
              <ChevronLeft className="h-4 w-4" />
              Back to Module
            </Button>
          </Link>
        )}

        {nextSection && hasPassedQuiz && (
          <Link href={`/sections/${nextSection.slug}`}>
            <Button className="gap-2">
              Next Section
              <ChevronRight className="h-4 w-4" />
            </Button>
          </Link>
        )}

        {!nextSection && hasPassedQuiz && (
          <Link href={`/modules/${module?.slug}`}>
            <Button className="gap-2">
              Complete Module
              <CheckCircle className="h-4 w-4" />
            </Button>
          </Link>
        )}
      </div>
    </div>
  )
}
