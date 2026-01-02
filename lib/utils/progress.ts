import { createClient } from '@/lib/supabase/client'
import type {
  Section,
  Module,
  Track,
  UserSectionProgress,
  UserModuleProgress,
  UserTrackProgress,
  QuizAttempt
} from '@/lib/types'

// Check if a section is unlocked for a user
export async function isSectionUnlocked(
  userId: string,
  sectionId: string,
  allSections: Section[],
  sectionProgress: UserSectionProgress[]
): Promise<boolean> {
  const section = allSections.find(s => s.id === sectionId)
  if (!section) return false

  // First section in a module is always unlocked
  if (section.order_index === 1) return true

  // Find the previous section
  const previousSection = allSections.find(
    s => s.module_id === section.module_id && s.order_index === section.order_index - 1
  )

  if (!previousSection) return true

  // Check if previous section is completed
  const previousProgress = sectionProgress.find(
    p => p.section_id === previousSection.id && p.user_id === userId
  )

  return previousProgress?.is_completed ?? false
}

// Check if a module is unlocked for a user
export async function isModuleUnlocked(
  userId: string,
  moduleId: string,
  modules: Module[],
  moduleProgress: UserModuleProgress[]
): Promise<boolean> {
  const module = modules.find(m => m.id === moduleId)
  if (!module) return false

  // If no prerequisites, always unlocked
  if (!module.prerequisite_module_ids || module.prerequisite_module_ids.length === 0) {
    return true
  }

  // Check if all prerequisites are completed
  for (const prereqId of module.prerequisite_module_ids) {
    const progress = moduleProgress.find(
      p => p.module_id === prereqId && p.user_id === userId
    )
    if (!progress?.is_completed) {
      return false
    }
  }

  return true
}

// Get the next unlocked section for a user
export function getNextSection(
  currentSectionId: string,
  allSections: Section[],
  sectionProgress: UserSectionProgress[]
): Section | null {
  const currentSection = allSections.find(s => s.id === currentSectionId)
  if (!currentSection) return null

  // Find sections in the same module with higher order_index
  const nextSections = allSections
    .filter(s =>
      s.module_id === currentSection.module_id &&
      s.order_index > currentSection.order_index
    )
    .sort((a, b) => a.order_index - b.order_index)

  return nextSections[0] || null
}

// Calculate module progress percentage
export function calculateModuleProgress(
  moduleId: string,
  sections: Section[],
  sectionProgress: UserSectionProgress[]
): number {
  const moduleSections = sections.filter(s => s.module_id === moduleId)
  if (moduleSections.length === 0) return 0

  const completedCount = moduleSections.filter(section =>
    sectionProgress.some(p =>
      p.section_id === section.id && p.is_completed
    )
  ).length

  return Math.round((completedCount / moduleSections.length) * 100)
}

// Calculate track progress percentage (based on completed modules only - legacy)
export function calculateTrackProgress(
  trackId: string,
  modules: Module[],
  moduleProgress: UserModuleProgress[]
): number {
  const trackModules = modules.filter(m => m.track_id === trackId)
  if (trackModules.length === 0) return 0

  const completedCount = trackModules.filter(module =>
    moduleProgress.some(p =>
      p.module_id === module.id && p.is_completed
    )
  ).length

  return Math.round((completedCount / trackModules.length) * 100)
}

// Calculate track progress based on sections completed (more granular)
export function calculateTrackProgressBySection(
  trackId: string,
  modules: Module[],
  sections: Section[],
  sectionProgress: UserSectionProgress[]
): number {
  const trackModules = modules.filter(m => m.track_id === trackId)
  if (trackModules.length === 0) return 0

  const trackModuleIds = trackModules.map(m => m.id)
  const trackSections = sections.filter(s => trackModuleIds.includes(s.module_id))
  if (trackSections.length === 0) return 0

  const completedSections = trackSections.filter(section =>
    sectionProgress.some(p => p.section_id === section.id && p.is_completed)
  ).length

  return Math.round((completedSections / trackSections.length) * 100)
}

// Get section status
export type SectionStatus = 'locked' | 'available' | 'in_progress' | 'completed'

export function getSectionStatus(
  section: Section,
  sectionProgress: UserSectionProgress | null,
  isUnlocked: boolean
): SectionStatus {
  if (!isUnlocked) return 'locked'
  if (sectionProgress?.is_completed) return 'completed'
  if (sectionProgress) return 'in_progress'
  return 'available'
}

// Get module status
export type ModuleStatus = 'locked' | 'not_started' | 'in_progress' | 'completed'

export function getModuleStatus(
  module: Module,
  moduleProgress: UserModuleProgress | null,
  isUnlocked: boolean
): ModuleStatus {
  if (!isUnlocked) return 'locked'
  if (moduleProgress?.is_completed) return 'completed'
  if (moduleProgress && moduleProgress.sections_completed > 0) return 'in_progress'
  if (moduleProgress) return 'in_progress'
  return 'not_started'
}

// Get last accessed section
export function getLastAccessedSection(
  sectionProgress: UserSectionProgress[]
): UserSectionProgress | null {
  if (sectionProgress.length === 0) return null

  return sectionProgress.reduce((latest, current) => {
    const latestDate = new Date(latest.last_accessed_at)
    const currentDate = new Date(current.last_accessed_at)
    return currentDate > latestDate ? current : latest
  })
}

// Format time spent
export function formatTimeSpent(seconds: number): string {
  if (seconds < 60) {
    return `${seconds}s`
  } else if (seconds < 3600) {
    const minutes = Math.floor(seconds / 60)
    return `${minutes}m`
  } else {
    const hours = Math.floor(seconds / 3600)
    const minutes = Math.floor((seconds % 3600) / 60)
    return `${hours}h ${minutes}m`
  }
}

// Format estimated time
export function formatEstimatedTime(minutes: number | null): string {
  if (!minutes) return ''
  if (minutes < 60) {
    return `${minutes} min`
  }
  const hours = Math.floor(minutes / 60)
  const remainingMinutes = minutes % 60
  if (remainingMinutes === 0) {
    return `${hours} hr`
  }
  return `${hours} hr ${remainingMinutes} min`
}
