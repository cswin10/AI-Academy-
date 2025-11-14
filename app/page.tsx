import React from 'react';
import { Hero } from '@/components/home/Hero';
import { ModuleCard } from '@/components/home/ModuleCard';
import { getAllModules } from '@/lib/markdown';

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

  return (
    <div className="min-h-screen">
      <Hero />

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
