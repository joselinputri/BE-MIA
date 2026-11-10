/**
 * src/app/api/petugas/ditandai/route.ts
 * Endpoint Daftar Laporan yang Ditandai Perlu Verifikasi Tambahan oleh Sistem
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(req: NextRequest) {
  try {
    const auth = await dapatkanKonteksAuth();
    if (!auth.isAuthenticated || (auth.role !== 'petugas' && auth.role !== 'admin')) {
      return apiError('FORBIDDEN', 'Akses khusus petugas dan admin');
    }

    let query = supabaseAdmin
      .from('laporan')
      .select('id, kode_lacak, judul, deskripsi, status, penanda, created_at, kategori:kategori_id(nama, slug), kelurahan:kelurahan_id(nama)')
      .contains('penanda', ['perlu_verifikasi_tambahan'])
      .order('created_at', { ascending: false })
      .limit(50);

    if (auth.role === 'petugas' && auth.dinasId) {
      query = query.eq('dinas_id', auth.dinasId);
    }

    const { data, error } = await query;

    if (error) {
      return apiSukses([]);
    }

    return apiSukses(data || []);
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat antrean verifikasi tambahan');
  }
}

