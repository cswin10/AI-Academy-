'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { cn } from '@/lib/utils/cn'
import {
  LayoutDashboard,
  BookOpen,
  Trophy,
  User,
  LogOut,
  Sparkles,
  Flame,
  X,
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Progress } from '@/components/ui/progress'
import { createClient } from '@/lib/supabase/client'
import { useRouter } from 'next/navigation'
import type { Profile } from '@/lib/types'
import { calculateLevel, getLevelTitle } from '@/lib/utils/gamification'

const navItems = [
  { href: '/dashboard', label: 'Dashboard', icon: LayoutDashboard },
  { href: '/tracks', label: 'Tracks', icon: BookOpen },
  { href: '/achievements', label: 'Achievements', icon: Trophy },
  { href: '/profile', label: 'Profile', icon: User },
]

interface SidebarProps {
  profile: Profile | null
  isOpen?: boolean
  onClose?: () => void
}

export function Sidebar({ profile, isOpen, onClose }: SidebarProps) {
  const pathname = usePathname()
  const router = useRouter()
  const supabase = createClient()

  const levelInfo = profile ? calculateLevel(profile.xp_total) : null

  const handleLogout = async () => {
    await supabase.auth.signOut()
    router.push('/login')
    router.refresh()
  }

  return (
    <>
      {/* Mobile overlay */}
      {isOpen && (
        <div
          className="fixed inset-0 bg-black/50 z-40 lg:hidden"
          onClick={onClose}
        />
      )}

      {/* Sidebar */}
      <aside
        className={cn(
          'fixed inset-y-0 left-0 z-50 w-64 bg-card border-r border-border flex flex-col transition-transform duration-200 lg:translate-x-0',
          isOpen ? 'translate-x-0' : '-translate-x-full'
        )}
      >
        {/* Header */}
        <div className="flex items-center justify-between h-16 px-4 border-b border-border">
          <Link href="/dashboard" className="flex items-center gap-2">
            <Sparkles className="h-6 w-6 text-primary" />
            <span className="font-bold">AI Academy</span>
          </Link>
          <Button
            variant="ghost"
            size="icon"
            className="lg:hidden"
            onClick={onClose}
          >
            <X className="h-5 w-5" />
          </Button>
        </div>

        {/* User Stats */}
        {profile && levelInfo && (
          <div className="p-4 border-b border-border">
            <div className="flex items-center gap-3 mb-3">
              <div className="p-2 rounded-full bg-primary/10">
                <Sparkles className="h-5 w-5 text-primary" />
              </div>
              <div>
                <div className="font-medium">{profile.display_name || 'Learner'}</div>
                <div className="text-xs text-muted-foreground">
                  Level {levelInfo.level} - {getLevelTitle(levelInfo.level)}
                </div>
              </div>
            </div>
            <div className="space-y-2">
              <div className="flex justify-between text-xs">
                <span className="text-muted-foreground">XP Progress</span>
                <span className="text-primary font-medium">
                  {profile.xp_total} / {levelInfo.xpForNextLevel}
                </span>
              </div>
              <Progress value={levelInfo.progress} className="h-1.5" />
            </div>
            {profile.current_streak > 0 && (
              <div className="flex items-center gap-2 mt-3 text-sm">
                <Flame className="h-4 w-4 text-warning streak-fire" />
                <span className="font-medium">{profile.current_streak} day streak</span>
              </div>
            )}
          </div>
        )}

        {/* Navigation */}
        <nav className="flex-1 p-4 space-y-1">
          {navItems.map((item) => {
            const isActive = pathname === item.href ||
              (item.href !== '/dashboard' && pathname.startsWith(item.href))

            return (
              <Link key={item.href} href={item.href} onClick={onClose}>
                <div
                  className={cn(
                    'flex items-center gap-3 px-3 py-2 rounded-md text-sm transition-colors',
                    isActive
                      ? 'bg-primary/10 text-primary'
                      : 'text-muted-foreground hover:text-foreground hover:bg-muted'
                  )}
                >
                  <item.icon className="h-5 w-5" />
                  {item.label}
                </div>
              </Link>
            )
          })}
        </nav>

        {/* Logout */}
        <div className="p-4 border-t border-border">
          <Button
            variant="ghost"
            className="w-full justify-start text-muted-foreground hover:text-foreground"
            onClick={handleLogout}
          >
            <LogOut className="h-5 w-5 mr-3" />
            Sign out
          </Button>
        </div>
      </aside>
    </>
  )
}
