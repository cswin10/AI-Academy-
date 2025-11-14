import React from 'react';
import { notFound } from 'next/navigation';
import { ModulePageClient } from '@/components/module/ModulePageClient';
import { getModuleContent, getAllModuleIds, getAllModules } from '@/lib/markdown';
import type { Metadata } from 'next';

export async function generateStaticParams() {
  const moduleIds = getAllModuleIds();
  return moduleIds.map((id) => ({
    moduleId: id,
  }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ moduleId: string }>;
}): Promise<Metadata> {
  const { moduleId } = await params;
  const moduleContent = getModuleContent(moduleId);

  if (!moduleContent) {
    return {
      title: 'Module Not Found',
    };
  }

  const { metadata } = moduleContent;

  return {
    title: `Module ${metadata.number}: ${metadata.title}`,
    description: metadata.description,
    openGraph: {
      title: `Module ${metadata.number}: ${metadata.title}`,
      description: metadata.description,
      url: `/modules/${moduleId}`,
      type: 'article',
    },
    twitter: {
      card: 'summary_large_image',
      title: `Module ${metadata.number}: ${metadata.title}`,
      description: metadata.description,
    },
  };
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

  const { metadata, content, checklistItems, structuredSections } = moduleContent;

  // Find prev/next modules by number (not alphabetically)
  // Get all modules sorted by number, then find adjacent ones
  const allModules = getAllModuleIds()
    .map((id) => {
      const content = getModuleContent(id);
      return content ? { id, number: content.metadata.number } : null;
    })
    .filter((m): m is { id: string; number: number } => m !== null)
    .sort((a, b) => a.number - b.number);

  const currentIndex = allModules.findIndex(m => m.id === moduleId);
  const prevModule = currentIndex > 0 ? allModules[currentIndex - 1].id : null;
  const nextModule = currentIndex < allModules.length - 1 ? allModules[currentIndex + 1].id : null;

  // Get all modules for progress roadmap
  const allModulesMetadata = getAllModules();

  return (
    <div className="min-h-screen pb-20">
      <ModulePageClient
        moduleId={moduleId}
        metadata={metadata}
        content={content}
        checklistItems={checklistItems}
        structuredSections={structuredSections}
        prevModule={prevModule}
        nextModule={nextModule}
        allModules={allModulesMetadata}
      />
    </div>
  );
}
