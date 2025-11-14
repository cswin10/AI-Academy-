'use client';

import React from 'react';
import { CheckCircle2, Circle, Clock } from 'lucide-react';
import { useProgress } from '@/contexts/ProgressContext';
import { ChecklistItem } from '@/lib/types';
import { Checkbox } from '@/components/ui/Checkbox';
import { ProgressBar } from '@/components/ui/ProgressBar';
import { Button } from '@/components/ui/Button';

interface ProgressWidgetProps {
  moduleId: string;
  checklistItems: ChecklistItem[];
  estimatedTime?: string;
}

export const ProgressWidget: React.FC<ProgressWidgetProps> = ({
  moduleId,
  checklistItems,
  estimatedTime,
}) => {
  const { getModuleProgress, toggleChecklistItem, markModuleAsCompleted } = useProgress();
  const moduleProgress = getModuleProgress(moduleId);

  const completedItems = moduleProgress?.completedChecklistItems || [];
  const completionPercentage = moduleProgress?.completionPercentage || 0;
  const isFullyCompleted = completionPercentage === 100;

  const handleChecklistToggle = (itemId: string) => {
    toggleChecklistItem(moduleId, itemId, checklistItems.length);
  };

  const handleMarkComplete = () => {
    markModuleAsCompleted(moduleId);
  };

  return (
    <div className="sticky top-20 w-80 max-h-[calc(100vh-6rem)] overflow-y-auto">
      <div className="bg-surface border border-gray-800 rounded-xl p-6 space-y-6">
        {/* Header */}
        <div>
          <h3 className="text-lg font-bold text-text-primary mb-2">Module Progress</h3>
          <ProgressBar progress={completionPercentage} showPercentage color="purple" />
        </div>

        {/* Stats */}
        <div className="grid grid-cols-2 gap-4">
          <div className="bg-background rounded-lg p-3">
            <div className="flex items-center gap-2 text-text-secondary mb-1">
              <CheckCircle2 className="w-4 h-4" />
              <span className="text-xs font-medium">Completed</span>
            </div>
            <div className="text-2xl font-bold text-purple-primary">
              {completedItems.length}/{checklistItems.length}
            </div>
          </div>

          {estimatedTime && (
            <div className="bg-background rounded-lg p-3">
              <div className="flex items-center gap-2 text-text-secondary mb-1">
                <Clock className="w-4 h-4" />
                <span className="text-xs font-medium">Time</span>
              </div>
              <div className="text-lg font-bold text-text-primary">{estimatedTime}</div>
            </div>
          )}
        </div>

        {/* Checklist */}
        <div>
          <h4 className="text-sm font-semibold text-text-primary mb-3">Completion Checklist</h4>
          <div className="space-y-2 max-h-96 overflow-y-auto pr-2">
            {checklistItems.map((item) => (
              <Checkbox
                key={item.id}
                id={item.id}
                checked={completedItems.includes(item.id)}
                onChange={() => handleChecklistToggle(item.id)}
                label={item.text}
              />
            ))}
          </div>
        </div>

        {/* Complete Button */}
        {isFullyCompleted && (
          <Button
            variant="primary"
            size="md"
            onClick={handleMarkComplete}
            className="w-full"
            icon={<CheckCircle2 className="w-4 h-4" />}
          >
            Mark Module Complete
          </Button>
        )}

        {!isFullyCompleted && (
          <div className="text-center p-4 bg-gray-800/30 rounded-lg">
            <p className="text-sm text-text-secondary">
              Complete all checklist items to finish this module
            </p>
          </div>
        )}
      </div>
    </div>
  );
};
