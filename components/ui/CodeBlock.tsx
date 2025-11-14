'use client';

import React, { useState } from 'react';
import { Check, Copy } from 'lucide-react';
import { CodeBlockProps } from '@/lib/types';

export const CodeBlock: React.FC<CodeBlockProps> = ({
  code,
  language = 'typescript',
  showLineNumbers = false,
  filename,
}) => {
  const [copied, setCopied] = useState(false);

  const copyToClipboard = async () => {
    try {
      await navigator.clipboard.writeText(code);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch (err) {
      console.error('Failed to copy:', err);
    }
  };

  const lines = code.split('\n');

  return (
    <div className="my-4 rounded-lg overflow-hidden border border-gray-800 bg-surface">
      {/* Header */}
      <div className="flex items-center justify-between px-4 py-2 bg-gray-900/50 border-b border-gray-800">
        <div className="flex items-center gap-2">
          {filename ? (
            <span className="text-xs text-text-secondary font-mono">{filename}</span>
          ) : (
            <span className="text-xs text-text-secondary uppercase font-semibold">{language}</span>
          )}
        </div>
        <button
          onClick={copyToClipboard}
          className="flex items-center gap-1.5 px-2 py-1 text-xs text-text-secondary hover:text-text-primary transition-colors rounded hover:bg-gray-800"
          title="Copy code"
        >
          {copied ? (
            <>
              <Check className="w-3.5 h-3.5" />
              <span>Copied!</span>
            </>
          ) : (
            <>
              <Copy className="w-3.5 h-3.5" />
              <span>Copy</span>
            </>
          )}
        </button>
      </div>

      {/* Code Content */}
      <div className="overflow-x-auto">
        <pre className="p-4 m-0">
          <code className="text-sm font-mono leading-relaxed">
            {showLineNumbers ? (
              <div className="flex">
                {/* Line numbers */}
                <div className="select-none text-text-secondary pr-4 border-r border-gray-800 mr-4">
                  {lines.map((_, i) => (
                    <div key={i} className="text-right">
                      {i + 1}
                    </div>
                  ))}
                </div>
                {/* Code */}
                <div className="flex-1">
                  {lines.map((line, i) => (
                    <div key={i}>{line || '\n'}</div>
                  ))}
                </div>
              </div>
            ) : (
              code
            )}
          </code>
        </pre>
      </div>
    </div>
  );
};
