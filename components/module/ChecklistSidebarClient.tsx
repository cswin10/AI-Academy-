'use client';

import React from 'react';
import { CheckCircle2, Circle } from 'lucide-react';
import { Card } from '../ui/Card';
import { useChecklistProgress } from '@/hooks/useChecklistProgress';
import { useSupabase } from '@/hooks/useSupabase';

interface ChecklistItem {
  id: string;
  text: string;
  category?: string;
}

interface ChecklistSidebarClientProps {
  moduleId: string;
  checklistItems: ChecklistItem[];
  showCard?: boolean; // Option to wrap in Card or not
}

// Helper function to strip markdown formatting from text
function stripMarkdown(text: string): string {
  return text
    .replace(/\*\*(.+?)\*\*/g, '$1') // Remove bold
    .replace(/\*(.+?)\*/g, '$1')     // Remove italic
    .replace(/_(.+?)_/g, '$1')        // Remove italic underscore
    .replace(/`(.+?)`/g, '$1')        // Remove inline code
    .trim();
}

export function ChecklistSidebarClient({ moduleId, checklistItems, showCard = true }: ChecklistSidebarClientProps) {
  const { user } = useSupabase();
  const { completed, toggleItem, isCompleted } = useChecklistProgress(moduleId);

  const handleToggle = async (itemId: string) => {
    if (!user) {
      alert('Please sign in to track your progress and earn XP!');
      return;
    }
    await toggleItem(moduleId, itemId);
  };

  // Group items by category if they have one
  const groupedItems = checklistItems.reduce((acc, item) => {
    const category = item.category || 'Learning Objectives';
    if (!acc[category]) {
      acc[category] = [];
    }
    acc[category].push(item);
    return acc;
  }, {} as Record<string, ChecklistItem[]>);

  const completedCount = completed.size;
  const totalCount = checklistItems.length;
  const progressPercentage = totalCount > 0 ? (completedCount / totalCount) * 100 : 0;

  const content = (
    <>
      <div className="flex items-center justify-between mb-4">
        <h3 className="text-lg font-bold text-text-primary">Progress Checklist</h3>
        <span className="text-sm text-text-secondary">
          {completedCount}/{totalCount}
        </span>
      </div>

      {/* Progress bar */}
      <div className="mb-6">
        <div className="h-2 bg-gray-800 rounded-full overflow-hidden">
          <div
            className="h-full bg-gradient-to-r from-purple-600 to-blue-600 transition-all duration-300"
            style={{ width: `${progressPercentage}%` }}
          />
        </div>
      </div>

      {/* Checklist Items */}
      <div className="space-y-6">
        {Object.entries(groupedItems).map(([category, items]) => (
          <div key={category}>
            <h4 className="text-sm font-semibold text-text-secondary mb-3">
              {category}
            </h4>
            <div className="space-y-2">
              {items.map((item) => {
                const itemCompleted = isCompleted(item.id);
                const cleanText = stripMarkdown(item.text);

                return (
                  <button
                    key={item.id}
                    onClick={() => handleToggle(item.id)}
                    type="button"
                    className={`
                      w-full flex items-start gap-3 p-3 rounded-lg text-left
                      transition-all duration-200 border-2
                      ${itemCompleted
                        ? 'bg-success/10 hover:bg-success/20 border-success/30'
                        : 'bg-gray-800/30 hover:bg-gray-800/50 border-gray-700 hover:border-purple-primary/50'
                      }
                      ${!user ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer hover:scale-[1.01]'}
                    `}
                    disabled={!user}
                  >
                    {itemCompleted ? (
                      <CheckCircle2 className="w-5 h-5 text-success flex-shrink-0 mt-0.5" />
                    ) : (
                      <Circle className="w-5 h-5 text-gray-500 flex-shrink-0 mt-0.5" />
                    )}
                    <span
                      className={`text-sm flex-1 ${
                        itemCompleted
                          ? 'text-text-primary line-through opacity-75'
                          : 'text-text-secondary'
                      }`}
                    >
                      {cleanText}
                      {itemCompleted && (
                        <span className="ml-2 text-xs text-success font-semibold">+10 XP ✓</span>
                      )}
                    </span>
                  </button>
                );
              })}
            </div>
          </div>
        ))}
      </div>

      {!user && (
        <div className="mt-6 p-4 bg-purple-500/10 border border-purple-500/20 rounded-lg">
          <p className="text-xs text-text-secondary text-center">
            Sign in to track your progress and earn XP!
          </p>
        </div>
      )}
    </>
  );

  if (showCard) {
    return <Card className="p-6 sticky top-4">{content}</Card>;
  }

  return <div>{content}</div>;
}
