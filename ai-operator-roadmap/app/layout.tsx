import type { Metadata } from "next";
import "./globals.css";
import { ProgressProvider } from "@/contexts/ProgressContext";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";

export const metadata: Metadata = {
  title: "AI Operator Roadmap - From Zero to Professional AI Systems Builder",
  description: "A comprehensive, free educational resource for learning AI systems building from beginner to professional level.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="dark">
      <body className="min-h-screen flex flex-col">
        <ProgressProvider>
          <Header />
          <main className="flex-1">{children}</main>
          <Footer />
        </ProgressProvider>
      </body>
    </html>
  );
}
