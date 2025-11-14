'use client';

import React, { useState } from 'react';
import { CheckCircle2, Circle, Clipboard } from 'lucide-react';
import { Card } from '../ui/Card';
import { Button } from '../ui/Button';
import { useSupabase } from '@/hooks/useSupabase';
import { useChecklistProgress } from '@/hooks/useChecklistProgress';

interface TaskCardProps {
  taskId: string;
  moduleId: string;
  title: string;
  description: string;
  xpReward?: number;
}

export function TaskCard({
  taskId,
  moduleId,
  title,
  description,
  xpReward = 10,
}: TaskCardProps) {
  const { user } = useSupabase();
  const { isCompleted, toggleItem } = useChecklistProgress(moduleId);
  const completed = isCompleted(taskId);
  const [justCompleted, setJustCompleted] = useState(false);

  const handleComplete = async () => {
    if (!user) {
      alert('Please sign in to track your progress and earn XP!');
      return;
    }

    await toggleItem(moduleId, taskId);

    if (!completed) {
      setJustCompleted(true);
      setTimeout(() => setJustCompleted(false), 3000);
    }
  };

  return (
    <Card className={`mb-6 p-6 border-2 transition-all ${
      completed
        ? 'border-success/30 bg-success/5'
        : 'border-purple-primary/20 bg-purple-primary/5'
    }`}>
      <div className="flex items-start gap-4">
        <div className="flex-shrink-0 mt-1">
          <Clipboard className={`w-6 h-6 ${completed ? 'text-success' : 'text-purple-primary'}`} />
        </div>

        <div className="flex-1">
          <h3 className="text-lg font-bold text-text-primary mb-2">
            {title}
          </h3>
          <p className="text-sm text-text-secondary mb-4">
            {description}
          </p>

          <div className="flex items-center justify-between">
            <Button
              onClick={handleComplete}
              variant={completed ? 'secondary' : 'primary'}
              icon={completed ? <CheckCircle2 className="w-4 h-4" /> : <Circle className="w-4 h-4" />}
              className="min-w-[180px]"
            >
              {completed ? 'Completed' : 'Mark as Complete'}
            </Button>

            <div className="flex items-center gap-2">
              {justCompleted && (
                <span className="text-sm font-semibold text-success animate-pulse">
                  +{xpReward} XP earned! 🎉
                </span>
              )}
              {completed && !justCompleted && (
                <span className="text-xs text-success">
                  ✓ +{xpReward} XP
                </span>
              )}
              {!completed && (
                <span className="text-xs text-text-secondary">
                  {xpReward} XP
                </span>
              )}
            </div>
          </div>
        </div>
      </div>
    </Card>
  );
}
