'use client';

import React from 'react';
import { ModuleCard } from './ModuleCard';
import { useModuleProgress } from '@/hooks/useModuleProgress';
import { useSupabase } from '@/hooks/useSupabase';
import type { ModuleMetadata } from '@/lib/types';

interface ModuleListWithProgressProps {
  modules: ModuleMetadata[];
}

export function ModuleListWithProgress({ modules }: ModuleListWithProgressProps) {
  const { user } = useSupabase();
  const { progress: allProgress } = useModuleProgress();

  // Map progress data to modules
  const moduleCards = modules.map((metadata) => {
    const moduleProgress = allProgress.find(p => p.module_id === metadata.id);

    return {
      metadata,
      progress: moduleProgress?.progress_percentage || 0,
      isStarted: !!moduleProgress && !moduleProgress.completed_at,
      isCompleted: !!moduleProgress?.completed_at,
    };
  });

  // Show sign-in prompt if not logged in
  if (!user) {
    return (
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {modules.map((metadata) => (
          <ModuleCard
            key={metadata.id}
            module={{
              metadata,
              progress: 0,
              isStarted: false,
              isCompleted: false,
            }}
          />
        ))}
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      {moduleCards.map((module) => (
        <ModuleCard key={module.metadata.id} module={module} />
      ))}
    </div>
  );
}
