// Format date for display
export function formatDate(dateString: string | null): string {
  if (!dateString) return 'Never'

  const date = new Date(dateString)
  const now = new Date()
  const diffMs = now.getTime() - date.getTime()
  const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24))

  if (diffDays === 0) {
    return 'Today'
  } else if (diffDays === 1) {
    return 'Yesterday'
  } else if (diffDays < 7) {
    return `${diffDays} days ago`
  } else {
    return date.toLocaleDateString('en-US', {
      month: 'short',
      day: 'numeric',
      year: date.getFullYear() !== now.getFullYear() ? 'numeric' : undefined,
    })
  }
}

// Format relative time
export function formatRelativeTime(dateString: string): string {
  const date = new Date(dateString)
  const now = new Date()
  const diffMs = now.getTime() - date.getTime()
  const diffSeconds = Math.floor(diffMs / 1000)
  const diffMinutes = Math.floor(diffSeconds / 60)
  const diffHours = Math.floor(diffMinutes / 60)
  const diffDays = Math.floor(diffHours / 24)

  if (diffSeconds < 60) {
    return 'Just now'
  } else if (diffMinutes < 60) {
    return `${diffMinutes}m ago`
  } else if (diffHours < 24) {
    return `${diffHours}h ago`
  } else if (diffDays < 7) {
    return `${diffDays}d ago`
  } else {
    return formatDate(dateString)
  }
}

// Format percentage
export function formatPercent(value: number): string {
  return `${Math.round(value)}%`
}

// Format number with commas
export function formatNumber(value: number): string {
  return value.toLocaleString('en-US')
}

// Truncate text with ellipsis
export function truncate(text: string, maxLength: number): string {
  if (text.length <= maxLength) return text
  return text.slice(0, maxLength - 3) + '...'
}

// Pluralize a word
export function pluralize(count: number, singular: string, plural?: string): string {
  const pluralForm = plural || `${singular}s`
  return count === 1 ? singular : pluralForm
}

// Get level color based on level name
export function getLevelColor(level: 'Beginner' | 'Intermediate' | 'Advanced'): string {
  switch (level) {
    case 'Beginner':
      return 'text-success'
    case 'Intermediate':
      return 'text-warning'
    case 'Advanced':
      return 'text-danger'
    default:
      return 'text-text-secondary'
  }
}

// Get level background color
export function getLevelBgColor(level: 'Beginner' | 'Intermediate' | 'Advanced'): string {
  switch (level) {
    case 'Beginner':
      return 'bg-success/10 text-success'
    case 'Intermediate':
      return 'bg-warning/10 text-warning'
    case 'Advanced':
      return 'bg-danger/10 text-danger'
    default:
      return 'bg-muted text-muted-foreground'
  }
}

// Get resource type icon
export function getResourceTypeIcon(type: string): string {
  switch (type) {
    case 'video':
      return '🎬'
    case 'article':
      return '📄'
    case 'documentation':
      return '📚'
    case 'github':
      return '💻'
    case 'tool':
      return '🔧'
    default:
      return '🔗'
  }
}
