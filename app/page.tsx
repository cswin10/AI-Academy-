import React from 'react';
import { Hero } from '@/components/home/Hero';
import { ModuleCard } from '@/components/home/ModuleCard';
import { LearningPaths } from '@/components/home/LearningPaths';
import { getAllModules } from '@/lib/markdown';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: "AI Operator Roadmap - From Zero to Professional AI Systems Builder",
  description: "Master AI operations with 15 comprehensive modules. Learn LLMs, automation, RAG systems, and AI agents. Build real-world AI products from scratch. 100% free.",
  openGraph: {
    title: "AI Operator Roadmap - From Zero to Professional AI Systems Builder",
    description: "Master AI operations with 15 comprehensive modules. Learn LLMs, automation, RAG systems, and AI agents.",
    url: "/",
    type: "website",
  },
};

// This will be a server component by default
export default function HomePage() {
  // Load all modules from the filesystem
  const allModules = getAllModules();

  // Convert to ModuleCardData format
  const moduleCards = allModules.map((metadata) => ({
    metadata,
    progress: 0,
    isStarted: false,
    isCompleted: false,
  }));

  // Generate JSON-LD structured data for SEO
  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Course',
    name: 'AI Operator Roadmap',
    description: 'Master AI operations with 15 comprehensive modules. Learn LLMs, automation, RAG systems, and AI agents.',
    provider: {
      '@type': 'Organization',
      name: 'AI Operator Roadmap',
    },
    educationalLevel: 'Beginner to Advanced',
    inLanguage: 'en',
    isAccessibleForFree: true,
    hasCourseInstance: {
      '@type': 'CourseInstance',
      courseMode: 'online',
      courseWorkload: 'PT120H', // ~120 hours total
    },
    numberOfCredits: 0,
    hasPart: allModules.map((module) => ({
      '@type': 'Course',
      name: `Module ${module.number}: ${module.title}`,
      description: module.description,
      educationalLevel: module.difficulty,
      timeRequired: module.estimatedTime,
      url: `/modules/${module.id}`,
    })),
  };

  return (
    <div className="min-h-screen">
      {/* JSON-LD Structured Data */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />

      <Hero />

      {/* Learning Paths */}
      <LearningPaths />

      {/* Modules Section */}
      <section id="modules" className="py-16 px-4">
        <div className="container mx-auto max-w-7xl">
          <div className="text-center mb-12">
            <h2 className="text-4xl font-bold text-text-primary mb-4">
              The Complete Roadmap
            </h2>
            <p className="text-xl text-text-secondary max-w-2xl mx-auto">
              15 comprehensive modules to take you from complete beginner to professional AI operator
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {moduleCards.map((module) => (
              <ModuleCard key={module.metadata.id} module={module} />
            ))}
          </div>
        </div>
      </section>

      {/* What You'll Build Section */}
      <section className="py-16 px-4 bg-surface/30">
        <div className="container mx-auto max-w-5xl text-center">
          <h2 className="text-3xl font-bold text-text-primary mb-4">
            What You'll Build
          </h2>
          <p className="text-lg text-text-secondary mb-8">
            Real projects that demonstrate professional-level AI operations skills
          </p>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-8">
            <div className="bg-background border border-gray-800 rounded-xl p-6">
              <h3 className="text-xl font-bold text-purple-primary mb-2">Content Systems</h3>
              <p className="text-sm text-text-secondary">
                AI-powered content engines that generate, edit, and distribute content at scale
              </p>
            </div>
            <div className="bg-background border border-gray-800 rounded-xl p-6">
              <h3 className="text-xl font-bold text-purple-primary mb-2">Automation Workflows</h3>
              <p className="text-sm text-text-secondary">
                End-to-end automation systems that save hours of manual work
              </p>
            </div>
            <div className="bg-background border border-gray-800 rounded-xl p-6">
              <h3 className="text-xl font-bold text-purple-primary mb-2">AI Products</h3>
              <p className="text-sm text-text-secondary">
                Complete AI-powered products ready for real users
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
