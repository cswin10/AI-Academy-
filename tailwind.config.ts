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
        background: '#FFFDF9',
        card: {
          DEFAULT: '#FFFFFF',
          hover: '#FFF9F0',
        },
        primary: {
          DEFAULT: '#E11D48',
          hover: '#BE123C',
          light: '#FDF2F8',
          foreground: '#ffffff',
        },
        secondary: {
          DEFAULT: '#F59E0B',
          hover: '#D97706',
          light: '#FFFBEB',
          foreground: '#ffffff',
        },
        success: '#059669',
        warning: '#F59E0B',
        danger: '#DC2626',
        text: {
          primary: '#1F2937',
          secondary: '#6B7280',
          muted: '#9CA3AF',
        },
        border: {
          DEFAULT: '#F3E8E0',
          hover: '#E5D5C5',
        },
        muted: {
          DEFAULT: '#F9F5F1',
          foreground: '#6B7280',
        },
        accent: {
          DEFAULT: '#E11D48',
          foreground: '#ffffff',
        },
        destructive: {
          DEFAULT: '#DC2626',
          foreground: '#ffffff',
        },
        ring: '#E11D48',
        input: '#F9F5F1',
        foreground: '#1F2937',
        popover: {
          DEFAULT: '#FFFFFF',
          foreground: '#1F2937',
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
