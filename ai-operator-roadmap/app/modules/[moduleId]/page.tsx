import React from 'react';
import Link from 'next/link';
import { notFound } from 'next/navigation';
import { ChevronLeft, ChevronRight } from 'lucide-react';
import { Button } from '@/components/ui/Button';

// This is a placeholder until we generate all module content
export default function ModulePage({
  params,
}: {
  params: { moduleId: string };
}) {
  return (
    <div className="min-h-screen py-12 px-4">
      <div className="container mx-auto max-w-7xl">
        <div className="text-center py-20">
          <h1 className="text-4xl font-bold text-text-primary mb-4">
            Module: {params.moduleId}
          </h1>
          <p className="text-xl text-text-secondary mb-8">
            Content generation in progress...
          </p>
          <Link href="/">
            <Button variant="primary">
              Back to Home
            </Button>
          </Link>
        </div>
      </div>
    </div>
  );
}
