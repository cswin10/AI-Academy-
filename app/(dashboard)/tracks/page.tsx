import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Progress } from '@/components/ui/progress'
import { BookOpen, Clock, Lock } from 'lucide-react'

export default async function TracksPage() {
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Fetch tracks with modules
  const { data: tracks } = await supabase
    .from('tracks')
    .select(`
      *,
      modules:modules(*)
    `)
    .eq('is_active', true)
    .order('order_index')

  // Fetch user's module progress
  const { data: moduleProgress } = await supabase
    .from('user_module_progress')
    .select('*')
    .eq('user_id', user.id)

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-bold">Learning Tracks</h1>
        <p className="text-muted-foreground mt-1">
          Master AI operations through structured learning paths.
        </p>
      </div>

      <div className="grid md:grid-cols-2 gap-6">
        {tracks?.map((track) => {
          const modules = track.modules || []
          const allModuleIds = modules.map((m: any) => m.id)
          const completedModules = moduleProgress?.filter(
            (mp) => allModuleIds.includes(mp.module_id) && mp.is_completed
          ).length || 0
          const progress = modules.length > 0
            ? Math.round((completedModules / modules.length) * 100)
            : 0

          const isStarted = completedModules > 0
          const isCompleted = completedModules === modules.length && modules.length > 0

          return (
            <Link key={track.id} href={`/tracks/${track.slug}`}>
              <Card className="border-border bg-card card-hover h-full">
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div className="flex items-center gap-3">
                      <span className="text-4xl">{track.icon}</span>
                      <div>
                        <CardTitle className="text-xl">{track.name}</CardTitle>
                        {track.is_required && (
                          <Badge variant="default" className="mt-1">
                            Required
                          </Badge>
                        )}
                      </div>
                    </div>
                    <Badge
                      variant={isCompleted ? 'success' : isStarted ? 'info' : 'muted'}
                    >
                      {isCompleted ? 'Completed' : isStarted ? 'In Progress' : 'Not Started'}
                    </Badge>
                  </div>
                </CardHeader>
                <CardContent className="space-y-4">
                  <CardDescription className="line-clamp-2">
                    {track.description}
                  </CardDescription>

                  <div className="flex items-center gap-6 text-sm text-muted-foreground">
                    <span className="flex items-center gap-1">
                      <BookOpen className="h-4 w-4" />
                      {modules.length} modules
                    </span>
                    {track.estimated_hours && (
                      <span className="flex items-center gap-1">
                        <Clock className="h-4 w-4" />
                        {track.estimated_hours} hours
                      </span>
                    )}
                  </div>

                  <div className="space-y-2">
                    <div className="flex justify-between text-sm">
                      <span className="text-muted-foreground">Progress</span>
                      <span className="font-medium">{progress}%</span>
                    </div>
                    <Progress value={progress} className="h-2" />
                    <div className="text-xs text-muted-foreground">
                      {completedModules} of {modules.length} modules completed
                    </div>
                  </div>
                </CardContent>
              </Card>
            </Link>
          )
        })}
      </div>
    </div>
  )
}
