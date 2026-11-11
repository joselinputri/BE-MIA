/**
 * src/lib/server/supabase-admin.ts
 * Supabase Admin Client (Service Role) — HANYA UNTUK SERVER
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 * 
 * ⚠️ PERINGATAN KEAMANAN:
 * File ini TIDAK BOLEH diimpor oleh komponen client (use client) apapun.
 * Kunci Service Role membypass seluruh Row Level Security.
 */

import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://mock.supabase.co';
const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY || 'mock-service-role-key';

// Cek keamanan lingkungan runtime
if (typeof window !== 'undefined') {
  throw new Error('FATAL: supabase-admin.ts dieksekusi di lingkungan browser! Bahaya kebocoran service role key.');
}

/**
 * Cek apakah Supabase sudah dikonfigurasi dengan kunci nyata (bukan mock/placeholder).
 * Berguna agar endpoint bisa mengembalikan 503 yang jelas saat env belum diisi.
 */
export function isSupabaseConfigured(): boolean {
  return (
    !!process.env.NEXT_PUBLIC_SUPABASE_URL &&
    !process.env.NEXT_PUBLIC_SUPABASE_URL.includes('mock') &&
    !!process.env.SUPABASE_SERVICE_ROLE_KEY &&
    !process.env.SUPABASE_SERVICE_ROLE_KEY.includes('mock')
  );
}

export const supabaseAdmin = createClient(supabaseUrl, serviceRoleKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false,
  },
});

