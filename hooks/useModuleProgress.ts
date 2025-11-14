import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';
import { useSupabase } from './useSupabase';

export interface ModuleProgress {
  id: string;
  user_id: string;
  module_id: string;
  started_at: string;
  completed_at: string | null;
  time_spent_seconds: number;
  completion_percentage: number;
  last_accessed: string;
}

export function useModuleProgress(moduleId?: string) {
  const { user } = useSupabase();
  const [progress, setProgress] = useState<ModuleProgress[]>([]);
  const [loading, setLoading] = useState(true);
  const supabase = createClient();

  useEffect(() => {
    if (!user) {
      setProgress([]);
      setLoading(false);
      return;
    }

    async function fetchProgress() {
      try {
        setLoading(true);
        let query = supabase
          .from('module_progress')
          .select('*')
          .eq('user_id', user!.id);

        if (moduleId) {
          query = query.eq('module_id', moduleId);
        }

        const { data, error } = await query;

        if (error) throw error;
        setProgress(data || []);
      } catch (err) {
        console.error('Error fetching module progress:', err);
      } finally {
        setLoading(false);
      }
    }

    fetchProgress();

    // Subscribe to changes
    const subscription = supabase
      .channel(`module_progress:${user!.id}`)
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'module_progress',
          filter: `user_id=eq.${user!.id}`,
        },
        () => {
          fetchProgress();
        }
      )
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, [user, moduleId, supabase]);

  const startModule = async (moduleId: string) => {
    if (!user) return;

    const { data, error } = await supabase
      .from('module_progress')
      .upsert({
        user_id: user.id,
        module_id: moduleId,
        started_at: new Date().toISOString(),
        last_accessed: new Date().toISOString(),
      }, {
        onConflict: 'user_id,module_id'
      })
      .select()
      .single();

    if (error) {
      console.error('Error starting module:', error);
      return null;
    }

    return data;
  };

  const completeModule = async (moduleId: string) => {
    if (!user) return;

    try {
      // Call the database function
      const { error } = await supabase.rpc('complete_module', {
        p_user_id: user.id,
        p_module_id: moduleId,
      });

      if (error) throw error;
      return true;
    } catch (err) {
      console.error('Error completing module:', err);
      return false;
    }
  };

  const updateProgress = async (moduleId: string, percentage: number) => {
    if (!user) return;

    const { error } = await supabase
      .from('module_progress')
      .update({
        completion_percentage: percentage,
        last_accessed: new Date().toISOString(),
      })
      .eq('user_id', user.id)
      .eq('module_id', moduleId);

    if (error) {
      console.error('Error updating progress:', error);
    }
  };

  return {
    progress,
    loading,
    startModule,
    completeModule,
    updateProgress,
  };
}
