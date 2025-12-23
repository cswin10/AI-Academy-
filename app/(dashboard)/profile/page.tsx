import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import { ProfileContent } from '@/components/profile/profile-content'

export default async function ProfilePage() {
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Fetch profile
  const { data: profile } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', user.id)
    .single()

  // Fetch user's achievements
  const { data: userAchievements } = await supabase
    .from('user_achievements')
    .select(`
      *,
      achievement:achievements(*)
    `)
    .eq('user_id', user.id)
    .order('earned_at', { ascending: false })

  // Fetch all achievements for progress display
  const { data: allAchievements } = await supabase
    .from('achievements')
    .select('*')
    .eq('is_active', true)
    .order('category')

  // Fetch track progress
  const { data: tracks } = await supabase
    .from('tracks')
    .select(`
      *,
      modules:modules(id)
    `)
    .eq('is_active', true)
    .order('order_index')

  const { data: moduleProgress } = await supabase
    .from('user_module_progress')
    .select('*')
    .eq('user_id', user.id)

  return (
    <ProfileContent
      profile={profile}
      userAchievements={userAchievements || []}
      allAchievements={allAchievements || []}
      tracks={tracks || []}
      moduleProgress={moduleProgress || []}
    />
  )
}
