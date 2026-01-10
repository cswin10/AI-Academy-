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
        background: '#FAFAFA',
        card: {
          DEFAULT: '#FFFFFF',
          hover: '#FAFAFA',
        },
        primary: {
          DEFAULT: '#DB2777',
          hover: '#BE185D',
          light: '#FDF2F8',
          foreground: '#ffffff',
        },
        secondary: {
          DEFAULT: '#D97706',
          hover: '#B45309',
          light: '#FFFBEB',
          foreground: '#ffffff',
        },
        success: '#059669',
        warning: '#D97706',
        danger: '#DC2626',
        text: {
          primary: '#374151',
          secondary: '#6B7280',
          muted: '#9CA3AF',
        },
        border: {
          DEFAULT: '#E5E7EB',
          hover: '#D1D5DB',
        },
        muted: {
          DEFAULT: '#F3F4F6',
          foreground: '#6B7280',
        },
        accent: {
          DEFAULT: '#DB2777',
          foreground: '#ffffff',
        },
        destructive: {
          DEFAULT: '#DC2626',
          foreground: '#ffffff',
        },
        ring: '#DB2777',
        input: '#F3F4F6',
        foreground: '#374151',
        popover: {
          DEFAULT: '#FFFFFF',
          foreground: '#374151',
        },
      },
      fontFamily: {
        sans: ['Plus Jakarta Sans', 'system-ui', 'sans-serif'],
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
