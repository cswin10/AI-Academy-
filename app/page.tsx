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
  Rocket,
  GraduationCap,
} from 'lucide-react'

const features = [
  {
    icon: Target,
    title: 'Systems Thinking',
    description: 'Learn to see businesses as interconnected systems and identify opportunities for improvement.',
    color: 'bg-pink-100 text-pink-600',
  },
  {
    icon: Zap,
    title: 'No-Code Automation',
    description: 'Master tools like Zapier, Make, and n8n to build powerful automations without coding.',
    color: 'bg-amber-100 text-amber-600',
  },
  {
    icon: Brain,
    title: 'AI Integration',
    description: 'Leverage GPT, Claude, and other AI tools to add intelligence to your systems.',
    color: 'bg-purple-100 text-purple-600',
  },
  {
    icon: BookOpen,
    title: 'Practical Projects',
    description: 'Apply what you learn through hands-on exercises and real-world scenarios.',
    color: 'bg-emerald-100 text-emerald-600',
  },
]

const tracks = [
  {
    icon: '🎯',
    name: 'Core Foundation',
    description: 'Master the fundamentals of AI operations, systems thinking, and operator mindset.',
    modules: 8,
    hours: 25,
    required: true,
  },
  {
    icon: '🛠️',
    name: 'Builder Track',
    description: 'Deep dive into no-code automation platforms and workflow design with hands-on projects.',
    modules: 7,
    hours: 30,
    required: false,
  },
  {
    icon: '💼',
    name: 'Business Track',
    description: 'Apply AI operations to real business challenges, from client work to entrepreneurship.',
    modules: 7,
    hours: 28,
    required: false,
  },
  {
    icon: '🎨',
    name: 'Creator Track',
    description: 'Build AI-powered content workflows, from writing to multimedia production.',
    modules: 4,
    hours: 18,
    required: false,
  },
  {
    icon: '🏗️',
    name: 'Infrastructure Track',
    description: 'Set up robust systems, databases, APIs, and deployment infrastructure.',
    modules: 4,
    hours: 25,
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
    <div className="min-h-screen bg-gray-50 relative overflow-hidden">
      {/* Subtle decorative elements */}
      <div className="absolute top-0 right-0 w-[500px] h-[500px] bg-pink-100/30 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3 pointer-events-none" />
      <div className="absolute top-1/3 left-0 w-[400px] h-[400px] bg-amber-100/20 rounded-full blur-3xl -translate-x-1/2 pointer-events-none" />

      {/* Navigation */}
      <nav className="relative border-b border-gray-200 bg-white/80 backdrop-blur-sm sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center gap-3">
              <div className="p-2 rounded-lg bg-pink-600">
                <Sparkles className="h-5 w-5 text-white" />
              </div>
              <span className="text-xl font-semibold text-gray-900">AI Operator Academy</span>
            </div>
            <div className="flex items-center gap-3">
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
      <section className="relative py-16 lg:py-24 px-4">
        <div className="max-w-6xl mx-auto">
          <div className="grid lg:grid-cols-2 gap-12 items-center">
            <div className="text-left">
              <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-pink-50 border border-pink-100 text-pink-700 text-sm mb-6">
                <Rocket className="h-4 w-4" />
                <span className="font-medium">Launch your AI career</span>
              </div>
              <h1 className="text-4xl lg:text-5xl font-bold tracking-tight mb-6 text-gray-900">
                Become an{' '}
                <span className="text-pink-600">AI Operator</span>
              </h1>
              <p className="text-lg text-gray-600 mb-8 leading-relaxed">
                Master systems thinking, no-code automation, and AI integration.
                Build real solutions for real businesses.
              </p>
              <div className="flex flex-col sm:flex-row gap-3">
                <Link href="/signup">
                  <Button size="lg" className="gap-2 w-full sm:w-auto">
                    Start Learning Free
                    <ArrowRight className="h-4 w-4" />
                  </Button>
                </Link>
                <Link href="#tracks">
                  <Button size="lg" variant="outline" className="w-full sm:w-auto">
                    View Curriculum
                  </Button>
                </Link>
              </div>

              {/* Stats */}
              <div className="mt-10 flex items-center gap-8 text-sm">
                <div>
                  <div className="text-2xl font-bold text-gray-900">30+</div>
                  <div className="text-gray-500">Modules</div>
                </div>
                <div className="h-8 w-px bg-gray-200" />
                <div>
                  <div className="text-2xl font-bold text-gray-900">126+</div>
                  <div className="text-gray-500">Hours</div>
                </div>
                <div className="h-8 w-px bg-gray-200" />
                <div>
                  <div className="text-2xl font-bold text-gray-900">5</div>
                  <div className="text-gray-500">Tracks</div>
                </div>
              </div>
            </div>

            {/* Hero visual */}
            <div className="relative hidden lg:block">
              <div className="relative bg-white rounded-2xl shadow-xl border border-gray-100 p-6 overflow-hidden">
                {/* Stats preview */}
                <div className="space-y-5">
                  <div className="flex items-center justify-between pb-4 border-b border-gray-100">
                    <div className="flex items-center gap-3">
                      <div className="p-2 rounded-lg bg-pink-50">
                        <GraduationCap className="h-5 w-5 text-pink-600" />
                      </div>
                      <span className="font-medium text-gray-900">Your Progress</span>
                    </div>
                    <span className="text-sm text-gray-500">Level 5</span>
                  </div>

                  <div className="grid grid-cols-3 gap-3 text-center">
                    <div className="p-3 rounded-xl bg-gray-50 border border-gray-100">
                      <div className="text-xl font-bold text-gray-900">30+</div>
                      <div className="text-xs text-gray-500">Modules</div>
                    </div>
                    <div className="p-3 rounded-xl bg-gray-50 border border-gray-100">
                      <div className="text-xl font-bold text-gray-900">126+</div>
                      <div className="text-xs text-gray-500">Hours</div>
                    </div>
                    <div className="p-3 rounded-xl bg-gray-50 border border-gray-100">
                      <div className="text-xl font-bold text-gray-900">5</div>
                      <div className="text-xs text-gray-500">Tracks</div>
                    </div>
                  </div>

                  <div className="p-4 rounded-xl bg-pink-600 text-white">
                    <div className="flex items-center justify-between mb-2">
                      <span className="text-sm font-medium">Current Module</span>
                      <span className="text-sm opacity-90">62%</span>
                    </div>
                    <div className="h-2 bg-white/30 rounded-full overflow-hidden">
                      <div className="h-full w-[62%] bg-white rounded-full" />
                    </div>
                    <div className="mt-2 text-sm opacity-90">LLM Mastery</div>
                  </div>

                  <div className="flex items-center gap-3 p-3 rounded-xl bg-amber-50 border border-amber-100">
                    <span className="text-xl">🔥</span>
                    <div>
                      <div className="font-medium text-gray-900">7 day streak!</div>
                      <div className="text-xs text-gray-500">Keep it going</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-16 px-4 bg-white">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-12">
            <h2 className="text-2xl font-bold mb-3 text-gray-900">What You&apos;ll Learn</h2>
            <p className="text-gray-600 max-w-2xl mx-auto">
              A comprehensive curriculum designed to take you from beginner to professional AI operator.
            </p>
          </div>
          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-5">
            {features.map((feature) => (
              <Card key={feature.title} className="group hover:-translate-y-1 transition-transform duration-200">
                <CardHeader className="pb-3">
                  <div className={`p-2.5 w-fit rounded-lg ${feature.color} mb-3`}>
                    <feature.icon className="h-5 w-5" />
                  </div>
                  <CardTitle className="text-base text-gray-900">{feature.title}</CardTitle>
                </CardHeader>
                <CardContent>
                  <CardDescription className="text-gray-600 text-sm">{feature.description}</CardDescription>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Tracks Section */}
      <section id="tracks" className="relative py-16 px-4 bg-gray-50">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-12">
            <h2 className="text-2xl font-bold mb-3 text-gray-900">
              Learning Tracks
            </h2>
            <p className="text-gray-600 max-w-2xl mx-auto">
              Structured learning paths to guide your journey from fundamentals to mastery.
            </p>
          </div>

          {/* Core Foundation - Featured */}
          <Card className="mb-6 relative overflow-hidden border-pink-100">
            <div className="absolute top-0 right-0 w-48 h-48 bg-pink-50 rounded-full blur-3xl -translate-y-1/2 translate-x-1/2 pointer-events-none" />
            <CardHeader className="relative">
              <div className="flex items-center gap-4">
                <div className="text-3xl p-3 rounded-xl bg-pink-50 border border-pink-100">
                  🎯
                </div>
                <div>
                  <div className="flex items-center gap-3">
                    <CardTitle className="text-xl text-gray-900">Core Foundation</CardTitle>
                    <span className="px-2.5 py-1 text-xs font-medium bg-pink-600 text-white rounded-full">
                      Required
                    </span>
                  </div>
                  <CardDescription className="mt-1 text-gray-600">
                    Master the fundamentals of AI operations, systems thinking, and operator mindset.
                  </CardDescription>
                </div>
              </div>
            </CardHeader>
            <CardContent className="relative">
              <div className="flex items-center gap-6 text-sm">
                <span className="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-gray-50 border border-gray-100 text-gray-700">
                  <BookOpen className="h-4 w-4 text-gray-500" />
                  <span>8 modules</span>
                </span>
                <span className="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-gray-50 border border-gray-100 text-gray-700">
                  <Zap className="h-4 w-4 text-gray-500" />
                  <span>~25 hours</span>
                </span>
              </div>
            </CardContent>
          </Card>

          {/* Other Tracks Grid */}
          <div className="grid md:grid-cols-2 gap-5">
            {tracks.filter(t => !t.required).map((track) => (
              <Card key={track.name} className="group hover:-translate-y-1 transition-transform duration-200">
                <CardHeader>
                  <div className="flex items-center gap-3">
                    <div className="text-2xl p-2.5 rounded-lg bg-gray-50 border border-gray-100 group-hover:bg-pink-50 group-hover:border-pink-100 transition-colors">
                      {track.icon}
                    </div>
                    <CardTitle className="text-lg text-gray-900">{track.name}</CardTitle>
                  </div>
                </CardHeader>
                <CardContent className="space-y-3">
                  <CardDescription className="text-gray-600">{track.description}</CardDescription>
                  <div className="flex items-center gap-4 text-sm text-gray-500">
                    <span className="flex items-center gap-1.5">
                      <BookOpen className="h-4 w-4" />
                      {track.modules} modules
                    </span>
                    <span className="flex items-center gap-1.5">
                      <Zap className="h-4 w-4" />
                      ~{track.hours} hours
                    </span>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Benefits Section */}
      <section className="py-16 px-4 bg-white">
        <div className="max-w-5xl mx-auto">
          <div className="grid md:grid-cols-2 gap-10 items-center">
            <div>
              <h2 className="text-2xl font-bold mb-4 text-gray-900">Learn by Doing</h2>
              <p className="text-gray-600 mb-6">
                Every lesson includes practical exercises and real-world projects.
                Track your progress, earn achievements, and build skills that matter.
              </p>
              <ul className="space-y-3">
                {benefits.map((benefit) => (
                  <li key={benefit} className="flex items-center gap-3">
                    <CheckCircle className="h-5 w-5 text-emerald-500 flex-shrink-0" />
                    <span className="text-gray-700">{benefit}</span>
                  </li>
                ))}
              </ul>
            </div>
            <div className="bg-gray-50 border border-gray-100 rounded-2xl p-6">
              <div className="flex items-center gap-4 mb-5">
                <div className="p-3 rounded-xl bg-amber-100">
                  <Trophy className="h-7 w-7 text-amber-600" />
                </div>
                <div>
                  <div className="text-2xl font-bold text-gray-900">1,250 XP</div>
                  <div className="text-sm text-gray-500">Level 5 - Expert</div>
                </div>
              </div>
              <div className="space-y-4">
                <div>
                  <div className="flex justify-between text-sm mb-2">
                    <span className="text-gray-600">Progress to Level 6</span>
                    <span className="font-medium text-pink-600">62%</span>
                  </div>
                  <div className="h-2.5 bg-gray-200 rounded-full overflow-hidden">
                    <div className="h-full w-[62%] bg-pink-600 rounded-full" />
                  </div>
                </div>
                <div className="flex items-center gap-3 p-3 rounded-xl bg-amber-50 border border-amber-100">
                  <span className="text-2xl">🔥</span>
                  <div>
                    <span className="font-medium text-gray-900">7 day streak</span>
                    <p className="text-xs text-gray-500">You&apos;re on fire!</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-16 px-4 bg-gray-50">
        <div className="max-w-2xl mx-auto">
          <div className="bg-pink-600 rounded-2xl p-10 text-center">
            <h2 className="text-2xl font-bold mb-3 text-white">Ready to Start?</h2>
            <p className="text-pink-100 mb-6">
              Join thousands of learners building the skills to automate businesses and leverage AI.
            </p>
            <Link href="/signup">
              <Button size="lg" className="gap-2 bg-white text-pink-600 hover:bg-gray-50">
                Create Free Account
                <ArrowRight className="h-4 w-4" />
              </Button>
            </Link>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-gray-200 py-6 px-4 bg-white">
        <div className="max-w-6xl mx-auto flex flex-col md:flex-row justify-between items-center gap-4">
          <div className="flex items-center gap-2">
            <div className="p-1.5 rounded-lg bg-pink-600">
              <Sparkles className="h-4 w-4 text-white" />
            </div>
            <span className="font-medium text-gray-900">AI Operator Academy</span>
          </div>
          <p className="text-sm text-gray-500">
            Built for aspiring AI operators everywhere.
          </p>
        </div>
      </footer>
    </div>
  )
}
