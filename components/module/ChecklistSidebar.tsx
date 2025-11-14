'use client';

import React from 'react';
import { Card } from '../ui/Card';
import { Checkbox } from '../ui/Checkbox';
import { ChecklistItem } from '@/lib/types';

interface ChecklistSidebarProps {
  checklistItems: ChecklistItem[];
}

export const ChecklistSidebar: React.FC<ChecklistSidebarProps> = ({ checklistItems }) => {
  const handleToggle = (itemId: string) => {
    // Will integrate with ProgressContext/Supabase later
    console.log('Toggle checklist item:', itemId);
  };

  if (checklistItems.length === 0) {
    return null;
  }

  return (
    <Card className="p-6 sticky top-4">
      <h3 className="text-lg font-bold text-text-primary mb-4">
        Learning Objectives
      </h3>
      <div className="space-y-3">
        {checklistItems.map((item) => (
          <div key={item.id} className="flex items-start gap-3">
            <Checkbox
              id={item.id}
              checked={false}
              onChange={() => handleToggle(item.id)}
            />
            <label
              htmlFor={item.id}
              className="text-sm text-text-secondary cursor-pointer flex-1 leading-tight"
            >
              {item.text}
            </label>
          </div>
        ))}
      </div>
    </Card>
  );
};
