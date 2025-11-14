'use client';

import React from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { ChevronDown, ChevronRight, CheckCircle2 } from 'lucide-react';
import { useProgress } from '@/contexts/ProgressContext';
import { ModuleMetadata } from '@/lib/types';

interface SidebarProps {
  modules: ModuleMetadata[];
  isOpen?: boolean;
}

export const Sidebar: React.FC<SidebarProps> = ({ modules, isOpen = true }) => {
  const pathname = usePathname();
  const { getModuleProgress } = useProgress();

  if (!isOpen) return null;

  return (
    <aside className="w-64 h-[calc(100vh-4rem)] sticky top-16 border-r border-gray-800 bg-surface/50 overflow-y-auto">
      <div className="p-4">
        <h3 className="text-sm font-semibold text-text-secondary uppercase tracking-wider mb-4">
          Modules
        </h3>

        <nav className="space-y-1">
          {modules.map((module) => {
            const progress = getModuleProgress(module.id);
            const isActive = pathname?.includes(module.id);
            const completionPercentage = progress?.completionPercentage || 0;
            const isCompleted = completionPercentage === 100;

            return (
              <Link
                key={module.id}
                href={`/modules/${module.id}`}
                className={`
                  block px-3 py-2.5 rounded-lg transition-all duration-200
                  ${isActive
                    ? 'bg-purple-primary/20 border-l-2 border-purple-primary text-purple-light'
                    : 'hover:bg-gray-800/50 text-text-secondary hover:text-text-primary'
                  }
                `}
              >
                <div className="flex items-start gap-2">
                  <div className="flex-shrink-0 mt-0.5">
                    {isCompleted ? (
                      <CheckCircle2 className="w-4 h-4 text-success" />
                    ) : completionPercentage > 0 ? (
                      <div className="w-4 h-4 rounded-full border-2 border-warning relative">
                        <div
                          className="absolute inset-0 bg-warning rounded-full"
                          style={{
                            clipPath: `inset(${100 - completionPercentage}% 0 0 0)`,
                          }}
                        />
                      </div>
                    ) : (
                      <div className="w-4 h-4 rounded-full border-2 border-gray-600" />
                    )}
                  </div>

                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-1.5">
                      <span className="text-xs font-semibold text-purple-primary">
                        {String(module.number).padStart(2, '0')}
                      </span>
                      <h4 className="text-sm font-medium truncate">{module.title}</h4>
                    </div>

                    {completionPercentage > 0 && (
                      <div className="mt-1 flex items-center gap-2">
                        <div className="flex-1 h-1 bg-gray-800 rounded-full overflow-hidden">
                          <div
                            className="h-full bg-purple-primary transition-all duration-300"
                            style={{ width: `${completionPercentage}%` }}
                          />
                        </div>
                        <span className="text-xs text-text-secondary font-medium">
                          {completionPercentage}%
                        </span>
                      </div>
                    )}
                  </div>
                </div>
              </Link>
            );
          })}
        </nav>
      </div>
    </aside>
  );
};
