'use client'

import { useState, useEffect, useCallback } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import { Label } from '@/components/ui/label'
import { Button } from '@/components/ui/button'
import { Checkbox } from '@/components/ui/checkbox'
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { Progress } from '@/components/ui/progress'
import { Badge } from '@/components/ui/badge'
import { CheckCircle, Save, Loader2 } from 'lucide-react'

// Types for exercise schema
interface ExerciseField {
  id: string
  type: 'text' | 'textarea' | 'select' | 'checkbox' | 'checkbox_group' | 'radio' | 'rating' | 'table'
  label: string
  placeholder?: string
  required?: boolean
  options?: string[]
  rows?: number
  min?: number
  max?: number
  columns?: string[]
  rowCount?: number
}

interface ExercisePart {
  id: string
  title: string
  description?: string
  fields: ExerciseField[]
}

interface ExerciseSchema {
  parts: ExercisePart[]
  deliverables?: string[]
  success_criteria?: string[]
}

interface ExerciseFormProps {
  sectionId: string
  userId: string
  schema: ExerciseSchema
}

export function ExerciseForm({ sectionId, userId, schema }: ExerciseFormProps) {
  const [responses, setResponses] = useState<Record<string, unknown>>({})
  const [saving, setSaving] = useState(false)
  const [lastSaved, setLastSaved] = useState<Date | null>(null)
  const [completionPercent, setCompletionPercent] = useState(0)
  const [isComplete, setIsComplete] = useState(false)
  const [loading, setLoading] = useState(true)
  const supabase = createClient()

  // Load existing responses on mount
  useEffect(() => {
    async function loadResponses() {
      const { data } = await supabase
        .from('user_exercise_responses')
        .select('responses, completion_percent, is_complete')
        .eq('section_id', sectionId)
        .eq('user_id', userId)
        .single()

      if (data) {
        setResponses(data.responses || {})
        setCompletionPercent(data.completion_percent || 0)
        setIsComplete(data.is_complete || false)
      }
      setLoading(false)
    }
    loadResponses()
  }, [sectionId, userId, supabase])

  // Calculate local completion percentage
  const calculateCompletion = useCallback(() => {
    let totalRequired = 0
    let completedRequired = 0

    schema.parts.forEach(part => {
      part.fields.forEach(field => {
        if (field.required) {
          totalRequired++
          const value = responses[field.id]
          if (value !== undefined && value !== null && value !== '' &&
              !(Array.isArray(value) && value.length === 0) &&
              !(typeof value === 'object' && Object.keys(value).length === 0)) {
            completedRequired++
          }
        }
      })
    })

    return totalRequired > 0 ? Math.round((completedRequired / totalRequired) * 100) : 100
  }, [schema.parts, responses])

  // Update completion when responses change
  useEffect(() => {
    if (!loading) {
      setCompletionPercent(calculateCompletion())
    }
  }, [responses, loading, calculateCompletion])

  // Save responses to database
  const saveResponses = useCallback(async (showSaving = true) => {
    if (showSaving) setSaving(true)

    const { error } = await supabase
      .from('user_exercise_responses')
      .upsert({
        user_id: userId,
        section_id: sectionId,
        responses,
        updated_at: new Date().toISOString(),
      }, {
        onConflict: 'user_id,section_id'
      })

    if (!error) {
      setLastSaved(new Date())
      // Fetch updated completion from server (trigger calculates it)
      const { data } = await supabase
        .from('user_exercise_responses')
        .select('completion_percent, is_complete')
        .eq('section_id', sectionId)
        .eq('user_id', userId)
        .single()

      if (data) {
        setCompletionPercent(data.completion_percent)
        setIsComplete(data.is_complete)
      }
    }

    if (showSaving) setSaving(false)
  }, [supabase, userId, sectionId, responses])

  // Auto-save with debounce
  useEffect(() => {
    if (loading) return

    const timer = setTimeout(() => {
      saveResponses(false)
    }, 2000)

    return () => clearTimeout(timer)
  }, [responses, loading, saveResponses])

  // Update a field value
  const updateField = (fieldId: string, value: unknown) => {
    setResponses(prev => ({ ...prev, [fieldId]: value }))
  }

  // Render different field types
  const renderField = (field: ExerciseField) => {
    const value = responses[field.id]

    switch (field.type) {
      case 'text':
        return (
          <Input
            id={field.id}
            placeholder={field.placeholder}
            value={(value as string) || ''}
            onChange={(e) => updateField(field.id, e.target.value)}
          />
        )

      case 'textarea':
        return (
          <Textarea
            id={field.id}
            placeholder={field.placeholder}
            rows={field.rows || 4}
            value={(value as string) || ''}
            onChange={(e) => updateField(field.id, e.target.value)}
          />
        )

      case 'select':
        return (
          <Select
            value={(value as string) || ''}
            onValueChange={(v) => updateField(field.id, v)}
          >
            <SelectTrigger>
              <SelectValue placeholder={field.placeholder || 'Select an option'} />
            </SelectTrigger>
            <SelectContent>
              {field.options?.map((option) => (
                <SelectItem key={option} value={option}>
                  {option}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        )

      case 'radio':
        return (
          <RadioGroup
            value={(value as string) || ''}
            onValueChange={(v) => updateField(field.id, v)}
            className="space-y-2"
          >
            {field.options?.map((option) => (
              <div key={option} className="flex items-center space-x-2">
                <RadioGroupItem value={option} id={`${field.id}-${option}`} />
                <Label htmlFor={`${field.id}-${option}`} className="font-normal cursor-pointer">
                  {option}
                </Label>
              </div>
            ))}
          </RadioGroup>
        )

      case 'checkbox':
        return (
          <div className="flex items-center space-x-2">
            <Checkbox
              id={field.id}
              checked={(value as boolean) || false}
              onCheckedChange={(checked) => updateField(field.id, checked)}
            />
            <Label htmlFor={field.id} className="font-normal cursor-pointer">
              {field.placeholder || 'Yes'}
            </Label>
          </div>
        )

      case 'checkbox_group':
        const selectedValues = (value as string[]) || []
        return (
          <div className="space-y-2">
            {field.options?.map((option) => (
              <div key={option} className="flex items-center space-x-2">
                <Checkbox
                  id={`${field.id}-${option}`}
                  checked={selectedValues.includes(option)}
                  onCheckedChange={(checked) => {
                    if (checked) {
                      updateField(field.id, [...selectedValues, option])
                    } else {
                      updateField(field.id, selectedValues.filter(v => v !== option))
                    }
                  }}
                />
                <Label htmlFor={`${field.id}-${option}`} className="font-normal cursor-pointer">
                  {option}
                </Label>
              </div>
            ))}
          </div>
        )

      case 'rating':
        const min = field.min || 1
        const max = field.max || 10
        const ratings = Array.from({ length: max - min + 1 }, (_, i) => min + i)
        return (
          <div className="flex flex-wrap gap-2">
            {ratings.map((rating) => (
              <button
                key={rating}
                type="button"
                onClick={() => updateField(field.id, rating)}
                className={`w-10 h-10 rounded-lg border-2 transition-colors ${
                  value === rating
                    ? 'bg-primary text-primary-foreground border-primary'
                    : 'bg-muted hover:bg-muted/80 border-border'
                }`}
              >
                {rating}
              </button>
            ))}
          </div>
        )

      case 'table':
        const columns = field.columns || ['Column 1', 'Column 2']
        const rowCount = field.rowCount || 3
        const tableData = (value as Record<string, string[]>) || {}

        return (
          <div className="overflow-x-auto">
            <table className="w-full border-collapse border border-border">
              <thead>
                <tr>
                  {columns.map((col, i) => (
                    <th key={i} className="border border-border bg-muted px-3 py-2 text-left text-sm font-medium">
                      {col}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {Array.from({ length: rowCount }, (_, rowIdx) => (
                  <tr key={rowIdx}>
                    {columns.map((col, colIdx) => (
                      <td key={colIdx} className="border border-border p-1">
                        <Input
                          className="border-0 focus-visible:ring-0 focus-visible:ring-offset-0"
                          placeholder={`Row ${rowIdx + 1}`}
                          value={tableData[`${rowIdx}-${colIdx}`] || ''}
                          onChange={(e) => {
                            updateField(field.id, {
                              ...tableData,
                              [`${rowIdx}-${colIdx}`]: e.target.value
                            })
                          }}
                        />
                      </td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )

      default:
        return null
    }
  }

  if (loading) {
    return (
      <Card className="border-border bg-card border-l-4 border-l-primary">
        <CardContent className="flex items-center justify-center py-12">
          <Loader2 className="h-6 w-6 animate-spin text-muted-foreground" />
        </CardContent>
      </Card>
    )
  }

  return (
    <Card className="border-border bg-card border-l-4 border-l-primary">
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle className="text-lg flex items-center gap-2">
              Exercise
              {isComplete && (
                <Badge variant="success" className="gap-1">
                  <CheckCircle className="h-3 w-3" />
                  Complete
                </Badge>
              )}
            </CardTitle>
            <CardDescription className="mt-1">
              Your progress is automatically saved
            </CardDescription>
          </div>
          <div className="flex items-center gap-3">
            <div className="text-sm text-muted-foreground">
              {completionPercent}% complete
            </div>
            <Progress value={completionPercent} className="w-24 h-2" />
          </div>
        </div>
      </CardHeader>

      <CardContent className="space-y-8">
        {schema.parts.map((part) => (
          <div key={part.id} className="space-y-4">
            <div>
              <h3 className="text-base font-semibold">{part.title}</h3>
              {part.description && (
                <p className="text-sm text-muted-foreground mt-1">{part.description}</p>
              )}
            </div>

            <div className="space-y-4 pl-4 border-l-2 border-muted">
              {part.fields.map((field) => (
                <div key={field.id} className="space-y-2">
                  <Label htmlFor={field.id} className="text-sm font-medium">
                    {field.label}
                    {field.required && <span className="text-destructive ml-1">*</span>}
                  </Label>
                  {renderField(field)}
                </div>
              ))}
            </div>
          </div>
        ))}

        {/* Deliverables */}
        {schema.deliverables && schema.deliverables.length > 0 && (
          <div className="space-y-2 pt-4 border-t border-border">
            <h3 className="text-sm font-semibold text-muted-foreground">Deliverables</h3>
            <ul className="list-disc list-inside text-sm space-y-1">
              {schema.deliverables.map((item, i) => (
                <li key={i}>{item}</li>
              ))}
            </ul>
          </div>
        )}

        {/* Success Criteria */}
        {schema.success_criteria && schema.success_criteria.length > 0 && (
          <div className="space-y-2">
            <h3 className="text-sm font-semibold text-muted-foreground">Success Criteria</h3>
            <ul className="list-disc list-inside text-sm space-y-1">
              {schema.success_criteria.map((item, i) => (
                <li key={i}>{item}</li>
              ))}
            </ul>
          </div>
        )}

        {/* Save button and status */}
        <div className="flex items-center justify-between pt-4 border-t border-border">
          <div className="text-sm text-muted-foreground">
            {lastSaved && (
              <span>Last saved: {lastSaved.toLocaleTimeString()}</span>
            )}
          </div>
          <Button onClick={() => saveResponses()} disabled={saving}>
            {saving ? (
              <>
                <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                Saving...
              </>
            ) : (
              <>
                <Save className="h-4 w-4 mr-2" />
                Save Progress
              </>
            )}
          </Button>
        </div>
      </CardContent>
    </Card>
  )
}
