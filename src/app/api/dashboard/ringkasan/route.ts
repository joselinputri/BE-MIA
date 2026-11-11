/**
 * src/app/api/dashboard/ringkasan/route.ts
 * Endpoint Ringkasan Metrik Beranda (Papan Tanggap & KPI Utama)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 *
 * Versi gabungan: query live Supabase + fallback statis jika belum dikonfigurasi.
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { RingkasanLanding } from '@/lib/contracts/dashboard';
import { isSupabaseConfigured, supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(_req: NextRequest) {
  try {
    // ── Jika Supabase belum dikonfigurasi, kembalikan data demo ──────
    if (!isSupabaseConfigured()) {
      const fallback: RingkasanLanding = {
        laporan_bulan_ini: 57,
        laporan_selesai: 49,
        persentase_selesai: 85.9,
        sedang_dikerjakan: 8,
        rata_rata_harian: 35,
        kinerja_dinas: [
          { singkatan: 'DPUPR', nama: 'Dinas Pekerjaan Umum & Penataan Ruang (DPUPR)', rata_hari: 1.1, persen_tuntas: 98.0 },
          { singkatan: 'Dishub', nama: 'Dinas Perhubungan (Dishub)', rata_hari: 1.3, persen_tuntas: 96.5 },
          { singkatan: 'DLH', nama: 'Dinas Lingkungan Hidup (DLH)', rata_hari: 1.6, persen_tuntas: 94.0 },
          { singkatan: 'Satpol PP', nama: 'Satuan Polisi Pamong Praja (Satpol PP)', rata_hari: 1.8, persen_tuntas: 89.2 },
        ],
      };
      return apiSukses(fallback, {
        sumber: [{ provenance: 'simulasi_terkalibrasi', nama_sumber: 'Fallback Demo RAMPUNG', waktu_pembaruan: new Date().toISOString() }],
        waktu_query: new Date().toISOString(),
      });
    }

    // ── Query live dari Supabase ─────────────────────────────────────
    const now = new Date();
    const mulaiBulan = new Date(now.getFullYear(), now.getMonth(), 1).toISOString();
    const akhirBulan = now.toISOString();

    const [total, selesai, dikerjakan] = await Promise.all([
      supabaseAdmin
        .from('laporan_publik')
        .select('id', { count: 'exact', head: true })
        .eq('is_simulasi', false)
        .gte('created_at', mulaiBulan)
        .lte('created_at', akhirBulan),
      supabaseAdmin
        .from('laporan_publik')
        .select('id', { count: 'exact', head: true })
        .eq('status', 'selesai')
        .eq('is_simulasi', false)
        .gte('created_at', mulaiBulan)
        .lte('created_at', akhirBulan),
      supabaseAdmin
        .from('laporan_publik')
        .select('id', { count: 'exact', head: true })
        .in('status', ['ditinjau', 'sedang_ditangani'])
        .eq('is_simulasi', false)
        .gte('created_at', mulaiBulan)
        .lte('created_at', akhirBulan),
    ]);

    if (total.error || selesai.error || dikerjakan.error) {
      return apiError('INTERNAL_ERROR', 'Gagal menghitung ringkasan dari Supabase.');
    }

    const jumlahMasuk = total.count || 0;
    const jumlahSelesai = selesai.count || 0;
    const data: RingkasanLanding = {
      laporan_bulan_ini: jumlahMasuk,
      laporan_selesai: jumlahSelesai,
      persentase_selesai: jumlahMasuk ? Number(((jumlahSelesai / jumlahMasuk) * 100).toFixed(1)) : 0,
      sedang_dikerjakan: dikerjakan.count || 0,
      rata_rata_harian: Number((jumlahMasuk / Math.max(now.getDate(), 1)).toFixed(1)),
      kinerja_dinas: [],
    };

    return apiSukses(data, {
      sumber: [{ provenance: 'asli', nama_sumber: 'Laporan Supabase RAMPUNG', waktu_pembaruan: now.toISOString() }],
      waktu_query: now.toISOString(),
    });
  } catch {
    return apiError('INTERNAL_ERROR', 'Gagal memuat ringkasan dashboard');
  }
}
