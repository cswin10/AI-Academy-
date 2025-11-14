'use client';

import React from 'react';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import { Callout } from '../ui/Callout';
import { CodeBlock } from '../ui/CodeBlock';

interface MarkdownRendererProps {
  content: string;
}

export const MarkdownRenderer: React.FC<MarkdownRendererProps> = ({ content }) => {
  return (
    <div className="prose prose-invert max-w-none">
      <ReactMarkdown
        remarkPlugins={[remarkGfm]}
        components={{
          h1: ({ node, ...props }) => (
            <h1 className="text-4xl font-bold text-text-primary mt-8 mb-4" {...props} />
          ),
          h2: ({ node, ...props }) => (
            <h2 className="text-3xl font-bold text-text-primary mt-8 mb-4 border-b border-gray-800 pb-2" {...props} />
          ),
          h3: ({ node, ...props }) => (
            <h3 className="text-2xl font-bold text-text-primary mt-6 mb-3" {...props} />
          ),
          h4: ({ node, ...props }) => (
            <h4 className="text-xl font-semibold text-text-primary mt-4 mb-2" {...props} />
          ),
          p: ({ node, ...props }) => (
            <p className="text-text-primary leading-relaxed my-4" {...props} />
          ),
          ul: ({ node, ...props }) => (
            <ul className="list-disc list-inside text-text-primary space-y-2 my-4" {...props} />
          ),
          ol: ({ node, ...props }) => (
            <ol className="list-decimal list-inside text-text-primary space-y-2 my-4" {...props} />
          ),
          li: ({ node, ...props }) => (
            <li className="text-text-primary leading-relaxed" {...props} />
          ),
          a: ({ node, ...props }) => (
            <a
              className="text-purple-primary hover:text-purple-light underline transition-colors"
              {...props}
            />
          ),
          strong: ({ node, ...props }) => (
            <strong className="font-bold text-text-primary" {...props} />
          ),
          em: ({ node, ...props }) => (
            <em className="italic text-text-primary" {...props} />
          ),
          blockquote: ({ node, children, ...props }) => {
            // Check if this is a callout
            const text = String(children);

            if (text.includes('Pro Tip:') || text.includes('💡')) {
              return <Callout type="tip">{children}</Callout>;
            }
            if (text.includes('Common Pitfall:') || text.includes('⚠️')) {
              return <Callout type="warning">{children}</Callout>;
            }
            if (text.includes('Example:') || text.includes('📘')) {
              return <Callout type="example">{children}</Callout>;
            }
            if (text.includes('Success:') || text.includes('✅')) {
              return <Callout type="success">{children}</Callout>;
            }

            return (
              <blockquote className="border-l-4 border-purple-primary pl-4 italic text-text-secondary my-4" {...props}>
                {children}
              </blockquote>
            );
          },
          code: ({ node, inline, className, children, ...props }: any) => {
            const match = /language-(\w+)/.exec(className || '');
            const language = match ? match[1] : 'text';
            const code = String(children).replace(/\n$/, '');

            if (inline) {
              return (
                <code
                  className="bg-surface text-purple-light px-1.5 py-0.5 rounded text-sm font-mono"
                  {...props}
                >
                  {children}
                </code>
              );
            }

            return <CodeBlock code={code} language={language} />;
          },
          pre: ({ node, children, ...props }) => {
            return <>{children}</>;
          },
          table: ({ node, ...props }) => (
            <div className="overflow-x-auto my-4">
              <table className="min-w-full border border-gray-800 rounded-lg" {...props} />
            </div>
          ),
          thead: ({ node, ...props }) => (
            <thead className="bg-gray-900/50" {...props} />
          ),
          tbody: ({ node, ...props }) => (
            <tbody {...props} />
          ),
          tr: ({ node, ...props }) => (
            <tr className="border-b border-gray-800 last:border-0" {...props} />
          ),
          th: ({ node, ...props }) => (
            <th className="px-4 py-3 text-left text-sm font-semibold text-text-primary" {...props} />
          ),
          td: ({ node, ...props }) => (
            <td className="px-4 py-3 text-sm text-text-secondary" {...props} />
          ),
          hr: ({ node, ...props }) => (
            <hr className="border-gray-800 my-8" {...props} />
          ),
        }}
      >
        {content}
      </ReactMarkdown>
    </div>
  );
};
