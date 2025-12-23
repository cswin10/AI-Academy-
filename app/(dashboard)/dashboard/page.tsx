import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import { DashboardContent } from '@/components/dashboard/dashboard-content'

export default async function DashboardPage() {
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Run all queries in parallel for better performance
  const [
    { data: profile },
    { data: tracks },
    { data: sectionProgress },
    { data: moduleProgress },
    { data: recentAchievements },
  ] = await Promise.all([
    supabase
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .single(),
    supabase
      .from('tracks')
      .select(`
        *,
        modules:modules(*)
      `)
      .eq('is_active', true)
      .order('order_index'),
    supabase
      .from('user_section_progress')
      .select('*')
      .eq('user_id', user.id),
    supabase
      .from('user_module_progress')
      .select('*')
      .eq('user_id', user.id),
    supabase
      .from('user_achievements')
      .select(`
        *,
        achievement:achievements(*)
      `)
      .eq('user_id', user.id)
      .order('earned_at', { ascending: false })
      .limit(3),
  ])

  // Get last accessed section with module and track info
  const lastAccessedProgress = sectionProgress?.length
    ? sectionProgress.reduce((latest, current) =>
        new Date(current.last_accessed_at) > new Date(latest.last_accessed_at)
          ? current
          : latest
      )
    : null

  let lastAccessedSection = null
  if (lastAccessedProgress) {
    const { data: section } = await supabase
      .from('sections')
      .select(`
        *,
        module:modules(
          *,
          track:tracks(*)
        )
      `)
      .eq('id', lastAccessedProgress.section_id)
      .single()

    lastAccessedSection = section
  }

  return (
    <DashboardContent
      profile={profile}
      tracks={tracks || []}
      sectionProgress={sectionProgress || []}
      moduleProgress={moduleProgress || []}
      recentAchievements={recentAchievements || []}
      lastAccessedSection={lastAccessedSection}
    />
  )
}
