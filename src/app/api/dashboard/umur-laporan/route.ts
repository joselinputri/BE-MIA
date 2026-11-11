/**
 * src/app/api/dashboard/umur-laporan/route.ts
 * Endpoint Distribusi Umur Laporan Belum Selesai (Backlog Aging)
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

    const { kategori, kecamatan, sumber } = parsed.data;

    if (!isSupabaseConfigured()) {
      return apiError('SERVICE_UNAVAILABLE', 'Supabase belum dikonfigurasi untuk memuat umur laporan.');
    }

    const { data, error } = await supabaseAdmin.rpc('fn_dashboard_umur_laporan', {
      p_kategori_slug: kategori || null,
      p_kecamatan_kode: kecamatan || null,
      p_sumber: sumber === 'simulasi' ? 'simulasi' : 'asli',
    });

    if (error) {
      return apiError('INTERNAL_ERROR', 'Gagal memuat umur laporan. Pastikan migrasi fungsi dashboard sudah dijalankan.');
    }

    return apiSukses(data || [], {
      sumber: [
        {
          provenance: sumber === 'asli' ? 'asli' : 'simulasi_terkalibrasi',
          nama_sumber: 'Monitoring Antrean Tiket Aktif RAMPUNG',
          waktu_pembaruan: new Date().toISOString(),
        },
      ],
      waktu_query: new Date().toISOString(),
    });
  } catch (err: any) {
    console.error('[dashboard/umur-laporan] Error:', err?.message || err);
    return apiError('INTERNAL_ERROR', 'Gagal memuat distribusi umur laporan');
  }
}

