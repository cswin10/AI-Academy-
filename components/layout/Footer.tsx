import React from 'react';
import Link from 'next/link';
import { Github, Twitter, Linkedin, Heart } from 'lucide-react';

export const Footer: React.FC = () => {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="border-t border-gray-800 bg-surface/30 mt-auto">
      <div className="container mx-auto px-4 py-8">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {/* Brand Section */}
          <div>
            <h3 className="text-lg font-bold text-text-primary mb-2">AI Operator Roadmap</h3>
            <p className="text-sm text-text-secondary leading-relaxed">
              A comprehensive, free educational resource for learning AI systems building from beginner to professional level.
            </p>
          </div>

          {/* Quick Links */}
          <div>
            <h4 className="text-sm font-semibold text-text-primary uppercase tracking-wider mb-3">
              Quick Links
            </h4>
            <ul className="space-y-2">
              <li>
                <Link href="/" className="text-sm text-text-secondary hover:text-purple-primary transition-colors">
                  Home
                </Link>
              </li>
              <li>
                <Link href="/#modules" className="text-sm text-text-secondary hover:text-purple-primary transition-colors">
                  Modules
                </Link>
              </li>
              <li>
                <Link href="/about" className="text-sm text-text-secondary hover:text-purple-primary transition-colors">
                  About
                </Link>
              </li>
              <li>
                <Link href="/resources" className="text-sm text-text-secondary hover:text-purple-primary transition-colors">
                  Resources
                </Link>
              </li>
            </ul>
          </div>

          {/* Community */}
          <div>
            <h4 className="text-sm font-semibold text-text-primary uppercase tracking-wider mb-3">
              Community
            </h4>
            <div className="flex gap-3">
              <a
                href="https://github.com"
                target="_blank"
                rel="noopener noreferrer"
                className="w-10 h-10 rounded-lg bg-gray-800 flex items-center justify-center text-text-secondary hover:text-purple-primary hover:bg-gray-700 transition-all"
                aria-label="GitHub"
              >
                <Github className="w-5 h-5" />
              </a>
              <a
                href="https://twitter.com"
                target="_blank"
                rel="noopener noreferrer"
                className="w-10 h-10 rounded-lg bg-gray-800 flex items-center justify-center text-text-secondary hover:text-purple-primary hover:bg-gray-700 transition-all"
                aria-label="Twitter"
              >
                <Twitter className="w-5 h-5" />
              </a>
              <a
                href="https://linkedin.com"
                target="_blank"
                rel="noopener noreferrer"
                className="w-10 h-10 rounded-lg bg-gray-800 flex items-center justify-center text-text-secondary hover:text-purple-primary hover:bg-gray-700 transition-all"
                aria-label="LinkedIn"
              >
                <Linkedin className="w-5 h-5" />
              </a>
            </div>
          </div>
        </div>

        {/* Bottom Bar */}
        <div className="mt-8 pt-6 border-t border-gray-800 flex flex-col md:flex-row justify-between items-center gap-4">
          <p className="text-sm text-text-secondary">
            © {currentYear} AI Operator Roadmap. All rights reserved.
          </p>
          <p className="text-sm text-text-secondary flex items-center gap-1">
            Made with <Heart className="w-4 h-4 text-red-500 fill-red-500" /> by the community
          </p>
        </div>
      </div>
    </footer>
  );
};
