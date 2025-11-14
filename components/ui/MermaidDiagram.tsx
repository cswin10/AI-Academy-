'use client';

import React, { useEffect, useRef } from 'react';
import mermaid from 'mermaid';

interface MermaidDiagramProps {
  chart: string;
}

export const MermaidDiagram: React.FC<MermaidDiagramProps> = ({ chart }) => {
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    mermaid.initialize({
      startOnLoad: true,
      theme: 'dark',
      themeVariables: {
        primaryColor: '#8B5CF6',
        primaryTextColor: '#F9FAFB',
        primaryBorderColor: '#6D28D9',
        lineColor: '#9CA3AF',
        secondaryColor: '#3B82F6',
        tertiaryColor: '#14B8A6',
        background: '#1A1A1A',
        mainBkg: '#1A1A1A',
        secondBkg: '#0F0F0F',
        textColor: '#F9FAFB',
        border1: '#374151',
        border2: '#4B5563',
      },
    });

    if (ref.current) {
      try {
        mermaid.contentLoaded();
      } catch (e) {
        console.error('Mermaid rendering error:', e);
      }
    }
  }, [chart]);

  return (
    <div className="my-8 flex justify-center">
      <div className="mermaid" ref={ref}>
        {chart}
      </div>
    </div>
  );
};
