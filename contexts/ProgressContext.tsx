'use client';

import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import {
  UserProgress,
  ModuleProgress,
  ProgressStats,
  getUserProgress,
  toggleChecklistItem as toggleChecklistItemUtil,
  toggleSection as toggleSectionUtil,
  markModuleAsStarted as markModuleAsStartedUtil,
  markModuleAsCompleted as markModuleAsCompletedUtil,
  resetProgress as resetProgressUtil,
  getModuleProgress as getModuleProgressUtil,
  getProgressStats as getProgressStatsUtil,
} from '../lib/progress';

interface ProgressContextType {
  userProgress: UserProgress;
  getModuleProgress: (moduleId: string) => ModuleProgress | undefined;
  toggleChecklistItem: (moduleId: string, itemId: string, totalItems: number) => void;
  toggleSection: (moduleId: string, sectionId: string) => void;
  markModuleAsStarted: (moduleId: string) => void;
  markModuleAsCompleted: (moduleId: string) => void;
  resetProgress: () => void;
  getStats: (totalModules: number, totalChecklistItems: number) => ProgressStats;
  refreshProgress: () => void;
}

const ProgressContext = createContext<ProgressContextType | undefined>(undefined);

export const ProgressProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [userProgress, setUserProgress] = useState<UserProgress>(() => getUserProgress());

  // Refresh progress from localStorage
  const refreshProgress = () => {
    setUserProgress(getUserProgress());
  };

  // Sync with localStorage on mount and when storage changes
  useEffect(() => {
    const handleStorageChange = () => {
      refreshProgress();
    };

    window.addEventListener('storage', handleStorageChange);
    return () => window.removeEventListener('storage', handleStorageChange);
  }, []);

  const getModuleProgress = (moduleId: string) => {
    return getModuleProgressUtil(moduleId);
  };

  const toggleChecklistItem = (moduleId: string, itemId: string, totalItems: number) => {
    toggleChecklistItemUtil(moduleId, itemId, totalItems);
    refreshProgress();
  };

  const toggleSection = (moduleId: string, sectionId: string) => {
    toggleSectionUtil(moduleId, sectionId);
    refreshProgress();
  };

  const markModuleAsStarted = (moduleId: string) => {
    markModuleAsStartedUtil(moduleId);
    refreshProgress();
  };

  const markModuleAsCompleted = (moduleId: string) => {
    markModuleAsCompletedUtil(moduleId);
    refreshProgress();
  };

  const resetProgress = () => {
    resetProgressUtil();
    refreshProgress();
  };

  const getStats = (totalModules: number, totalChecklistItems: number) => {
    return getProgressStatsUtil(totalModules, totalChecklistItems);
  };

  const value: ProgressContextType = {
    userProgress,
    getModuleProgress,
    toggleChecklistItem,
    toggleSection,
    markModuleAsStarted,
    markModuleAsCompleted,
    resetProgress,
    getStats,
    refreshProgress,
  };

  return <ProgressContext.Provider value={value}>{children}</ProgressContext.Provider>;
};

export const useProgress = (): ProgressContextType => {
  const context = useContext(ProgressContext);
  if (!context) {
    throw new Error('useProgress must be used within a ProgressProvider');
  }
  return context;
};
