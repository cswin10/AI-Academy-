import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import { ProfileContent } from '@/components/profile/profile-content'

export default async function ProfilePage() {
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Run all queries in parallel for better performance
  const [
    { data: profile },
    { data: userAchievements },
    { data: allAchievements },
    { data: tracks },
    { data: moduleProgress },
  ] = await Promise.all([
    supabase
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .single(),
    supabase
      .from('user_achievements')
      .select(`
        *,
        achievement:achievements(*)
      `)
      .eq('user_id', user.id)
      .order('earned_at', { ascending: false }),
    supabase
      .from('achievements')
      .select('*')
      .eq('is_active', true)
      .order('category'),
    supabase
      .from('tracks')
      .select(`
        *,
        modules:modules(id)
      `)
      .eq('is_active', true)
      .order('order_index'),
    supabase
      .from('user_module_progress')
      .select('*')
      .eq('user_id', user.id),
  ])

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
