import type { Config } from 'tailwindcss'

const config: Config = {
  darkMode: 'class',
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        background: '#0a0a0f',
        card: {
          DEFAULT: '#141420',
          hover: '#1a1a2e',
        },
        primary: {
          DEFAULT: '#7c3aed',
          hover: '#6d28d9',
          foreground: '#ffffff',
        },
        secondary: {
          DEFAULT: '#3b82f6',
          foreground: '#ffffff',
        },
        success: '#10b981',
        warning: '#f59e0b',
        danger: '#ef4444',
        text: {
          primary: '#f8fafc',
          secondary: '#94a3b8',
          muted: '#64748b',
        },
        border: {
          DEFAULT: '#1e293b',
          hover: '#334155',
        },
        muted: {
          DEFAULT: '#1e293b',
          foreground: '#94a3b8',
        },
        accent: {
          DEFAULT: '#7c3aed',
          foreground: '#ffffff',
        },
        destructive: {
          DEFAULT: '#ef4444',
          foreground: '#ffffff',
        },
        ring: '#7c3aed',
        input: '#1e293b',
        foreground: '#f8fafc',
        popover: {
          DEFAULT: '#141420',
          foreground: '#f8fafc',
        },
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['ui-monospace', 'SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', 'monospace'],
      },
      borderRadius: {
        lg: '0.5rem',
        md: '0.375rem',
        sm: '0.25rem',
      },
      keyframes: {
        'accordion-down': {
          from: { height: '0' },
          to: { height: 'var(--radix-accordion-content-height)' },
        },
        'accordion-up': {
          from: { height: 'var(--radix-accordion-content-height)' },
          to: { height: '0' },
        },
        'pulse-xp': {
          '0%, 100%': { transform: 'scale(1)' },
          '50%': { transform: 'scale(1.1)' },
        },
        'slide-in': {
          from: { transform: 'translateY(10px)', opacity: '0' },
          to: { transform: 'translateY(0)', opacity: '1' },
        },
        'count-up': {
          from: { opacity: '0', transform: 'translateY(10px)' },
          to: { opacity: '1', transform: 'translateY(0)' },
        },
      },
      animation: {
        'accordion-down': 'accordion-down 0.2s ease-out',
        'accordion-up': 'accordion-up 0.2s ease-out',
        'pulse-xp': 'pulse-xp 0.5s ease-in-out',
        'slide-in': 'slide-in 0.3s ease-out',
        'count-up': 'count-up 0.5s ease-out',
      },
    },
  },
  plugins: [],
}

export default config
