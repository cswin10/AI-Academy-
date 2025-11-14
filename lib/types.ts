// Module and Content Types
export interface ModuleMetadata {
  id: string;
  number: number;
  title: string;
  description: string;
  estimatedTime: string;
  difficulty: 'Beginner' | 'Intermediate' | 'Advanced';
  prerequisites: string[];
  category: 'Foundation' | 'Interface & Data' | 'Automation & Intelligence' | 'Business & Production';
}

export interface ModuleContent {
  metadata: ModuleMetadata;
  content: string;
  sections: Section[];
  checklistItems: ChecklistItem[];
}

export interface Section {
  id: string;
  title: string;
  level: number;
  slug: string;
}

export interface ChecklistItem {
  id: string;
  text: string;
  moduleId: string;
  sectionId?: string;
}

// Progress Tracking Types
export interface ModuleProgress {
  moduleId: string;
  completedSections: string[];
  completedChecklistItems: string[];
  completionPercentage: number;
  lastAccessed: Date;
  startedAt?: Date;
  completedAt?: Date;
}

export interface UserProgress {
  modules: ModuleProgress[];
  overallPercentage: number;
  totalChecklistItems: number;
  completedChecklistItems: number;
  startDate: Date;
  lastActivityDate: Date;
}

// Component Props Types
export interface CalloutProps {
  type: 'tip' | 'warning' | 'example' | 'success' | 'info';
  children: React.ReactNode;
  title?: string;
}

export interface CodeBlockProps {
  code: string;
  language?: string;
  showLineNumbers?: boolean;
  filename?: string;
}

export interface CheckboxProps {
  id: string;
  checked: boolean;
  onChange: (checked: boolean) => void;
  label?: string;
  disabled?: boolean;
}

export interface ProgressBarProps {
  progress: number;
  size?: 'sm' | 'md' | 'lg';
  showPercentage?: boolean;
  color?: 'purple' | 'blue' | 'teal' | 'success';
}

export interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
  isLoading?: boolean;
  icon?: React.ReactNode;
}

export interface CardProps {
  children: React.ReactNode;
  className?: string;
  hover?: boolean;
  onClick?: () => void;
}

// Navigation Types
export interface NavItem {
  label: string;
  href: string;
  icon?: React.ReactNode;
  active?: boolean;
}

export interface BreadcrumbItem {
  label: string;
  href?: string;
}

// Module Card Types (for Home page)
export interface ModuleCardData {
  metadata: ModuleMetadata;
  progress: number;
  isStarted: boolean;
  isCompleted: boolean;
}

// Table of Contents Types
export interface TOCItem {
  id: string;
  title: string;
  level: number;
  children?: TOCItem[];
}

// FAQ Types
export interface FAQItem {
  question: string;
  answer: string;
}
