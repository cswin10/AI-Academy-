'use client';

import React from 'react';
import Link from 'next/link';
import { CheckCircle2, Circle, ChevronRight } from 'lucide-react';
import { ModuleMetadata } from '@/lib/types';

interface ProgressRoadmapProps {
  modules: ModuleMetadata[];
  currentModuleId?: string;
  completedModuleIds?: string[];
}

export const ProgressRoadmap: React.FC<ProgressRoadmapProps> = ({
  modules,
  currentModuleId,
  completedModuleIds = [],
}) => {
  return (
    <div className="bg-surface/30 border border-gray-800 rounded-lg p-6">
      <h3 className="text-lg font-bold text-text-primary mb-4">Your Learning Path</h3>

      <div className="space-y-2">
        {modules.map((module, index) => {
          const isCompleted = completedModuleIds.includes(module.id);
          const isCurrent = currentModuleId === module.id;
          const isAccessible = index === 0 || completedModuleIds.includes(modules[index - 1].id);

          return (
            <Link
              key={module.id}
              href={`/modules/${module.id}`}
              className={`
                block group relative
                ${!isAccessible && !isCurrent ? 'pointer-events-none opacity-50' : ''}
              `}
            >
              <div
                className={`
                  flex items-center gap-3 p-3 rounded-lg transition-all
                  ${isCurrent ? 'bg-purple-primary/10 border-2 border-purple-primary' : 'border border-gray-800'}
                  ${!isCurrent && isAccessible ? 'hover:bg-gray-800/50' : ''}
                `}
              >
                {/* Status Icon */}
                <div className="flex-shrink-0">
                  {isCompleted ? (
                    <CheckCircle2 className="w-5 h-5 text-success" />
                  ) : isCurrent ? (
                    <div className="w-5 h-5 rounded-full border-2 border-purple-primary flex items-center justify-center">
                      <div className="w-2 h-2 rounded-full bg-purple-primary animate-pulse" />
                    </div>
                  ) : (
                    <Circle className="w-5 h-5 text-gray-600" />
                  )}
                </div>

                {/* Module Info */}
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2 mb-1">
                    <span className="text-xs font-semibold text-purple-primary">
                      {String(module.number).padStart(2, '0')}
                    </span>
                    {module.skillLevel && (
                      <span className={`
                        text-xs px-1.5 py-0.5 rounded
                        ${module.skillLevel === 'No-code' ? 'bg-teal-500/10 text-teal-400' : ''}
                        ${module.skillLevel === 'Low-code' ? 'bg-blue-500/10 text-blue-400' : ''}
                        ${module.skillLevel === 'Code' ? 'bg-purple-500/10 text-purple-400' : ''}
                      `}>
                        {module.skillLevel}
                      </span>
                    )}
                  </div>
                  <p className={`
                    text-sm font-medium truncate
                    ${isCurrent ? 'text-purple-primary' : 'text-text-primary'}
                  `}>
                    {module.title}
                  </p>
                </div>

                {/* Arrow */}
                {isAccessible && (
                  <ChevronRight className="w-4 h-4 text-text-secondary group-hover:text-purple-primary transition-colors" />
                )}

                {/* "You are here" indicator */}
                {isCurrent && (
                  <div className="absolute -right-2 top-1/2 -translate-y-1/2">
                    <div className="bg-purple-primary text-white text-xs font-bold px-2 py-1 rounded whitespace-nowrap">
                      You are here
                    </div>
                  </div>
                )}
              </div>

              {/* Connector line */}
              {index < modules.length - 1 && (
                <div className="ml-6 my-1">
                  <div className={`
                    w-0.5 h-4
                    ${isCompleted ? 'bg-success' : 'bg-gray-800'}
                  `} />
                </div>
              )}
            </Link>
          );
        })}
      </div>
    </div>
  );
};
