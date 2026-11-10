/**
 * src/app/api/notifikasi/route.ts
 * Endpoint Daftar Notifikasi In-App Pengguna
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(req: NextRequest) {
  try {
    const auth = await dapatkanKonteksAuth();
    const { searchParams } = new URL(req.url);
    const kodeLacak = searchParams.get('kode_lacak');

    // Pengguna harus login ATAU menyediakan kode_lacak anonim
    if (!auth.isAuthenticated && !kodeLacak) {
      return apiError('UNAUTHORIZED', 'Kredensial atau kode lacak diperlukan untuk melihat notifikasi');
    }

    let query = supabaseAdmin
      .from('notifikasi')
      .select('id, judul, pesan, tipe, is_dibaca, kode_lacak, created_at, laporan_id')
      .order('created_at', { ascending: false })
      .limit(30);

    if (auth.isAuthenticated && auth.userId) {
      query = query.eq('user_id', auth.userId);
    } else if (kodeLacak) {
      query = query.eq('kode_lacak', kodeLacak.trim().toUpperCase());
    }

    const { data, error } = await query;

    if (error) {
      return apiSukses([]);
    }

    return apiSukses(data || []);
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat notifikasi');
  }
}

