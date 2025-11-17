import { ModuleProgress, UserProgress } from './types';

// Re-export types for convenience
export type { ModuleProgress, UserProgress } from './types';

const STORAGE_KEY = 'ai-operator-roadmap-progress';

// Initialize default user progress
export const getDefaultUserProgress = (): UserProgress => ({
  modules: [],
  overallPercentage: 0,
  totalChecklistItems: 0,
  completedChecklistItems: 0,
  startDate: new Date(),
  lastActivityDate: new Date(),
});

// Get user progress from localStorage
export const getUserProgress = (): UserProgress => {
  if (typeof window === 'undefined') {
    return getDefaultUserProgress();
  }

  try {
    const stored = localStorage.getItem(STORAGE_KEY);
    if (!stored) {
      const defaultProgress = getDefaultUserProgress();
      saveUserProgress(defaultProgress);
      return defaultProgress;
    }

    const parsed = JSON.parse(stored);
    // Convert date strings back to Date objects
    return {
      ...parsed,
      startDate: new Date(parsed.startDate),
      lastActivityDate: new Date(parsed.lastActivityDate),
      modules: parsed.modules.map((m: any) => ({
        ...m,
        lastAccessed: new Date(m.lastAccessed),
        startedAt: m.startedAt ? new Date(m.startedAt) : undefined,
        completedAt: m.completedAt ? new Date(m.completedAt) : undefined,
      })),
    };
  } catch (error) {
    console.error('Error loading progress:', error);
    return getDefaultUserProgress();
  }
};

// Save user progress to localStorage
export const saveUserProgress = (progress: UserProgress): void => {
  if (typeof window === 'undefined') return;

  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(progress));
  } catch (error) {
    console.error('Error saving progress:', error);
  }
};

// Get progress for a specific module
export const getModuleProgress = (moduleId: string): ModuleProgress | undefined => {
  const userProgress = getUserProgress();
  return userProgress.modules.find((m) => m.moduleId === moduleId);
};

// Initialize module progress if it doesn't exist
export const initializeModuleProgress = (moduleId: string): ModuleProgress => {
  const existing = getModuleProgress(moduleId);
  if (existing) return existing;

  const newModuleProgress: ModuleProgress = {
    moduleId,
    completedSections: [],
    completedChecklistItems: [],
    completionPercentage: 0,
    lastAccessed: new Date(),
    startedAt: new Date(),
  };

  const userProgress = getUserProgress();
  userProgress.modules.push(newModuleProgress);
  userProgress.lastActivityDate = new Date();
  saveUserProgress(userProgress);

  return newModuleProgress;
};

// Toggle a checklist item
export const toggleChecklistItem = (moduleId: string, itemId: string, totalItems: number): void => {
  const userProgress = getUserProgress();
  let moduleProgress = userProgress.modules.find((m) => m.moduleId === moduleId);

  if (!moduleProgress) {
    moduleProgress = initializeModuleProgress(moduleId);
    userProgress.modules.push(moduleProgress);
  }

  const isCompleted = moduleProgress.completedChecklistItems.includes(itemId);

  if (isCompleted) {
    // Remove from completed
    moduleProgress.completedChecklistItems = moduleProgress.completedChecklistItems.filter(
      (id) => id !== itemId
    );
  } else {
    // Add to completed
    moduleProgress.completedChecklistItems.push(itemId);
  }

  // Update completion percentage
  moduleProgress.completionPercentage = totalItems > 0
    ? Math.round((moduleProgress.completedChecklistItems.length / totalItems) * 100)
    : 0;

  // Update last accessed
  moduleProgress.lastAccessed = new Date();
  userProgress.lastActivityDate = new Date();

  // Check if module is fully completed
  if (moduleProgress.completionPercentage === 100 && !moduleProgress.completedAt) {
    moduleProgress.completedAt = new Date();
  } else if (moduleProgress.completionPercentage < 100) {
    moduleProgress.completedAt = undefined;
  }

  // Recalculate overall progress
  userProgress.overallPercentage = calculateOverallProgress(userProgress.modules);
  userProgress.completedChecklistItems = userProgress.modules.reduce(
    (sum, m) => sum + m.completedChecklistItems.length,
    0
  );

  saveUserProgress(userProgress);
};

// Toggle a section
export const toggleSection = (moduleId: string, sectionId: string): void => {
  const userProgress = getUserProgress();
  let moduleProgress = userProgress.modules.find((m) => m.moduleId === moduleId);

  if (!moduleProgress) {
    moduleProgress = initializeModuleProgress(moduleId);
    userProgress.modules.push(moduleProgress);
  }

  const isCompleted = moduleProgress.completedSections.includes(sectionId);

  if (isCompleted) {
    moduleProgress.completedSections = moduleProgress.completedSections.filter(
      (id) => id !== sectionId
    );
  } else {
    moduleProgress.completedSections.push(sectionId);
  }

  moduleProgress.lastAccessed = new Date();
  userProgress.lastActivityDate = new Date();

  saveUserProgress(userProgress);
};

// Calculate overall progress across all modules
export const calculateOverallProgress = (modules: ModuleProgress[]): number => {
  if (modules.length === 0) return 0;

  const totalPercentage = modules.reduce((sum, m) => sum + m.completionPercentage, 0);
  return Math.round(totalPercentage / modules.length);
};

// Mark module as started
export const markModuleAsStarted = (moduleId: string): void => {
  const userProgress = getUserProgress();
  let moduleProgress = userProgress.modules.find((m) => m.moduleId === moduleId);

  if (!moduleProgress) {
    moduleProgress = initializeModuleProgress(moduleId);
  } else if (!moduleProgress.startedAt) {
    moduleProgress.startedAt = new Date();
  }

  moduleProgress.lastAccessed = new Date();
  userProgress.lastActivityDate = new Date();
  saveUserProgress(userProgress);
};

// Mark module as completed
export const markModuleAsCompleted = (moduleId: string): void => {
  const userProgress = getUserProgress();
  const moduleProgress = userProgress.modules.find((m) => m.moduleId === moduleId);

  if (!moduleProgress) return;

  moduleProgress.completedAt = new Date();
  moduleProgress.completionPercentage = 100;
  moduleProgress.lastAccessed = new Date();
  userProgress.lastActivityDate = new Date();

  userProgress.overallPercentage = calculateOverallProgress(userProgress.modules);
  saveUserProgress(userProgress);
};

// Reset all progress
export const resetProgress = (): void => {
  if (typeof window === 'undefined') return;

  if (confirm('Are you sure you want to reset all progress? This cannot be undone.')) {
    localStorage.removeItem(STORAGE_KEY);
    window.location.reload();
  }
};

// Export progress data (for backup)
export const exportProgress = (): string => {
  const progress = getUserProgress();
  return JSON.stringify(progress, null, 2);
};

// Import progress data (from backup)
export const importProgress = (data: string): boolean => {
  try {
    const parsed = JSON.parse(data);
    saveUserProgress(parsed);
    window.location.reload();
    return true;
  } catch (error) {
    console.error('Error importing progress:', error);
    return false;
  }
};

// Get stats for display
export interface ProgressStats {
  totalModules: number;
  startedModules: number;
  completedModules: number;
  overallPercentage: number;
  totalChecklistItems: number;
  completedChecklistItems: number;
  streak: number;
  lastActivity: Date;
}

export const getProgressStats = (totalModules: number, totalChecklistItems: number): ProgressStats => {
  const userProgress = getUserProgress();

  return {
    totalModules,
    startedModules: userProgress.modules.filter((m) => m.startedAt).length,
    completedModules: userProgress.modules.filter((m) => m.completedAt).length,
    overallPercentage: userProgress.overallPercentage,
    totalChecklistItems,
    completedChecklistItems: userProgress.completedChecklistItems,
    streak: 0, // Streak is stored in database (profiles.streak_count), not localStorage
    lastActivity: userProgress.lastActivityDate,
  };
};
