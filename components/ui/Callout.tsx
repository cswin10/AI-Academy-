import React from 'react';
import { Info, AlertTriangle, Lightbulb, CheckCircle, AlertCircle } from 'lucide-react';
import { CalloutProps } from '@/lib/types';

export const Callout: React.FC<CalloutProps> = ({ type, children, title }) => {
  const config = {
    tip: {
      icon: Lightbulb,
      bgColor: 'bg-purple-primary/10',
      borderColor: 'border-l-purple-primary',
      iconColor: 'text-purple-primary',
      titleColor: 'text-purple-light',
      defaultTitle: 'Pro Tip',
    },
    warning: {
      icon: AlertTriangle,
      bgColor: 'bg-warning/10',
      borderColor: 'border-l-warning',
      iconColor: 'text-warning',
      titleColor: 'text-warning',
      defaultTitle: 'Common Pitfall',
    },
    example: {
      icon: Info,
      bgColor: 'bg-blue-accent/10',
      borderColor: 'border-l-blue-accent',
      iconColor: 'text-blue-accent',
      titleColor: 'text-blue-accent',
      defaultTitle: 'Example',
    },
    success: {
      icon: CheckCircle,
      bgColor: 'bg-success/10',
      borderColor: 'border-l-success',
      iconColor: 'text-success',
      titleColor: 'text-success',
      defaultTitle: 'Success Criteria',
    },
    info: {
      icon: AlertCircle,
      bgColor: 'bg-info/10',
      borderColor: 'border-l-info',
      iconColor: 'text-info',
      titleColor: 'text-info',
      defaultTitle: 'Information',
    },
  };

  const { icon: Icon, bgColor, borderColor, iconColor, titleColor, defaultTitle } = config[type];
  const displayTitle = title || defaultTitle;

  return (
    <div
      className={`
        flex gap-3 p-4 rounded-lg border-l-4 my-4
        ${bgColor} ${borderColor}
        animate-in slide-in-from-left-2 duration-300
      `}
    >
      <Icon className={`w-5 h-5 flex-shrink-0 mt-0.5 ${iconColor}`} />
      <div className="flex-1 space-y-1">
        <div className={`font-semibold text-sm ${titleColor}`}>{displayTitle}</div>
        <div className="text-sm text-text-primary leading-relaxed">{children}</div>
      </div>
    </div>
  );
};
