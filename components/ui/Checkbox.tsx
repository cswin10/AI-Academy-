'use client';

import React from 'react';
import { Check } from 'lucide-react';
import { CheckboxProps } from '@/lib/types';

export const Checkbox: React.FC<CheckboxProps> = ({
  id,
  checked,
  onChange,
  label,
  disabled = false,
}) => {
  return (
    <div className="flex items-start gap-3 group">
      <button
        type="button"
        role="checkbox"
        aria-checked={checked}
        disabled={disabled}
        onClick={() => onChange(!checked)}
        className={`
          mt-0.5 flex-shrink-0 w-5 h-5 rounded border-2 transition-all duration-200
          flex items-center justify-center focus:outline-none focus:ring-2 focus:ring-purple-primary focus:ring-offset-2 focus:ring-offset-background
          ${checked
            ? 'bg-purple-primary border-purple-primary'
            : 'border-gray-600 hover:border-purple-primary/50'
          }
          ${disabled ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer'}
        `}
      >
        {checked && (
          <Check className="w-3.5 h-3.5 text-white animate-in zoom-in duration-200" strokeWidth={3} />
        )}
      </button>
      {label && (
        <label
          htmlFor={id}
          className={`
            text-sm leading-relaxed cursor-pointer select-none
            ${checked ? 'text-text-secondary line-through' : 'text-text-primary'}
            ${disabled ? 'opacity-50 cursor-not-allowed' : 'group-hover:text-purple-light'}
            transition-colors duration-200
          `}
          onClick={() => !disabled && onChange(!checked)}
        >
          {label}
        </label>
      )}
    </div>
  );
};
