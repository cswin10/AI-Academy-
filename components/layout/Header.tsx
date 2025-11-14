'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { Menu, X, Zap, User } from 'lucide-react';
import { useSupabase } from '@/hooks/useSupabase';
import { useModuleProgress } from '@/hooks/useModuleProgress';
import { XPDisplay } from '../gamification/XPDisplay';

interface HeaderProps {
  onMenuToggle?: () => void;
}

export const Header: React.FC<HeaderProps> = ({ onMenuToggle }) => {
  const { user } = useSupabase();
  const { progress } = useModuleProgress();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  const navItems = [
    { label: 'Home', href: '/' },
    { label: 'Modules', href: '/#modules' },
    { label: 'About', href: '/about' },
    { label: 'Resources', href: '/resources' },
  ];

  // Calculate overall progress
  const totalModules = 17;
  const completedModules = progress.filter(p => p.completed_at).length;
  const overallPercentage = Math.round((completedModules / totalModules) * 100);

  const toggleMobileMenu = () => {
    setMobileMenuOpen(!mobileMenuOpen);
    if (onMenuToggle) {
      onMenuToggle();
    }
  };

  return (
    <header className="sticky top-0 z-50 w-full border-b border-gray-800 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
      <div className="container mx-auto px-4">
        <div className="flex h-16 items-center justify-between">
          {/* Logo and Brand */}
          <Link href="/" className="flex items-center gap-2 hover:opacity-80 transition-opacity">
            <div className="w-8 h-8 bg-gradient-to-br from-purple-primary to-purple-dark rounded-lg flex items-center justify-center">
              <Zap className="w-5 h-5 text-white" fill="white" />
            </div>
            <div className="flex flex-col">
              <span className="font-bold text-lg leading-none text-text-primary">
                AI Operator
              </span>
              <span className="text-xs text-text-secondary leading-none">Roadmap</span>
            </div>
          </Link>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center gap-6">
            {navItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                className="text-sm font-medium text-text-secondary hover:text-purple-primary transition-colors"
              >
                {item.label}
              </Link>
            ))}
          </nav>

          {/* User Info & Progress */}
          <div className="hidden md:flex items-center gap-4">
            {user ? (
              <>
                <XPDisplay />
                <Link
                  href="/dashboard"
                  className="flex items-center gap-2 px-4 py-2 bg-purple-primary/10 hover:bg-purple-primary/20 rounded-lg transition-colors"
                >
                  <User className="w-4 h-4 text-purple-primary" />
                  <span className="text-sm font-medium text-purple-primary">Dashboard</span>
                </Link>
              </>
            ) : (
              <div className="flex flex-col items-end">
                <span className="text-xs text-text-secondary">Sign in to track progress</span>
                <span className="text-sm font-bold text-purple-primary">
                  {completedModules}/{totalModules} modules
                </span>
              </div>
            )}
          </div>

          {/* Mobile Menu Button */}
          <button
            onClick={toggleMobileMenu}
            className="md:hidden p-2 text-text-secondary hover:text-text-primary transition-colors"
            aria-label="Toggle menu"
          >
            {mobileMenuOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
          </button>
        </div>

        {/* Mobile Menu */}
        {mobileMenuOpen && (
          <div className="md:hidden py-4 border-t border-gray-800 animate-in slide-in-from-top duration-200">
            <nav className="flex flex-col gap-4">
              {navItems.map((item) => (
                <Link
                  key={item.href}
                  href={item.href}
                  className="text-base font-medium text-text-secondary hover:text-purple-primary transition-colors"
                  onClick={() => setMobileMenuOpen(false)}
                >
                  {item.label}
                </Link>
              ))}
              {user && (
                <Link
                  href="/dashboard"
                  className="text-base font-medium text-purple-primary hover:text-purple-primary/80 transition-colors flex items-center gap-2"
                  onClick={() => setMobileMenuOpen(false)}
                >
                  <User className="w-4 h-4" />
                  Dashboard
                </Link>
              )}
              <div className="pt-4 border-t border-gray-800 flex items-center justify-between">
                <span className="text-sm text-text-secondary">Progress</span>
                <span className="text-lg font-bold text-purple-primary">
                  {completedModules}/{totalModules}
                </span>
              </div>
            </nav>
          </div>
        )}
      </div>
    </header>
  );
};
