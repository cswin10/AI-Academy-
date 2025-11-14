'use client';

import React from 'react';
import Link from 'next/link';
import { Clock, CheckCircle2, Circle, ArrowRight } from 'lucide-react';
import { Card } from '../ui/Card';
import { ProgressBar } from '../ui/ProgressBar';
import { Button } from '../ui/Button';
import { ModuleCardData } from '@/lib/types';

interface ModuleCardProps {
  module: ModuleCardData;
}

export const ModuleCard: React.FC<ModuleCardProps> = ({ module }) => {
  const { metadata, progress, isStarted, isCompleted } = module;

  return (
    <Card hover className="h-full flex flex-col">
      {/* Header */}
      <div className="flex items-start justify-between mb-4">
        <div className="flex-1">
          <div className="flex items-center gap-2 mb-2">
            <span className="text-xs font-bold text-purple-primary bg-purple-primary/10 px-2 py-1 rounded">
              MODULE {String(metadata.number).padStart(2, '0')}
            </span>
            <span className={`
              text-xs font-semibold px-2 py-1 rounded
              ${metadata.difficulty === 'Beginner' ? 'bg-success/10 text-success' : ''}
              ${metadata.difficulty === 'Intermediate' ? 'bg-warning/10 text-warning' : ''}
              ${metadata.difficulty === 'Advanced' ? 'bg-info/10 text-info' : ''}
            `}>
              {metadata.difficulty}
            </span>
          </div>
          <h3 className="text-xl font-bold text-text-primary mb-2">{metadata.title}</h3>
        </div>

        {isCompleted ? (
          <CheckCircle2 className="w-6 h-6 text-success flex-shrink-0" />
        ) : isStarted ? (
          <Circle className="w-6 h-6 text-warning flex-shrink-0" />
        ) : (
          <Circle className="w-6 h-6 text-gray-600 flex-shrink-0" />
        )}
      </div>

      {/* Description */}
      <p className="text-sm text-text-secondary leading-relaxed mb-4 flex-1">
        {metadata.description}
      </p>

      {/* Meta Info */}
      <div className="flex items-center gap-4 text-xs text-text-secondary mb-4">
        <div className="flex items-center gap-1">
          <Clock className="w-3.5 h-3.5" />
          <span>{metadata.estimatedTime}</span>
        </div>
        <div className="flex items-center gap-1">
          <span className="font-semibold">{metadata.category}</span>
        </div>
      </div>

      {/* Progress */}
      {isStarted && (
        <div className="mb-4">
          <ProgressBar progress={progress} showPercentage color="purple" size="sm" />
        </div>
      )}

      {/* CTA */}
      <Link href={`/modules/${metadata.id}`} className="w-full">
        <Button
          variant={isCompleted ? 'secondary' : isStarted ? 'primary' : 'outline'}
          size="md"
          className="w-full"
          icon={<ArrowRight className="w-4 h-4" />}
        >
          {isCompleted ? 'Review' : isStarted ? 'Continue' : 'Start'}
        </Button>
      </Link>
    </Card>
  );
};
