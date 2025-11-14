'use client';

import React, { useState } from 'react';
import { ChevronDown, ChevronUp, CheckCircle2 } from 'lucide-react';
import { Card } from '../ui/Card';
import { MarkdownRenderer } from './MarkdownRenderer';

interface SectionCardProps {
  title: string;
  content: string;
  sectionNumber: number;
  isCompleted?: boolean;
  defaultExpanded?: boolean;
}

export function SectionCard({
  title,
  content,
  sectionNumber,
  isCompleted = false,
  defaultExpanded = true,
}: SectionCardProps) {
  const [isExpanded, setIsExpanded] = useState(defaultExpanded);

  return (
    <Card className="mb-6 overflow-hidden">
      {/* Section Header */}
      <button
        onClick={() => setIsExpanded(!isExpanded)}
        className="w-full px-6 py-4 flex items-center justify-between bg-surface/50 hover:bg-surface/80 transition-colors"
      >
        <div className="flex items-center gap-4">
          <div className="flex items-center justify-center w-10 h-10 rounded-lg bg-purple-primary/10 text-purple-primary font-bold">
            {sectionNumber}
          </div>
          <div className="text-left">
            <h2 className="text-xl font-bold text-text-primary">{title}</h2>
          </div>
        </div>
        <div className="flex items-center gap-3">
          {isCompleted && (
            <CheckCircle2 className="w-5 h-5 text-success" />
          )}
          {isExpanded ? (
            <ChevronUp className="w-5 h-5 text-text-secondary" />
          ) : (
            <ChevronDown className="w-5 h-5 text-text-secondary" />
          )}
        </div>
      </button>

      {/* Section Content */}
      {isExpanded && (
        <div className="px-6 py-6">
          <MarkdownRenderer content={content} />
        </div>
      )}
    </Card>
  );
}
