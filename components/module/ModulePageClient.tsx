'use client';

import React, { useEffect } from 'react';
import Link from 'next/link';
import { ChevronLeft, ChevronRight, CheckCircle2 } from 'lucide-react';
import { Button } from '@/components/ui/Button';
import { Card } from '@/components/ui/Card';
import { ProgressBar } from '@/components/ui/ProgressBar';
import { MarkdownRenderer } from '@/components/module/MarkdownRenderer';
import { ChecklistSidebarClient } from '@/components/module/ChecklistSidebarClient';
import { QuizContainer } from '@/components/quiz/QuizContainer';
import { ProgressRoadmap } from '@/components/home/ProgressRoadmap';
import { SectionCard } from '@/components/module/SectionCard';
import { TaskCard } from '@/components/module/TaskCard';
import { SectionQuizComponent } from '@/components/module/SectionQuizComponent';
import { useModuleProgress } from '@/hooks/useModuleProgress';
import { useChecklistProgress } from '@/hooks/useChecklistProgress';
import { useSupabase } from '@/hooks/useSupabase';
import type { ModuleMetadata, ModuleSection } from '@/lib/types';

interface ModulePageClientProps {
  moduleId: string;
  metadata: ModuleMetadata;
  content: string;
  checklistItems: Array<{
    id: string;
    text: string;
    category?: string;
  }>;
  prevModule: string | null;
  nextModule: string | null;
  allModules: ModuleMetadata[];
  structuredSections?: ModuleSection[];
}

export function ModulePageClient({
  moduleId,
  metadata,
  content,
  checklistItems,
  prevModule,
  nextModule,
  allModules,
  structuredSections,
}: ModulePageClientProps) {
  const { user } = useSupabase();
  const { progress: allProgress, startModule, completeModule } = useModuleProgress();
  const { completed } = useChecklistProgress(moduleId);

  // Get current module progress
  const moduleProgress = allProgress.find(p => p.module_id === moduleId);
  const isCompleted = !!moduleProgress?.completed_at;

  // Calculate progress based on checklist
  const completedItems = completed.size;
  const totalItems = checklistItems.length;
  const progress = totalItems > 0 ? (completedItems / totalItems) * 100 : 0;

  // Start the module when user first views it
  useEffect(() => {
    if (user && !moduleProgress) {
      startModule(moduleId);
    }
  }, [user, moduleId, moduleProgress, startModule]);

  // Handle completing the module
  const handleCompleteModule = async () => {
    if (!user) {
      alert('Please sign in to track your progress');
      return;
    }

    const success = await completeModule(moduleId);
    if (success) {
      alert('🎉 Module completed! +500 XP earned!');
    }
  };

  // Get completed module IDs for progress roadmap
  const completedModuleIds = allProgress
    .filter(p => p.completed_at)
    .map(p => p.module_id);

  return (
    <>
      {/* Module Header */}
      <div className="bg-surface border-b border-gray-800">
        <div className="container mx-auto max-w-5xl px-4 py-8">
          {/* Breadcrumb */}
          <Link
            href="/"
            className="inline-flex items-center text-sm text-text-secondary hover:text-purple-primary transition-colors mb-6"
          >
            <ChevronLeft className="w-4 h-4 mr-1" />
            Back to Modules
          </Link>

          {/* Module Info */}
          <div className="mb-6">
            <div className="text-sm text-purple-primary font-semibold mb-2">
              Module {metadata.number} • {metadata.category}
            </div>
            <div className="flex items-start justify-between">
              <div className="flex-1">
                <h1 className="text-4xl md:text-5xl font-bold text-text-primary mb-4">
                  {metadata.title}
                </h1>
                <p className="text-xl text-text-secondary">
                  {metadata.description}
                </p>
              </div>
              {isCompleted && (
                <CheckCircle2 className="w-12 h-12 text-success ml-4 flex-shrink-0" />
              )}
            </div>
          </div>

          {/* Progress */}
          {user && totalItems > 0 && (
            <div className="mb-6">
              <div className="flex items-center justify-between mb-2">
                <span className="text-sm font-medium text-text-primary">Your Progress</span>
                <span className="text-sm text-text-secondary">
                  {completedItems} / {totalItems} objectives completed
                </span>
              </div>
              <ProgressBar progress={progress} />
            </div>
          )}

          {/* Complete Module Button */}
          {user && !isCompleted && progress >= 80 && (
            <Button
              onClick={handleCompleteModule}
              variant="primary"
              icon={<CheckCircle2 className="w-4 h-4" />}
              className="mt-4"
            >
              Mark Module as Complete (+500 XP)
            </Button>
          )}
        </div>
      </div>

      {/* Main Content */}
      <div className="container mx-auto max-w-5xl px-4 py-12">
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Content Area */}
          <div className="lg:col-span-2">
            {structuredSections && structuredSections.length > 0 ? (
              /* New Structured Layout */
              <div className="space-y-6">
                {structuredSections.map((section, index) => (
                  <div key={section.id}>
                    {/* Section Content */}
                    <SectionCard
                      title={section.title}
                      content={section.content}
                      sectionNumber={section.sectionNumber}
                      defaultExpanded={index === 0}
                    />

                    {/* Tasks for this section */}
                    {section.tasks && section.tasks.length > 0 && (
                      <div className="space-y-4 mt-4">
                        {section.tasks.map(task => (
                          <TaskCard
                            key={task.id}
                            taskId={task.id}
                            moduleId={moduleId}
                            title={task.title}
                            description={task.description}
                            xpReward={task.xpReward}
                          />
                        ))}
                      </div>
                    )}

                    {/* Quiz for this section */}
                    {section.quiz && (
                      <div className="mt-4">
                        <SectionQuizComponent quiz={section.quiz} />
                      </div>
                    )}
                  </div>
                ))}
              </div>
            ) : (
              /* Legacy Layout (for modules not yet restructured) */
              <>
                <Card className="p-8">
                  <MarkdownRenderer content={content} />
                </Card>

                {/* Quiz Section */}
                <div className="mt-8">
                  <QuizContainer moduleId={moduleId} />
                </div>
              </>
            )}

            {/* Navigation */}
            <div className="flex items-center justify-between mt-8">
              {prevModule ? (
                <Link href={`/modules/${prevModule}`}>
                  <Button variant="secondary">
                    <ChevronLeft className="w-4 h-4 mr-2" />
                    Previous Module
                  </Button>
                </Link>
              ) : (
                <div />
              )}

              {nextModule ? (
                <Link href={`/modules/${nextModule}`}>
                  <Button variant="primary">
                    Next Module
                    <ChevronRight className="w-4 h-4 ml-2" />
                  </Button>
                </Link>
              ) : (
                <div />
              )}
            </div>
          </div>

          {/* Sidebar */}
          <div className="lg:col-span-1">
            {/* Progress Roadmap */}
            <div className="mb-6">
              <ProgressRoadmap
                modules={allModules}
                currentModuleId={moduleId}
                completedModuleIds={completedModuleIds}
              />
            </div>

            {/* Checklist */}
            <ChecklistSidebarClient
              moduleId={moduleId}
              checklistItems={checklistItems}
            />

            {/* Prerequisites */}
            {metadata.prerequisites.length > 0 && (
              <Card className="p-6 mt-6">
                <h3 className="text-lg font-bold text-text-primary mb-4">
                  Prerequisites
                </h3>
                <ul className="space-y-2">
                  {metadata.prerequisites.map((prereq) => (
                    <li key={prereq} className="text-sm text-text-secondary">
                      • Module: {prereq}
                    </li>
                  ))}
                </ul>
              </Card>
            )}
          </div>
        </div>
      </div>
    </>
  );
}
