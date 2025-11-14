/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        // Dizzy Otter Brand Colors
        'purple-primary': '#8B5CF6',
        'purple-dark': '#6D28D9',
        'purple-light': '#A78BFA',
        'blue-accent': '#3B82F6',
        'teal-accent': '#14B8A6',

        // Dark theme
        background: '#0F0F0F',
        surface: '#1A1A1A',
        'text-primary': '#F9FAFB',
        'text-secondary': '#9CA3AF',

        // Functional
        success: '#10B981',
        warning: '#F59E0B',
        info: '#3B82F6',
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['Fira Code', 'monospace'],
      },
    },
  },
  plugins: [],
}
