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
  Play,
  Star,
  Rocket,
  Users,
  GraduationCap,
} from 'lucide-react'

const features = [
  {
    icon: Target,
    title: 'Systems Thinking',
    description: 'Learn to see businesses as interconnected systems and identify opportunities for improvement.',
    color: 'from-rose-500 to-pink-500',
  },
  {
    icon: Zap,
    title: 'No-Code Automation',
    description: 'Master tools like Zapier, Make, and n8n to build powerful automations without coding.',
    color: 'from-amber-500 to-yellow-500',
  },
  {
    icon: Brain,
    title: 'AI Integration',
    description: 'Leverage GPT, Claude, and other AI tools to add intelligence to your systems.',
    color: 'from-rose-500 to-orange-500',
  },
  {
    icon: BookOpen,
    title: 'Practical Projects',
    description: 'Apply what you learn through hands-on exercises and real-world scenarios.',
    color: 'from-pink-500 to-rose-500',
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
    <div className="min-h-screen bg-background relative overflow-hidden">
      {/* Decorative blobs */}
      <div className="absolute top-0 right-0 w-[600px] h-[600px] bg-gradient-to-br from-rose-200/40 to-pink-200/30 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3 pointer-events-none" />
      <div className="absolute top-1/3 left-0 w-[500px] h-[500px] bg-gradient-to-br from-amber-200/30 to-yellow-200/20 rounded-full blur-3xl -translate-x-1/2 pointer-events-none" />
      <div className="absolute bottom-0 right-1/4 w-[400px] h-[400px] bg-gradient-to-br from-pink-200/30 to-rose-200/20 rounded-full blur-3xl translate-y-1/2 pointer-events-none" />

      {/* Navigation */}
      <nav className="relative border-b border-rose-100/50 backdrop-blur-lg bg-white/70 sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center gap-3">
              <div className="p-2 rounded-xl bg-gradient-to-br from-rose-500 to-amber-500 shadow-lg shadow-rose-500/25">
                <Sparkles className="h-5 w-5 text-white" />
              </div>
              <span className="text-xl font-bold text-gray-900">AI Operator Academy</span>
            </div>
            <div className="flex items-center gap-4">
              <Link href="/login">
                <Button variant="ghost" className="text-gray-700 hover:text-gray-900">Sign in</Button>
              </Link>
              <Link href="/signup">
                <Button className="bg-gradient-to-r from-rose-500 to-pink-500 hover:from-rose-600 hover:to-pink-600 text-white shadow-lg shadow-rose-500/25">
                  Get Started
                </Button>
              </Link>
            </div>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="relative py-20 lg:py-32 px-4">
        <div className="max-w-6xl mx-auto">
          <div className="grid lg:grid-cols-2 gap-12 items-center">
            <div className="text-left">
              <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-gradient-to-r from-rose-50 to-amber-50 border border-rose-200/50 text-rose-600 text-sm mb-6">
                <Rocket className="h-4 w-4" />
                <span className="font-medium">Launch your AI career</span>
              </div>
              <h1 className="text-5xl lg:text-6xl font-extrabold tracking-tight mb-6 text-gray-900">
                Become an{' '}
                <span className="gradient-text">
                  AI Operator
                </span>
              </h1>
              <p className="text-xl text-gray-600 mb-8 leading-relaxed">
                Master systems thinking, no-code automation, and AI integration.
                Build real solutions for real businesses.
              </p>
              <div className="flex flex-col sm:flex-row gap-4">
                <Link href="/signup">
                  <Button size="xl" className="gap-2 group bg-gradient-to-r from-rose-500 to-pink-500 hover:from-rose-600 hover:to-pink-600 text-white shadow-xl shadow-rose-500/25 w-full sm:w-auto">
                    Start Learning Free
                    <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" />
                  </Button>
                </Link>
                <Link href="#tracks">
                  <Button size="xl" variant="outline" className="border-2 border-gray-200 hover:border-rose-200 hover:bg-rose-50/50 w-full sm:w-auto">
                    View Curriculum
                  </Button>
                </Link>
              </div>

              {/* Social proof */}
              <div className="mt-10 flex items-center gap-6">
                <div className="flex -space-x-2">
                  {[1, 2, 3, 4, 5].map((i) => (
                    <div
                      key={i}
                      className="w-10 h-10 rounded-full bg-gradient-to-br from-rose-400 to-amber-400 border-2 border-white flex items-center justify-center text-white text-xs font-bold"
                    >
                      {String.fromCharCode(64 + i)}
                    </div>
                  ))}
                </div>
                <div>
                  <div className="flex items-center gap-1 text-amber-500">
                    {[1, 2, 3, 4, 5].map((i) => (
                      <Star key={i} className="h-4 w-4 fill-current" />
                    ))}
                  </div>
                  <p className="text-sm text-gray-600">Loved by operators worldwide</p>
                </div>
              </div>
            </div>

            {/* Hero visual */}
            <div className="relative hidden lg:block">
              <div className="relative bg-white rounded-3xl shadow-2xl shadow-rose-500/10 border border-rose-100/50 p-8 overflow-hidden">
                <div className="absolute top-0 right-0 w-32 h-32 bg-gradient-to-br from-amber-200/50 to-yellow-200/30 rounded-full blur-2xl" />
                <div className="absolute bottom-0 left-0 w-24 h-24 bg-gradient-to-br from-rose-200/50 to-pink-200/30 rounded-full blur-2xl" />

                {/* Stats preview */}
                <div className="relative space-y-6">
                  <div className="flex items-center justify-between pb-4 border-b border-gray-100">
                    <div className="flex items-center gap-3">
                      <div className="p-2 rounded-lg bg-rose-100">
                        <GraduationCap className="h-5 w-5 text-rose-500" />
                      </div>
                      <span className="font-semibold text-gray-900">Your Progress</span>
                    </div>
                    <span className="text-sm text-gray-500">Level 5</span>
                  </div>

                  <div className="grid grid-cols-3 gap-4 text-center">
                    <div className="p-4 rounded-2xl bg-gradient-to-br from-rose-50 to-pink-50 border border-rose-100">
                      <div className="text-2xl font-bold text-rose-600">30+</div>
                      <div className="text-xs text-gray-600">Modules</div>
                    </div>
                    <div className="p-4 rounded-2xl bg-gradient-to-br from-amber-50 to-yellow-50 border border-amber-100">
                      <div className="text-2xl font-bold text-amber-600">126+</div>
                      <div className="text-xs text-gray-600">Hours</div>
                    </div>
                    <div className="p-4 rounded-2xl bg-gradient-to-br from-pink-50 to-rose-50 border border-pink-100">
                      <div className="text-2xl font-bold text-pink-600">5</div>
                      <div className="text-xs text-gray-600">Tracks</div>
                    </div>
                  </div>

                  <div className="p-4 rounded-2xl bg-gradient-to-r from-rose-500 to-amber-500 text-white">
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
                    <span className="text-2xl">🔥</span>
                    <div>
                      <div className="font-semibold text-gray-900">7 day streak!</div>
                      <div className="text-xs text-gray-600">Keep it going</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-20 px-4 bg-gradient-to-b from-transparent via-rose-50/30 to-transparent">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-3xl font-bold mb-4 text-gray-900">What You&apos;ll Learn</h2>
            <p className="text-gray-600 max-w-2xl mx-auto">
              A comprehensive curriculum designed to take you from beginner to professional AI operator.
            </p>
          </div>
          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
            {features.map((feature) => (
              <Card key={feature.title} className="group border-0 shadow-lg shadow-gray-200/50 hover:shadow-xl hover:shadow-rose-200/30 transition-all duration-300 hover:-translate-y-1 bg-white overflow-hidden">
                <CardHeader>
                  <div className={`p-3 w-fit rounded-2xl bg-gradient-to-br ${feature.color} mb-3 group-hover:scale-110 transition-transform shadow-lg`}>
                    <feature.icon className="h-6 w-6 text-white" />
                  </div>
                  <CardTitle className="text-lg text-gray-900">{feature.title}</CardTitle>
                </CardHeader>
                <CardContent>
                  <CardDescription className="text-gray-600">{feature.description}</CardDescription>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Tracks Section */}
      <section id="tracks" className="relative py-20 px-4">
        <div className="max-w-6xl mx-auto relative">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold mb-4 text-gray-900">
              Learning <span className="gradient-text">Tracks</span>
            </h2>
            <p className="text-gray-600 max-w-2xl mx-auto text-lg">
              Structured learning paths to guide your journey from fundamentals to mastery.
            </p>
          </div>

          {/* Core Foundation - Featured */}
          <Card className="mb-8 border-0 shadow-xl shadow-rose-200/30 relative overflow-hidden group bg-white">
            <div className="absolute inset-0 bg-gradient-to-r from-rose-50 via-transparent to-amber-50 opacity-50" />
            <div className="absolute top-0 right-0 w-64 h-64 bg-gradient-to-br from-rose-200/30 to-pink-200/20 rounded-full blur-3xl -translate-y-1/2 translate-x-1/2" />
            <CardHeader className="relative">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-4">
                  <div className="text-4xl p-4 rounded-2xl bg-gradient-to-br from-rose-100 to-amber-100 group-hover:scale-110 transition-transform shadow-lg">
                    🎯
                  </div>
                  <div>
                    <div className="flex items-center gap-3">
                      <CardTitle className="text-2xl text-gray-900">Core Foundation</CardTitle>
                      <span className="px-3 py-1 text-xs font-semibold bg-gradient-to-r from-rose-500 to-pink-500 text-white rounded-full shadow-lg shadow-rose-500/25">
                        Required
                      </span>
                    </div>
                    <CardDescription className="mt-1 text-gray-600">
                      Master the fundamentals of AI operations, systems thinking, and operator mindset.
                    </CardDescription>
                  </div>
                </div>
              </div>
            </CardHeader>
            <CardContent className="relative">
              <div className="flex items-center gap-8 text-sm">
                <span className="flex items-center gap-2 px-4 py-2 rounded-xl bg-rose-50 border border-rose-100 text-gray-700">
                  <BookOpen className="h-4 w-4 text-rose-500" />
                  <span className="font-medium">8 modules</span>
                </span>
                <span className="flex items-center gap-2 px-4 py-2 rounded-xl bg-amber-50 border border-amber-100 text-gray-700">
                  <Zap className="h-4 w-4 text-amber-500" />
                  <span className="font-medium">~25 hours</span>
                </span>
              </div>
            </CardContent>
          </Card>

          {/* Other Tracks Grid */}
          <div className="grid md:grid-cols-2 gap-6">
            {tracks.filter(t => !t.required).map((track) => (
              <Card key={track.name} className="group overflow-hidden relative border-0 shadow-lg shadow-gray-200/50 hover:shadow-xl hover:shadow-rose-200/20 transition-all duration-300 hover:-translate-y-1 bg-white">
                <div className="absolute top-0 right-0 w-32 h-32 bg-gradient-to-br from-rose-100/50 to-transparent rounded-bl-full opacity-0 group-hover:opacity-100 transition-opacity" />
                <CardHeader className="relative">
                  <div className="flex items-center gap-4">
                    <div className="text-3xl p-3 rounded-xl bg-gradient-to-br from-gray-50 to-gray-100 group-hover:from-rose-50 group-hover:to-amber-50 group-hover:scale-110 transition-all border border-gray-100 group-hover:border-rose-100">
                      {track.icon}
                    </div>
                    <div>
                      <CardTitle className="text-xl text-gray-900 group-hover:text-rose-600 transition-colors">{track.name}</CardTitle>
                    </div>
                  </div>
                </CardHeader>
                <CardContent className="space-y-4 relative">
                  <CardDescription className="line-clamp-2 text-gray-600">{track.description}</CardDescription>
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
      <section className="py-20 px-4 bg-gradient-to-b from-transparent via-amber-50/30 to-transparent">
        <div className="max-w-5xl mx-auto">
          <div className="grid md:grid-cols-2 gap-12 items-center">
            <div>
              <h2 className="text-3xl font-bold mb-6 text-gray-900">Learn by Doing</h2>
              <p className="text-gray-600 mb-8">
                Every lesson includes practical exercises and real-world projects.
                Track your progress, earn achievements, and build skills that matter.
              </p>
              <ul className="space-y-4">
                {benefits.map((benefit) => (
                  <li key={benefit} className="flex items-center gap-3">
                    <div className="p-1 rounded-full bg-gradient-to-br from-emerald-400 to-green-500">
                      <CheckCircle className="h-4 w-4 text-white" />
                    </div>
                    <span className="text-gray-700">{benefit}</span>
                  </li>
                ))}
              </ul>
            </div>
            <div className="bg-white border border-gray-100 rounded-3xl p-8 shadow-xl shadow-gray-200/50">
              <div className="flex items-center gap-4 mb-6">
                <div className="p-4 rounded-2xl bg-gradient-to-br from-amber-400 to-yellow-500 shadow-lg shadow-amber-500/30">
                  <Trophy className="h-8 w-8 text-white" />
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
                    <span className="font-medium text-rose-500">62%</span>
                  </div>
                  <div className="h-3 bg-gray-100 rounded-full overflow-hidden">
                    <div className="h-full w-[62%] bg-gradient-to-r from-rose-500 to-amber-500 rounded-full" />
                  </div>
                </div>
                <div className="flex items-center gap-3 p-4 rounded-2xl bg-gradient-to-r from-amber-50 to-yellow-50 border border-amber-100">
                  <span className="text-3xl">🔥</span>
                  <div>
                    <span className="font-semibold text-gray-900">7 day streak</span>
                    <p className="text-xs text-gray-500">You&apos;re on fire!</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 px-4">
        <div className="max-w-3xl mx-auto">
          <div className="relative bg-gradient-to-r from-rose-500 via-pink-500 to-amber-500 rounded-3xl p-12 text-center overflow-hidden shadow-2xl shadow-rose-500/25">
            <div className="absolute top-0 left-0 w-64 h-64 bg-white/10 rounded-full blur-3xl -translate-x-1/2 -translate-y-1/2" />
            <div className="absolute bottom-0 right-0 w-48 h-48 bg-white/10 rounded-full blur-3xl translate-x-1/2 translate-y-1/2" />
            <div className="relative">
              <h2 className="text-3xl font-bold mb-4 text-white">Ready to Start?</h2>
              <p className="text-white/90 mb-8 text-lg">
                Join thousands of learners building the skills to automate businesses and leverage AI.
              </p>
              <Link href="/signup">
                <Button size="xl" className="gap-2 bg-white text-rose-600 hover:bg-gray-50 shadow-xl font-semibold">
                  Create Free Account
                  <ArrowRight className="h-4 w-4" />
                </Button>
              </Link>
            </div>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-gray-100 py-8 px-4 bg-white/50">
        <div className="max-w-6xl mx-auto flex flex-col md:flex-row justify-between items-center gap-4">
          <div className="flex items-center gap-3">
            <div className="p-2 rounded-xl bg-gradient-to-br from-rose-500 to-amber-500">
              <Sparkles className="h-4 w-4 text-white" />
            </div>
            <span className="font-semibold text-gray-900">AI Operator Academy</span>
          </div>
          <p className="text-sm text-gray-500">
            Built for aspiring AI operators everywhere.
          </p>
        </div>
      </footer>
    </div>
  )
}
