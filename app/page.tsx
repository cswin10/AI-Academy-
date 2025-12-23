import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import {
  Sparkles,
  Target,
  Zap,
  Brain,
  BookOpen,
  Trophy,
  ArrowRight,
  CheckCircle,
} from 'lucide-react'

const features = [
  {
    icon: Target,
    title: 'Systems Thinking',
    description: 'Learn to see businesses as interconnected systems and identify opportunities for improvement.',
  },
  {
    icon: Zap,
    title: 'No-Code Automation',
    description: 'Master tools like Zapier, Make, and n8n to build powerful automations without coding.',
  },
  {
    icon: Brain,
    title: 'AI Integration',
    description: 'Leverage GPT, Claude, and other AI tools to add intelligence to your systems.',
  },
  {
    icon: BookOpen,
    title: 'Practical Projects',
    description: 'Apply what you learn through hands-on exercises and real-world scenarios.',
  },
]

const tracks = [
  {
    icon: '🎯',
    name: 'Core Foundation',
    description: 'Master the fundamentals of AI operations and systems thinking.',
    modules: 6,
    hours: 25,
    required: true,
  },
  {
    icon: '⚙️',
    name: 'Automation Mastery',
    description: 'Deep dive into no-code automation platforms and workflow design.',
    modules: 5,
    hours: 20,
    required: false,
  },
  {
    icon: '🤖',
    name: 'AI & LLMs',
    description: 'Learn to integrate and leverage AI models in your systems.',
    modules: 6,
    hours: 24,
    required: false,
  },
  {
    icon: '📊',
    name: 'Data & Analytics',
    description: 'Build dashboards, reports, and data-driven decision systems.',
    modules: 4,
    hours: 16,
    required: false,
  },
]

const benefits = [
  'Learn at your own pace with bite-sized lessons',
  'Track your progress with XP and achievements',
  'Practice with real-world exercises',
  'Build a portfolio of automation projects',
  'Join a community of AI operators',
]

export default function LandingPage() {
  return (
    <div className="min-h-screen bg-background">
      {/* Navigation */}
      <nav className="border-b border-border">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center gap-2">
              <Sparkles className="h-6 w-6 text-primary" />
              <span className="text-xl font-bold">AI Operator Academy</span>
            </div>
            <div className="flex items-center gap-4">
              <Link href="/login">
                <Button variant="ghost">Sign in</Button>
              </Link>
              <Link href="/signup">
                <Button>Get Started</Button>
              </Link>
            </div>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="py-20 px-4">
        <div className="max-w-4xl mx-auto text-center">
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-primary/10 text-primary text-sm mb-8">
            <Sparkles className="h-4 w-4" />
            <span>The complete AI operator curriculum</span>
          </div>
          <h1 className="text-5xl md:text-6xl font-bold tracking-tight mb-6">
            Become an{' '}
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-primary to-secondary">
              AI Operator
            </span>
          </h1>
          <p className="text-xl text-muted-foreground mb-10 max-w-2xl mx-auto">
            Master systems thinking, no-code automation, and AI integration.
            Build real solutions for real businesses.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link href="/signup">
              <Button size="xl" className="gap-2">
                Start Learning Free
                <ArrowRight className="h-4 w-4" />
              </Button>
            </Link>
            <Link href="#tracks">
              <Button size="xl" variant="outline">
                View Curriculum
              </Button>
            </Link>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-20 px-4 bg-card/50">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-3xl font-bold mb-4">What You&apos;ll Learn</h2>
            <p className="text-muted-foreground max-w-2xl mx-auto">
              A comprehensive curriculum designed to take you from beginner to professional AI operator.
            </p>
          </div>
          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
            {features.map((feature) => (
              <Card key={feature.title} className="border-border bg-card card-hover">
                <CardHeader>
                  <div className="p-2 w-fit rounded-lg bg-primary/10 mb-2">
                    <feature.icon className="h-6 w-6 text-primary" />
                  </div>
                  <CardTitle className="text-lg">{feature.title}</CardTitle>
                </CardHeader>
                <CardContent>
                  <CardDescription>{feature.description}</CardDescription>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Tracks Section */}
      <section id="tracks" className="py-20 px-4">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-3xl font-bold mb-4">Learning Tracks</h2>
            <p className="text-muted-foreground max-w-2xl mx-auto">
              Structured learning paths to guide your journey from fundamentals to mastery.
            </p>
          </div>
          <div className="grid md:grid-cols-2 gap-6">
            {tracks.map((track) => (
              <Card key={track.name} className="border-border bg-card card-hover">
                <CardHeader>
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <span className="text-3xl">{track.icon}</span>
                      <div>
                        <CardTitle className="text-xl">{track.name}</CardTitle>
                        {track.required && (
                          <span className="text-xs text-primary">Required</span>
                        )}
                      </div>
                    </div>
                  </div>
                </CardHeader>
                <CardContent className="space-y-4">
                  <CardDescription>{track.description}</CardDescription>
                  <div className="flex items-center gap-6 text-sm text-muted-foreground">
                    <span className="flex items-center gap-1">
                      <BookOpen className="h-4 w-4" />
                      {track.modules} modules
                    </span>
                    <span className="flex items-center gap-1">
                      <Zap className="h-4 w-4" />
                      {track.hours} hours
                    </span>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Benefits Section */}
      <section className="py-20 px-4 bg-card/50">
        <div className="max-w-4xl mx-auto">
          <div className="grid md:grid-cols-2 gap-12 items-center">
            <div>
              <h2 className="text-3xl font-bold mb-6">Learn by Doing</h2>
              <p className="text-muted-foreground mb-8">
                Every lesson includes practical exercises and real-world projects.
                Track your progress, earn achievements, and build skills that matter.
              </p>
              <ul className="space-y-3">
                {benefits.map((benefit) => (
                  <li key={benefit} className="flex items-center gap-3">
                    <CheckCircle className="h-5 w-5 text-success flex-shrink-0" />
                    <span>{benefit}</span>
                  </li>
                ))}
              </ul>
            </div>
            <div className="bg-card border border-border rounded-lg p-6">
              <div className="flex items-center gap-4 mb-6">
                <div className="p-3 rounded-full bg-primary/10">
                  <Trophy className="h-8 w-8 text-primary" />
                </div>
                <div>
                  <div className="text-2xl font-bold">1,250 XP</div>
                  <div className="text-sm text-muted-foreground">Level 5 - Expert</div>
                </div>
              </div>
              <div className="space-y-4">
                <div>
                  <div className="flex justify-between text-sm mb-1">
                    <span>Progress to Level 6</span>
                    <span className="text-primary">62%</span>
                  </div>
                  <div className="h-2 bg-muted rounded-full overflow-hidden">
                    <div className="h-full w-[62%] bg-primary rounded-full" />
                  </div>
                </div>
                <div className="flex items-center gap-2 text-sm">
                  <span className="text-2xl">🔥</span>
                  <span className="font-medium">7 day streak</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 px-4">
        <div className="max-w-3xl mx-auto text-center">
          <h2 className="text-3xl font-bold mb-4">Ready to Start?</h2>
          <p className="text-muted-foreground mb-8">
            Join thousands of learners building the skills to automate businesses and leverage AI.
          </p>
          <Link href="/signup">
            <Button size="xl" className="gap-2">
              Create Free Account
              <ArrowRight className="h-4 w-4" />
            </Button>
          </Link>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-border py-8 px-4">
        <div className="max-w-6xl mx-auto flex flex-col md:flex-row justify-between items-center gap-4">
          <div className="flex items-center gap-2">
            <Sparkles className="h-5 w-5 text-primary" />
            <span className="font-semibold">AI Operator Academy</span>
          </div>
          <p className="text-sm text-muted-foreground">
            Built for aspiring AI operators everywhere.
          </p>
        </div>
      </footer>
    </div>
  )
}
