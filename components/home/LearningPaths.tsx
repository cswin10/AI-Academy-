'use client';

import React, { useState } from 'react';
import { Card } from '../ui/Card';
import { Target, Zap, Briefcase } from 'lucide-react';

export const LearningPaths: React.FC = () => {
  const [selectedPath, setSelectedPath] = useState<string | null>(null);

  const paths = [
    {
      id: 'no-code',
      title: 'No-Code Founder',
      icon: <Target className="w-6 h-6" />,
      description: 'Build AI products without writing code',
      modules: [1, 2, 3, 4, 7, 10, 13, 14, 17],
      duration: '40-60 hours',
      color: 'purple',
    },
    {
      id: 'automation',
      title: 'Automation Expert',
      icon: <Zap className="w-6 h-6" />,
      description: 'Master AI workflow automation',
      modules: [1, 2, 4, 5, 7, 8, 9, 11, 12],
      duration: '55-75 hours',
      color: 'blue',
    },
    {
      id: 'consultant',
      title: 'AI Consultant',
      icon: <Briefcase className="w-6 h-6" />,
      description: 'Advise businesses on AI implementation',
      modules: [1, 2, 3, 13, 14, 15, 16, 17],
      duration: '45-65 hours',
      color: 'teal',
    },
  ];

  return (
    <section className="py-16 px-4 bg-surface/30">
      <div className="container mx-auto max-w-6xl">
        <div className="text-center mb-12">
          <h2 className="text-3xl font-bold text-text-primary mb-4">
            Choose Your Learning Path
          </h2>
          <p className="text-lg text-text-secondary max-w-2xl mx-auto">
            Different paths optimized for different goals. Start with any path, or take all modules sequentially.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {paths.map((path) => (
            <Card
              key={path.id}
              hover
              className={`p-6 cursor-pointer transition-all ${
                selectedPath === path.id ? 'ring-2 ring-' + path.color + '-primary' : ''
              }`}
              onClick={() => setSelectedPath(selectedPath === path.id ? null : path.id)}
            >
              <div
                className={`w-12 h-12 bg-${path.color}-primary/10 rounded-lg flex items-center justify-center text-${path.color}-primary mb-4`}
              >
                {path.icon}
              </div>
              <h3 className="text-xl font-bold text-text-primary mb-2">
                {path.title}
              </h3>
              <p className="text-sm text-text-secondary mb-4">
                {path.description}
              </p>
              <div className="text-xs text-text-secondary space-y-1">
                <div>📚 {path.modules.length} modules</div>
                <div>⏱️ {path.duration}</div>
              </div>
              {selectedPath === path.id && (
                <div className="mt-4 pt-4 border-t border-gray-800">
                  <div className="text-xs text-text-secondary font-semibold mb-2">
                    Recommended modules:
                  </div>
                  <div className="flex flex-wrap gap-1">
                    {path.modules.map((num) => (
                      <span
                        key={num}
                        className={`inline-block px-2 py-1 bg-${path.color}-primary/10 text-${path.color}-primary rounded text-xs font-medium`}
                      >
                        {num}
                      </span>
                    ))}
                  </div>
                </div>
              )}
            </Card>
          ))}
        </div>

        <div className="mt-8 text-center text-sm text-text-secondary">
          <p>
            💡 <span className="font-semibold">Pro tip:</span> All paths overlap significantly.
            The full sequential path (1→17) is also excellent!
          </p>
        </div>
      </div>
    </section>
  );
};
