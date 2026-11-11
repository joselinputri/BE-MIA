/**
 * src/app/api/dashboard/insight/route.ts
 * Endpoint Civic Insight Otomatis Berbasis Template Kalimat Deskriptif (Tanpa Klaim Kausal)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 *
 * Versi gabungan: query live Supabase + fallback statis jika belum dikonfigurasi.
 */

import { NextRequest } from 'next/server';
import { DashboardFilterSchema, CivicInsight } from '@/lib/contracts/dashboard';
import { apiSukses, apiError } from '@/lib/server/response';
import { isSupabaseConfigured, supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const parsed = DashboardFilterSchema.safeParse(Object.fromEntries(searchParams.entries()));

    if (!parsed.success) {
      return apiError('VALIDATION_ERROR', 'Parameter filter tidak valid');
    }

    // ── Jika Supabase belum dikonfigurasi, kembalikan insight statis ─
    if (!isSupabaseConfigured()) {
      const fallbackInsight: CivicInsight[] = [
        {
          id: 'ins-01', kategori: 'kecepatan',
          judul: 'Efisiensi Penanganan Aspal Jalan',
          deskripsi: 'Median durasi penanganan aduan penambalan aspal oleh DPUPR tercatat 1.1 hari, lebih cepat dari target standar SLA 7 hari.',
          tipe_penanda: 'positif', sumber_terkait: 'Linimasa Status & SLA DPUPR Surakarta',
        },
        {
          id: 'ins-02', kategori: 'kepuasan',
          judul: 'Tingkat Kepuasan Hasil Fisik',
          deskripsi: 'Dari 128 pelapor yang melakukan audit gotong-royong sebelum-sesudah, sebanyak 89.5% menyatakan puas dengan hasil pengerjaan di lapangan.',
          tipe_penanda: 'positif', sumber_terkait: 'Audit Gotong Royong Pelapor RAMPUNG',
        },
        {
          id: 'ins-03', kategori: 'wilayah',
          judul: 'Konsentrasi Aduan Per Wilayah',
          deskripsi: 'Kecamatan Banjarsari dan Jebres mencatatkan volume laporan tertinggi sebanding dengan proporsi jumlah penduduk terbesar di Kota Surakarta.',
          tipe_penanda: 'netral', sumber_terkait: 'Dispendukcapil Surakarta & Peta Laporan RAMPUNG',
        },
        {
          id: 'ins-04', kategori: 'tren',
          judul: 'Pemantauan Saluran Drainase',
          deskripsi: 'Sebanyak 3 laporan terkait sedimentasi drainase berumur lebih dari 8 hari dan saat ini berada dalam status penanganan regu lapangan.',
          tipe_penanda: 'perhatian', sumber_terkait: 'Monitoring Backlog Penanganan Fasilitas Kota',
        },
      ];
      return apiSukses(fallbackInsight, {
        sumber: [{ provenance: 'simulasi_terkalibrasi', nama_sumber: 'Fallback Insight RAMPUNG', waktu_pembaruan: new Date().toISOString() }],
        waktu_query: new Date().toISOString(),
      });
    }

    // ── Query live dari Supabase ─────────────────────────────────────
    const tahunBerjalan = new Date().getFullYear();
    const [tren, konfirmasi] = await Promise.all([
      supabaseAdmin.rpc('fn_dashboard_tren', {
        p_periode_mulai: parsed.data.periode_mulai || `${tahunBerjalan}-01-01`,
        p_periode_akhir: parsed.data.periode_akhir || `${tahunBerjalan}-12-31`,
        p_kategori_slug: parsed.data.kategori || null,
        p_kecamatan_kode: parsed.data.kecamatan || null,
        p_kelurahan_kode: parsed.data.kelurahan || null,
        p_sumber: 'asli',
      }),
      supabaseAdmin.rpc('fn_dashboard_konfirmasi', {
        p_periode_mulai: parsed.data.periode_mulai || `${tahunBerjalan}-01-01`,
        p_periode_akhir: parsed.data.periode_akhir || `${tahunBerjalan}-12-31`,
        p_kategori_slug: parsed.data.kategori || null,
        p_kecamatan_kode: parsed.data.kecamatan || null,
        p_sumber: 'asli',
      }),
    ]);

    if (tren.error || konfirmasi.error) {
      return apiError('INTERNAL_ERROR', 'Gagal membuat insight. Pastikan migrasi fungsi dashboard sudah dijalankan.');
    }

    const daftarInsight: CivicInsight[] = [];
    const bulanTerakhir = tren.data?.[tren.data.length - 1];
    if (bulanTerakhir && Number(bulanTerakhir.jumlah_masuk) > 0) {
      daftarInsight.push({
        id: 'tren-laporan-terbaru', kategori: 'tren',
        judul: 'Ringkasan laporan periode terakhir',
        deskripsi: `${Number(bulanTerakhir.jumlah_masuk)} laporan masuk dan ${Number(bulanTerakhir.jumlah_selesai)} laporan selesai pada periode terakhir yang tersedia.`,
        tipe_penanda: 'netral', sumber_terkait: 'Laporan warga yang tersimpan di Supabase',
      });
    }

    const statistikKonfirmasi = konfirmasi.data?.[0];
    if (statistikKonfirmasi && Number(statistikKonfirmasi.total_dikonfirmasi) > 0) {
      daftarInsight.push({
        id: 'konfirmasi-pelapor', kategori: 'kepuasan',
        judul: 'Konfirmasi hasil oleh pelapor',
        deskripsi: `${Number(statistikKonfirmasi.total_dikonfirmasi)} laporan telah mendapat konfirmasi dari pelapor.`,
        tipe_penanda: 'netral', sumber_terkait: 'Konfirmasi pelapor yang tersimpan di Supabase',
      });
    }

    return apiSukses(daftarInsight, {
      sumber: [{ provenance: 'asli', nama_sumber: 'Ringkasan laporan Supabase', waktu_pembaruan: new Date().toISOString() }],
      waktu_query: new Date().toISOString(),
    });
  } catch (err: any) {
    console.error('[dashboard/insight] Error:', err?.message || err);
    return apiError('INTERNAL_ERROR', 'Gagal memuat civic insight');
  }
}
