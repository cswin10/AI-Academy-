import type { Metadata } from "next";
import "./globals.css";
import { AuthProvider } from "@/contexts/AuthContext";
import { ProgressProvider } from "@/contexts/ProgressContext";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";

export const metadata: Metadata = {
  title: {
    default: "AI Operator Roadmap - From Zero to Professional AI Systems Builder",
    template: "%s | AI Operator Roadmap"
  },
  description: "Master AI operations with 15 comprehensive modules. Learn LLMs, automation, RAG systems, and AI agents. Build real-world AI products from scratch.",
  keywords: ["AI operator", "AI automation", "LLM", "ChatGPT", "Claude", "no-code AI", "AI systems", "machine learning", "prompt engineering", "AI course"],
  authors: [{ name: "AI Operator Roadmap" }],
  creator: "AI Operator Roadmap",
  publisher: "AI Operator Roadmap",
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL || 'http://localhost:3000'),
  openGraph: {
    type: "website",
    locale: "en_US",
    url: "/",
    title: "AI Operator Roadmap - From Zero to Professional AI Systems Builder",
    description: "Master AI operations with 15 comprehensive modules. Learn LLMs, automation, RAG systems, and AI agents.",
    siteName: "AI Operator Roadmap",
  },
  twitter: {
    card: "summary_large_image",
    title: "AI Operator Roadmap - From Zero to Professional AI Systems Builder",
    description: "Master AI operations with 15 comprehensive modules. Learn LLMs, automation, RAG systems, and AI agents.",
    creator: "@aioperator",
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="dark">
      <body className="min-h-screen flex flex-col">
        <AuthProvider>
          <ProgressProvider>
            <Header />
            <main className="flex-1">{children}</main>
            <Footer />
          </ProgressProvider>
        </AuthProvider>
      </body>
    </html>
  );
}
