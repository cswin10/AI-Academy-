import React from 'react';
import { DashboardClient } from '@/components/dashboard/DashboardClient';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Dashboard - AI Operator Roadmap',
  description: 'Track your progress, view badges, and see your learning stats',
};

export default function DashboardPage() {
  return <DashboardClient />;
}
