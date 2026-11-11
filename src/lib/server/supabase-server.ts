/**
 * src/lib/server/supabase-server.ts
 * Supabase Client Konteks Request Server (Menghormati RLS Pengguna)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { createClient } from '@supabase/supabase-js';
import { headers } from 'next/headers';

export async function getSupabaseServerClient(explicitAuthHeader?: string) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://mock.supabase.co';
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'mock-anon-key';

  let authHeader = explicitAuthHeader || '';

  if (!authHeader) {
    try {
      const headerStore = await headers();
      authHeader = headerStore?.get ? headerStore.get('authorization') || '' : '';
    } catch {
      // Abaikan jika headers() tidak tersedia di runtime konteks
    }
  }

  return createClient(supabaseUrl, supabaseAnonKey, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
    },
    global: {
      headers: authHeader ? { Authorization: authHeader } : {},
    },
  });
}

export function isSupabasePublicConfigured(): boolean {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  return Boolean(
    supabaseUrl &&
      supabaseAnonKey &&
      !supabaseUrl.includes('mock') &&
      !supabaseAnonKey.includes('mock') &&
      !supabaseUrl.includes('your-project') &&
      !supabaseAnonKey.includes('your-anon-key')
  );
}

export function getSupabasePublicClient() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://mock.supabase.co';
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'mock-anon-key';

  return createClient(supabaseUrl, supabaseAnonKey, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
    },
  });
}

