import * as React from 'react'
import { Slot } from '@radix-ui/react-slot'
import { cva, type VariantProps } from 'class-variance-authority'
import { cn } from '@/lib/utils/cn'

const buttonVariants = cva(
  'inline-flex items-center justify-center whitespace-nowrap rounded-lg text-sm font-medium ring-offset-background transition-all duration-200 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 relative overflow-hidden',
  {
    variants: {
      variant: {
        default: 'bg-pink-600 text-white hover:bg-pink-700 hover:shadow-md active:scale-[0.98]',
        destructive: 'bg-red-600 text-white hover:bg-red-700 hover:shadow-md active:scale-[0.98]',
        outline: 'border border-gray-200 bg-white hover:bg-gray-50 hover:border-gray-300 text-gray-700',
        secondary: 'bg-amber-600 text-white hover:bg-amber-700 hover:shadow-md active:scale-[0.98]',
        ghost: 'hover:bg-gray-100 text-gray-600 hover:text-gray-900',
        link: 'text-pink-600 underline-offset-4 hover:underline hover:text-pink-700',
        success: 'bg-emerald-600 text-white hover:bg-emerald-700 hover:shadow-md active:scale-[0.98]',
        glow: 'bg-gradient-to-r from-pink-600 to-amber-600 text-white hover:from-pink-700 hover:to-amber-700 hover:shadow-lg hover:shadow-pink-500/20 active:scale-[0.98]',
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
