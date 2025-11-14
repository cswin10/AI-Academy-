import React from 'react';
import { CardProps } from '@/lib/types';

export const Card: React.FC<CardProps> = ({
  children,
  className = '',
  hover = false,
  onClick,
}) => {
  const baseStyles = 'bg-surface border border-gray-800 rounded-xl p-6 transition-all duration-200';
  const hoverStyles = hover ? 'hover:border-purple-primary/50 hover:shadow-lg hover:shadow-purple-primary/10 cursor-pointer transform hover:-translate-y-1' : '';
  const clickStyles = onClick ? 'cursor-pointer' : '';

  return (
    <div
      className={`${baseStyles} ${hoverStyles} ${clickStyles} ${className}`}
      onClick={onClick}
    >
      {children}
    </div>
  );
};
