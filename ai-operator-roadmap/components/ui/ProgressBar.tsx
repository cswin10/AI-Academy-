import React from 'react';
import { ProgressBarProps } from '@/lib/types';

export const ProgressBar: React.FC<ProgressBarProps> = ({
  progress,
  size = 'md',
  showPercentage = false,
  color = 'purple',
}) => {
  const clampedProgress = Math.min(Math.max(progress, 0), 100);

  const heights = {
    sm: 'h-1.5',
    md: 'h-2.5',
    lg: 'h-3',
  };

  const colors = {
    purple: 'bg-purple-primary',
    blue: 'bg-blue-accent',
    teal: 'bg-teal-accent',
    success: 'bg-success',
  };

  return (
    <div className="w-full">
      <div className={`w-full bg-gray-800 rounded-full overflow-hidden ${heights[size]}`}>
        <div
          className={`${colors[color]} ${heights[size]} rounded-full transition-all duration-500 ease-out`}
          style={{ width: `${clampedProgress}%` }}
        >
          {/* Shimmer effect */}
          <div className="h-full w-full bg-gradient-to-r from-transparent via-white/20 to-transparent animate-shimmer" />
        </div>
      </div>
      {showPercentage && (
        <div className="mt-1.5 text-xs text-text-secondary text-right font-medium">
          {Math.round(clampedProgress)}%
        </div>
      )}
    </div>
  );
};
