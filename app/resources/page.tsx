import React from 'react';
import { ExternalLink, Book, Code, Video, Workflow, MessageSquare } from 'lucide-react';
import { Card } from '@/components/ui/Card';

export default function ResourcesPage() {
  const resources = [
    {
      category: 'AI Platforms',
      icon: <Workflow className="w-6 h-6" />,
      items: [
        { name: 'OpenAI (GPT-4)', url: 'https://platform.openai.com', description: 'Most capable LLM platform' },
        { name: 'Anthropic (Claude)', url: 'https://www.anthropic.com', description: 'Best for long documents' },
        { name: 'Perplexity', url: 'https://www.perplexity.ai', description: 'AI-powered research' },
        { name: 'Midjourney', url: 'https://www.midjourney.com', description: 'AI image generation' },
        { name: 'ElevenLabs', url: 'https://elevenlabs.io', description: 'AI voice synthesis' },
      ],
    },
    {
      category: 'No-Code Automation',
      icon: <Code className="w-6 h-6" />,
      items: [
        { name: 'Make.com', url: 'https://www.make.com', description: 'Visual automation platform' },
        { name: 'Zapier', url: 'https://zapier.com', description: 'Easy app integrations' },
        { name: 'n8n', url: 'https://n8n.io', description: 'Open-source automation' },
        { name: 'Airtable', url: 'https://www.airtable.com', description: 'Flexible database' },
        { name: 'Notion', url: 'https://www.notion.so', description: 'All-in-one workspace' },
      ],
    },
    {
      category: 'Development Tools',
      icon: <Code className="w-6 h-6" />,
      items: [
        { name: 'Cursor', url: 'https://cursor.sh', description: 'AI-powered IDE' },
        { name: 'Replit', url: 'https://replit.com', description: 'Collaborative coding' },
        { name: 'GitHub Copilot', url: 'https://github.com/features/copilot', description: 'AI pair programmer' },
        { name: 'Supabase', url: 'https://supabase.com', description: 'Open-source Firebase alternative' },
        { name: 'Vercel', url: 'https://vercel.com', description: 'Frontend deployment' },
      ],
    },
    {
      category: 'Learning Resources',
      icon: <Book className="w-6 h-6" />,
      items: [
        { name: 'OpenAI Cookbook', url: 'https://cookbook.openai.com', description: 'Code examples and guides' },
        { name: 'Anthropic Docs', url: 'https://docs.anthropic.com', description: 'Claude documentation' },
        { name: 'Prompt Engineering Guide', url: 'https://www.promptingguide.ai', description: 'Comprehensive prompting resource' },
        { name: 'LangChain Docs', url: 'https://python.langchain.com', description: 'LLM application framework' },
        { name: 'Hugging Face', url: 'https://huggingface.co', description: 'ML model hub' },
      ],
    },
    {
      category: 'Video Tutorials',
      icon: <Video className="w-6 h-6" />,
      items: [
        { name: 'AI Jason', url: 'https://www.youtube.com/@AIJasonZ', description: 'No-code AI automation' },
        { name: 'Matt Wolfe', url: 'https://www.youtube.com/@mreflow', description: 'AI news and tools' },
        { name: 'All About AI', url: 'https://www.youtube.com/@AllAboutAI', description: 'AI use cases' },
        { name: 'Fireship', url: 'https://www.youtube.com/@Fireship', description: 'Quick dev tutorials' },
        { name: 'Web Dev Simplified', url: 'https://www.youtube.com/@WebDevSimplified', description: 'Web development' },
      ],
    },
    {
      category: 'Communities',
      icon: <MessageSquare className="w-6 h-6" />,
      items: [
        { name: 'OpenAI Discord', url: 'https://discord.gg/openai', description: 'Official OpenAI community' },
        { name: 'LangChain Discord', url: 'https://discord.gg/langchain', description: 'LangChain developers' },
        { name: 'r/LocalLLaMA', url: 'https://reddit.com/r/LocalLLaMA', description: 'Open-source LLM community' },
        { name: 'r/ChatGPT', url: 'https://reddit.com/r/ChatGPT', description: 'ChatGPT discussion' },
        { name: 'Indie Hackers', url: 'https://www.indiehackers.com', description: 'Startup builders' },
      ],
    },
  ];

  return (
    <div className="min-h-screen pb-20">
      {/* Hero Section */}
      <section className="py-20 px-4 bg-gradient-to-b from-surface to-background">
        <div className="container mx-auto max-w-4xl text-center">
          <h1 className="text-5xl md:text-6xl font-bold text-text-primary mb-6">
            Resources
          </h1>
          <p className="text-xl text-text-secondary max-w-2xl mx-auto">
            Essential tools, platforms, and communities for AI operators.
            Everything you need to build AI-powered systems.
          </p>
        </div>
      </section>

      {/* Resources Grid */}
      <section className="py-16 px-4">
        <div className="container mx-auto max-w-6xl">
          <div className="space-y-12">
            {resources.map((category) => (
              <div key={category.category}>
                <div className="flex items-center gap-3 mb-6">
                  <div className="w-10 h-10 bg-purple-primary/10 rounded-lg flex items-center justify-center text-purple-primary">
                    {category.icon}
                  </div>
                  <h2 className="text-2xl font-bold text-text-primary">
                    {category.category}
                  </h2>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                  {category.items.map((item) => (
                    <Card key={item.name} hover className="p-5">
                      <a
                        href={item.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="group"
                      >
                        <div className="flex items-start justify-between mb-2">
                          <h3 className="text-lg font-bold text-text-primary group-hover:text-purple-primary transition-colors">
                            {item.name}
                          </h3>
                          <ExternalLink className="w-4 h-4 text-text-secondary group-hover:text-purple-primary transition-colors flex-shrink-0" />
                        </div>
                        <p className="text-sm text-text-secondary">
                          {item.description}
                        </p>
                      </a>
                    </Card>
                  ))}
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Recommended Tools Section */}
      <section className="py-16 px-4 bg-surface/30">
        <div className="container mx-auto max-w-4xl">
          <h2 className="text-3xl font-bold text-text-primary mb-8 text-center">
            Recommended Starting Stack
          </h2>

          <Card className="p-8">
            <div className="space-y-6">
              <div>
                <h3 className="text-lg font-bold text-purple-primary mb-2">
                  For Beginners (Free Tier)
                </h3>
                <ul className="list-disc list-inside text-text-secondary space-y-1">
                  <li>ChatGPT Free or Plus ($20/month)</li>
                  <li>Claude Free or Pro ($20/month)</li>
                  <li>Make.com Free (1,000 operations/month)</li>
                  <li>Airtable Free</li>
                  <li>Cursor Free trial</li>
                </ul>
              </div>

              <div>
                <h3 className="text-lg font-bold text-purple-primary mb-2">
                  For Intermediate (~$100/month)
                </h3>
                <ul className="list-disc list-inside text-text-secondary space-y-1">
                  <li>OpenAI API ($50-100/month usage)</li>
                  <li>Make.com Pro ($9/month)</li>
                  <li>Cursor Pro ($20/month)</li>
                  <li>Supabase Pro ($25/month)</li>
                  <li>ElevenLabs Starter ($5/month)</li>
                </ul>
              </div>

              <div>
                <h3 className="text-lg font-bold text-purple-primary mb-2">
                  For Advanced ($200-500/month)
                </h3>
                <ul className="list-disc list-inside text-text-secondary space-y-1">
                  <li>OpenAI API ($100-300/month)</li>
                  <li>Anthropic API ($50-100/month)</li>
                  <li>Make.com Teams ($29+/month)</li>
                  <li>Midjourney Pro ($60/month)</li>
                  <li>ElevenLabs Pro ($22+/month)</li>
                </ul>
              </div>
            </div>
          </Card>
        </div>
      </section>

      {/* Footer Note */}
      <section className="py-12 px-4">
        <div className="container mx-auto max-w-4xl text-center">
          <p className="text-text-secondary">
            <span className="font-semibold text-text-primary">Note:</span> This roadmap is not
            affiliated with any of these tools or platforms. We recommend them based on
            their quality and usefulness for AI operators.
          </p>
        </div>
      </section>
    </div>
  );
}
