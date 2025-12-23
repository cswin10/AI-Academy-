import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'AI Operator Academy',
  description: 'Master the fundamentals of AI operations, systems thinking, and the tools that power modern automation.',
  keywords: ['AI', 'automation', 'learning', 'operator', 'systems thinking', 'no-code'],
  authors: [{ name: 'AI Operator Academy' }],
  openGraph: {
    title: 'AI Operator Academy',
    description: 'Master the fundamentals of AI operations, systems thinking, and the tools that power modern automation.',
    type: 'website',
  },
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en" className="dark">
      <body className="font-sans antialiased">
        {children}
      </body>
    </html>
  )
}
