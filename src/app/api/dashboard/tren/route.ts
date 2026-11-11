/**
 * src/app/api/dashboard/tren/route.ts
 * Endpoint Tren Laporan Masuk vs Selesai Bulanan
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { DashboardFilterSchema } from '@/lib/contracts/dashboard';
import { apiSukses, apiError } from '@/lib/server/response';
import { isSupabaseConfigured, supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const parsed = DashboardFilterSchema.safeParse(Object.fromEntries(searchParams.entries()));

    if (!parsed.success) {
      return apiError('VALIDATION_ERROR', 'Parameter filter tidak valid');
    }

    const { periode_mulai, periode_akhir, kategori, kecamatan, kelurahan, sumber } = parsed.data;
    const tahunBerjalan = new Date().getFullYear();

    const { data, error } = await supabaseAdmin.rpc('fn_dashboard_tren', {
      p_periode_mulai: periode_mulai || `${tahunBerjalan}-01-01`,
      p_periode_akhir: periode_akhir || `${tahunBerjalan}-12-31`,
      p_kategori_slug: kategori || null,
      p_kecamatan_kode: kecamatan || null,
      p_kelurahan_kode: kelurahan || null,
      p_sumber: sumber || 'semua',
    });

    if (error) {
      console.error('[dashboard/tren] DB error:', error.message, error.details, error.hint);
      return apiError('INTERNAL_ERROR', 'Gagal memuat tren laporan. Pastikan migrasi fungsi dashboard (fn_dashboard_tren) sudah dijalankan.');
    }

    return apiSukses(data || [], {
      sumber: [
        {
          provenance: sumber === 'asli' ? 'asli' : 'simulasi_terkalibrasi',
          nama_sumber: 'Database Pelaporan Warga RAMPUNG Kota Surakarta',
          waktu_pembaruan: new Date().toISOString(),
        },
      ],
      waktu_query: new Date().toISOString(),
    });
  } catch (err: any) {
    console.error('[dashboard/tren] Error:', err?.message || err);
    return apiError('INTERNAL_ERROR', 'Gagal memuat tren laporan');
  }
}

