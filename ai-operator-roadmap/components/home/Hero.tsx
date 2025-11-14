'use client';

import React from 'react';
import Link from 'next/link';
import { ArrowRight, Zap } from 'lucide-react';
import { Button } from '../ui/Button';

export const Hero: React.FC = () => {
  return (
    <section className="relative overflow-hidden bg-gradient-to-br from-background via-purple-primary/5 to-background py-20 px-4">
      {/* Background decoration */}
      <div className="absolute inset-0 overflow-hidden">
        <div className="absolute -top-40 -right-40 w-80 h-80 bg-purple-primary/20 rounded-full blur-3xl" />
        <div className="absolute -bottom-40 -left-40 w-80 h-80 bg-blue-accent/20 rounded-full blur-3xl" />
      </div>

      <div className="relative container mx-auto max-w-5xl text-center">
        {/* Icon */}
        <div className="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-purple-primary to-purple-dark rounded-2xl mb-6 animate-in zoom-in duration-500">
          <Zap className="w-8 h-8 text-white" fill="white" />
        </div>

        {/* Headline */}
        <h1 className="text-5xl md:text-6xl lg:text-7xl font-bold text-text-primary mb-6 animate-in slide-in-from-bottom duration-700">
          From Zero to{' '}
          <span className="bg-gradient-to-r from-purple-primary via-purple-light to-blue-accent bg-clip-text text-transparent">
            AI Operator
          </span>
        </h1>

        {/* Subheadline */}
        <p className="text-xl md:text-2xl text-text-secondary mb-8 max-w-3xl mx-auto animate-in slide-in-from-bottom duration-700 delay-100">
          Master AI systems, automation, and consulting. Build real solutions that generate value.
          <br />
          <span className="text-purple-light font-semibold">100% free. Project-based. Self-paced.</span>
        </p>

        {/* CTA Buttons */}
        <div className="flex flex-col sm:flex-row gap-4 justify-center items-center animate-in slide-in-from-bottom duration-700 delay-200">
          <Link href="#modules">
            <Button variant="primary" size="lg" icon={<ArrowRight className="w-5 h-5" />}>
              Start Learning
            </Button>
          </Link>
          <Link href="/about">
            <Button variant="outline" size="lg">
              Learn More
            </Button>
          </Link>
        </div>

        {/* Stats */}
        <div className="mt-16 grid grid-cols-1 md:grid-cols-3 gap-8 max-w-3xl mx-auto">
          <div className="animate-in fade-in duration-700 delay-300">
            <div className="text-4xl font-bold text-purple-primary mb-2">15</div>
            <div className="text-sm text-text-secondary uppercase tracking-wide">Comprehensive Modules</div>
          </div>
          <div className="animate-in fade-in duration-700 delay-400">
            <div className="text-4xl font-bold text-purple-primary mb-2">8-12</div>
            <div className="text-sm text-text-secondary uppercase tracking-wide">Weeks to Complete</div>
          </div>
          <div className="animate-in fade-in duration-700 delay-500">
            <div className="text-4xl font-bold text-purple-primary mb-2">100%</div>
            <div className="text-sm text-text-secondary uppercase tracking-wide">Free Forever</div>
          </div>
        </div>
      </div>
    </section>
  );
};
