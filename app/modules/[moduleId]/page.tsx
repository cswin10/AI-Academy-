import React from 'react';
import Link from 'next/link';
import { notFound } from 'next/navigation';
import { ChevronLeft, ChevronRight, Clock, Trophy, BookOpen } from 'lucide-react';
import { Button } from '@/components/ui/Button';
import { Card } from '@/components/ui/Card';
import { ProgressBar } from '@/components/ui/ProgressBar';
import { MarkdownRenderer } from '@/components/module/MarkdownRenderer';
import { ChecklistSidebar } from '@/components/module/ChecklistSidebar';
import { getModuleContent, getAllModuleIds } from '@/lib/markdown';

export async function generateStaticParams() {
  const moduleIds = getAllModuleIds();
  return moduleIds.map((id) => ({
    moduleId: id,
  }));
}

export default async function ModulePage({
  params,
}: {
  params: Promise<{ moduleId: string }>;
}) {
  const { moduleId } = await params;
  const moduleContent = getModuleContent(moduleId);

  if (!moduleContent) {
    notFound();
  }

  const { metadata, content, checklistItems } = moduleContent;

  // Calculate progress (for now, just mock - will integrate with ProgressContext later)
  const completedItems = 0;
  const totalItems = checklistItems.length;
  const progress = totalItems > 0 ? (completedItems / totalItems) * 100 : 0;

  // Find prev/next modules by getting all modules and finding adjacent ones
  const allModuleIds = getAllModuleIds();
  const currentIndex = allModuleIds.indexOf(moduleId);
  const prevModule = currentIndex > 0 ? allModuleIds[currentIndex - 1] : null;
  const nextModule = currentIndex < allModuleIds.length - 1 ? allModuleIds[currentIndex + 1] : null;

  return (
    <div className="min-h-screen pb-20">
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
            <h1 className="text-4xl md:text-5xl font-bold text-text-primary mb-4">
              {metadata.title}
            </h1>
            <p className="text-xl text-text-secondary">
              {metadata.description}
            </p>
          </div>

          {/* Meta Info */}
          <div className="flex flex-wrap gap-6 text-sm text-text-secondary mb-6">
            <div className="flex items-center gap-2">
              <Clock className="w-4 h-4" />
              <span>{metadata.estimatedTime}</span>
            </div>
            <div className="flex items-center gap-2">
              <Trophy className="w-4 h-4" />
              <span>{metadata.difficulty}</span>
            </div>
            <div className="flex items-center gap-2">
              <BookOpen className="w-4 h-4" />
              <span>{checklistItems.length} learning objectives</span>
            </div>
          </div>

          {/* Progress */}
          {totalItems > 0 && (
            <div>
              <div className="flex items-center justify-between mb-2">
                <span className="text-sm font-medium text-text-primary">Your Progress</span>
                <span className="text-sm text-text-secondary">
                  {completedItems} / {totalItems} completed
                </span>
              </div>
              <ProgressBar progress={progress} />
            </div>
          )}
        </div>
      </div>

      {/* Main Content */}
      <div className="container mx-auto max-w-5xl px-4 py-12">
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Markdown Content */}
          <div className="lg:col-span-2">
            <Card className="p-8">
              <MarkdownRenderer content={content} />
            </Card>

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
            {/* Checklist */}
            <ChecklistSidebar checklistItems={checklistItems} />

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
    </div>
  );
}
