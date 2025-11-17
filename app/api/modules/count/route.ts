import { NextResponse } from 'next/server';
import { getAllModules } from '@/lib/markdown';

export async function GET() {
  try {
    const modules = getAllModules();
    return NextResponse.json({ count: modules.length });
  } catch (error) {
    console.error('Error fetching module count:', error);
    return NextResponse.json({ count: 17 }, { status: 200 }); // Fallback
  }
}
