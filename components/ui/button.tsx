import * as React from 'react'
import { Slot } from '@radix-ui/react-slot'
import { cva, type VariantProps } from 'class-variance-authority'
import { cn } from '@/lib/utils/cn'

const buttonVariants = cva(
  'inline-flex items-center justify-center whitespace-nowrap rounded-lg text-sm font-medium ring-offset-background transition-all duration-300 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 relative overflow-hidden',
  {
    variants: {
      variant: {
        default: 'bg-gradient-to-r from-primary to-primary/90 text-primary-foreground hover:shadow-lg hover:shadow-primary/25 hover:scale-[1.02] active:scale-[0.98] btn-shine',
        destructive: 'bg-gradient-to-r from-destructive to-destructive/90 text-destructive-foreground hover:shadow-lg hover:shadow-destructive/25 hover:scale-[1.02] active:scale-[0.98]',
        outline: 'border border-white/10 bg-white/5 backdrop-blur-sm hover:bg-white/10 hover:border-primary/50 hover:shadow-lg hover:shadow-primary/10',
        secondary: 'bg-gradient-to-r from-secondary to-secondary/90 text-secondary-foreground hover:shadow-lg hover:shadow-secondary/25 hover:scale-[1.02] active:scale-[0.98]',
        ghost: 'hover:bg-white/10 hover:text-foreground hover:backdrop-blur-sm',
        link: 'text-primary underline-offset-4 hover:underline hover:text-primary/80',
        success: 'bg-gradient-to-r from-success to-success/90 text-white hover:shadow-lg hover:shadow-success/25 hover:scale-[1.02] active:scale-[0.98]',
        glow: 'bg-gradient-to-r from-primary via-purple-500 to-secondary text-white hover:shadow-xl hover:shadow-primary/30 hover:scale-[1.02] active:scale-[0.98] btn-shine',
      },
      size: {
        default: 'h-10 px-4 py-2',
        sm: 'h-9 rounded-md px-3',
        lg: 'h-11 rounded-lg px-8',
        xl: 'h-12 rounded-xl px-10 text-base font-semibold',
        icon: 'h-10 w-10',
      },
    },
    defaultVariants: {
      variant: 'default',
      size: 'default',
    },
  }
)

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, asChild = false, ...props }, ref) => {
    const Comp = asChild ? Slot : 'button'
    return (
      <Comp
        className={cn(buttonVariants({ variant, size, className }))}
        ref={ref}
        {...props}
      />
    )
  }
)
Button.displayName = 'Button'

export { Button, buttonVariants }
