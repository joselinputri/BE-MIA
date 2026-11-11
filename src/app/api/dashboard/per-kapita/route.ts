/**
 * src/app/api/dashboard/per-kapita/route.ts
 * Endpoint Laporan Per 10.000 Penduduk Per Kelurahan (Normalisasi Wilayah)
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

    const { periode_mulai, periode_akhir, kategori, sumber } = parsed.data;
    const tahunBerjalan = new Date().getFullYear();

    const { data, error } = await supabaseAdmin.rpc('fn_dashboard_per_kapita', {
      p_periode_mulai: periode_mulai || `${tahunBerjalan}-01-01`,
      p_periode_akhir: periode_akhir || `${tahunBerjalan}-12-31`,
      p_kategori_slug: kategori || null,
      p_sumber: sumber || 'semua',
    });

    if (error) {
      return apiSukses([]);
    }

    // Terapkan ambang batas minimal laporan (threshold >= 5) untuk validitas pemeringkatan
    const items = (data || []).map((row: any) => ({
      kelurahan: row.kelurahan,
      kelurahan_kode: row.kelurahan_kode,
      kecamatan: row.kecamatan,
      jumlah_penduduk: row.jumlah_penduduk,
      jumlah_laporan: Number(row.jumlah_laporan),
      laporan_per_10k: Number(Number(row.laporan_per_10k).toFixed(2)),
      provenance_penduduk: row.provenance_penduduk,
      lolos_ambang_batas: Number(row.jumlah_laporan) >= 5,
    }));

    return apiSukses(items, {
      sumber: [
        {
          provenance: 'agregat_resmi',
          nama_sumber: 'Dispendukcapil Kota Surakarta (Data Agregat Smt II 2023)',
          waktu_pembaruan: '2023-12-31',
        },
        {
          provenance: sumber === 'asli' ? 'asli' : 'simulasi_terkalibrasi',
          nama_sumber: 'Pelaporan Aduan Warga RAMPUNG',
          waktu_pembaruan: new Date().toISOString(),
        },
      ],
      waktu_query: new Date().toISOString(),
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat analitik per kapita');
  }
}

