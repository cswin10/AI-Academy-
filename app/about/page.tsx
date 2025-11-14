import React from 'react';
import Link from 'next/link';
import { ArrowRight, Target, Users, Zap } from 'lucide-react';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';

export default function AboutPage() {
  return (
    <div className="min-h-screen pb-20">
      {/* Hero Section */}
      <section className="py-20 px-4 bg-gradient-to-b from-surface to-background">
        <div className="container mx-auto max-w-4xl text-center">
          <h1 className="text-5xl md:text-6xl font-bold text-text-primary mb-6">
            About the AI Operator Roadmap
          </h1>
          <p className="text-xl text-text-secondary max-w-2xl mx-auto">
            A comprehensive learning platform designed to transform you from complete beginner
            to professional AI operator in months, not years.
          </p>
        </div>
      </section>

      {/* Mission Section */}
      <section className="py-16 px-4">
        <div className="container mx-auto max-w-4xl">
          <Card className="p-8 md:p-12">
            <h2 className="text-3xl font-bold text-text-primary mb-6">Our Mission</h2>
            <p className="text-lg text-text-secondary leading-relaxed mb-4">
              The AI revolution is creating massive opportunities, but most people don't know
              how to capitalize on them. Traditional education is too slow, bootcamps are too
              expensive, and self-learning is too scattered.
            </p>
            <p className="text-lg text-text-secondary leading-relaxed">
              We built the AI Operator Roadmap to solve this problem—a structured,
              comprehensive path from zero to professional that anyone can follow.
            </p>
          </Card>
        </div>
      </section>

      {/* What You'll Learn */}
      <section className="py-16 px-4 bg-surface/30">
        <div className="container mx-auto max-w-6xl">
          <h2 className="text-3xl font-bold text-text-primary text-center mb-12">
            What Makes This Different
          </h2>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <Card className="p-6">
              <div className="w-12 h-12 bg-purple-primary/10 rounded-lg flex items-center justify-center mb-4">
                <Target className="w-6 h-6 text-purple-primary" />
              </div>
              <h3 className="text-xl font-bold text-text-primary mb-3">
                Practical, Not Theoretical
              </h3>
              <p className="text-text-secondary">
                Every module includes hands-on projects you can add to your portfolio.
                No fluff, no theory-only content—just skills employers actually want.
              </p>
            </Card>

            <Card className="p-6">
              <div className="w-12 h-12 bg-blue-accent/10 rounded-lg flex items-center justify-center mb-4">
                <Zap className="w-6 h-6 text-blue-accent" />
              </div>
              <h3 className="text-xl font-bold text-text-primary mb-3">
                Move Fast, Break Things
              </h3>
              <p className="text-text-secondary">
                Learn the modern AI operator workflow: rapid iteration, quick wins, and
                measurable results. Build real systems, not toy examples.
              </p>
            </Card>

            <Card className="p-6">
              <div className="w-12 h-12 bg-teal-accent/10 rounded-lg flex items-center justify-center mb-4">
                <Users className="w-6 h-6 text-teal-accent" />
              </div>
              <h3 className="text-xl font-bold text-text-primary mb-3">
                Community-Driven
              </h3>
              <p className="text-text-secondary">
                Join thousands of learners building AI systems. Get feedback, share
                projects, and connect with people solving the same challenges.
              </p>
            </Card>
          </div>
        </div>
      </section>

      {/* The Curriculum */}
      <section className="py-16 px-4">
        <div className="container mx-auto max-w-4xl">
          <h2 className="text-3xl font-bold text-text-primary mb-8">
            The Complete Curriculum
          </h2>

          <Card className="p-8">
            <div className="space-y-6">
              <div>
                <h3 className="text-xl font-bold text-purple-primary mb-2">
                  Phase 1: Foundations (Modules 1-3)
                </h3>
                <p className="text-text-secondary">
                  Build a solid understanding of AI systems, LLMs, and content creation.
                  Learn the mindset and tools of successful AI operators.
                </p>
              </div>

              <div>
                <h3 className="text-xl font-bold text-purple-primary mb-2">
                  Phase 2: Tools & Systems (Modules 4-7)
                </h3>
                <p className="text-text-secondary">
                  Master no-code platforms, data layer design, automation workflows,
                  and API integration. Build real business systems.
                </p>
              </div>

              <div>
                <h3 className="text-xl font-bold text-purple-primary mb-2">
                  Phase 3: Advanced AI (Modules 8-10)
                </h3>
                <p className="text-text-secondary">
                  Dive into RAG systems, AI agents, payments, authentication, monitoring,
                  and production-ready deployment.
                </p>
              </div>

              <div>
                <h3 className="text-xl font-bold text-purple-primary mb-2">
                  Phase 4: Professional Skills (Modules 11-15)
                </h3>
                <p className="text-text-secondary">
                  Learn product development, consulting, business skills, security,
                  ethics, and build your professional portfolio.
                </p>
              </div>
            </div>
          </Card>
        </div>
      </section>

      {/* CTA */}
      <section className="py-16 px-4">
        <div className="container mx-auto max-w-4xl text-center">
          <h2 className="text-3xl font-bold text-text-primary mb-4">
            Ready to Start Learning?
          </h2>
          <p className="text-xl text-text-secondary mb-8">
            Jump into Module 1 and begin your journey to becoming an AI operator.
          </p>
          <Link href="/">
            <Button variant="primary" size="lg" icon={<ArrowRight className="w-5 h-5" />}>
              Browse All Modules
            </Button>
          </Link>
        </div>
      </section>
    </div>
  );
}
