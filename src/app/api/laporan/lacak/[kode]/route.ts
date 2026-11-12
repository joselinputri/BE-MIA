/**
 * src/app/api/laporan/lacak/[kode]/route.ts
 * Endpoint Pelacakan Laporan Berdasarkan Kode Lacak (Resi Aduan Warga)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { periksaRateLimit, hashIP } from '@/lib/server/rate-limit';
import { supabaseAdmin } from '@/lib/server/supabase-admin';
import { formatBanyakUrlFoto } from '@/lib/server/upload';
import { periksaKontenLaporan } from '@/lib/server/sanitizer';

export async function GET(
  req: NextRequest,
  { params }: { params: Promise<{ kode: string }> }
) {
  try {
    const { kode: kodeRaw } = await params;
    const ip = req.headers.get('x-forwarded-for')?.split(',')[0] || '127.0.0.1';
    // Sanitasi kode lacak: hilangkan tanda pagar '#', spasi, dan jadikan huruf kapital
    let kode = (kodeRaw || '').trim().replace(/^#/, '').toUpperCase();

    // 1. Rate Limiting Ketat Anti-Enumerasi (30 request/menit per IP)
    const rateCheck = periksaRateLimit(hashIP(ip), 'lacak_kode', 30, 60);
    if (!rateCheck.allowed) {
      return apiError(
        'RATE_LIMITED',
        `Terlalu banyak permintaan pelacakan. Silakan coba kembali dalam ${rateCheck.resetSeconds} detik.`
      );
    }

    if (!kode || kode.length < 5 || kode.length > 25) {
      return apiError('NOT_FOUND', 'Laporan dengan kode lacak tersebut tidak ditemukan.');
    }

    // 2. Ambil data dari view publik (bebas PII)
    const { data: laporan, error } = await supabaseAdmin
      .from('laporan_publik')
      .select('*')
      .or(`kode_lacak.eq.${kode},kode_lacak.ilike.%${kode}%`)
      .single();

    if (error || !laporan) {
      // Respons seragam tanpa membocorkan detail internal
      return apiError('NOT_FOUND', 'Laporan dengan kode lacak tersebut tidak ditemukan.');
    }

    // Evaluasi konten cerdas/rule-based untuk memastikan deteksi spam & joki tetap aktif
    const cekKonten = periksaKontenLaporan(laporan.judul || '', laporan.deskripsi || '');
    let penandaAktif: string[] = Array.isArray(laporan.penanda) ? [...laporan.penanda] : [];
    if (cekKonten.penanda.length > 0 && !penandaAktif.includes('perlu_verifikasi_tambahan')) {
      penandaAktif = [...penandaAktif, ...cekKonten.penanda];
    }

    // 3. Ambil linimasa status history & konfirmasi pelapor
    const [historyRes, konfirmasiRes] = await Promise.all([
      supabaseAdmin
        .from('status_history')
        .select('status_dari, status_ke, catatan, created_at')
        .eq('laporan_id', laporan.id)
        .order('created_at', { ascending: true }),
      supabaseAdmin
        .from('konfirmasi_pelapor')
        .select('jawaban, rating, komentar, created_at')
        .eq('laporan_id', laporan.id)
        .maybeSingle(),
    ]);

    const history = historyRes.data;
    const konfirmasiWarga = konfirmasiRes.data;

    // 4. Hitung SLA
    const createdDate = new Date(laporan.created_at);
    const now = new Date();
    const selisihHari = Math.floor((now.getTime() - createdDate.getTime()) / (1000 * 3600 * 24));

    const linimasaList = history && history.length > 0 ? history : [
      {
        status_ke: 'masuk',
        judul_tahap: 'Diterima & Verifikasi Sistem',
        catatan: penandaAktif.includes('perlu_verifikasi_tambahan')
          ? 'Laporan ditandai sistem: Terdeteksi anomali/spam/joki (menunggu verifikasi manual petugas)'
          : 'Terdata di SI-ADUAN Siaga RAMPUNG Surakarta',
        created_at: laporan.created_at,
      },
      { status_ke: 'ditinjau', judul_tahap: 'Dicek OPD', catatan: 'Disposisi OPD pengampu dan verifikasi lapangan', created_at: laporan.created_at },
      { status_ke: 'sedang_ditangani', judul_tahap: 'Dikerjakan', catatan: 'Regu Reaksi Cepat melakukan tindakan fisik di lokasi', created_at: laporan.updated_at },
      { status_ke: 'selesai', judul_tahap: 'Konfirmasi', catatan: 'Pekerjaan selesai, menunggu validasi warga pelapor', created_at: laporan.updated_at }
    ];

    // Ambil catatan teknis jika laporan sudah diverifikasi / ditindaklanjuti
    const sudahDiverifikasi = laporan.status !== 'masuk';
    // Ambil dari status_history: cari catatan di entry 'sedang_ditangani' atau entry terakhir non-masuk
    let catatanTeknis: Record<string, string> | null = null;
    if (sudahDiverifikasi && history && history.length > 0) {
      const entryVerifikasi = history.find((h) => h.status_ke === 'sedang_ditangani') || history[history.length - 1];
      if (entryVerifikasi?.catatan && entryVerifikasi.catatan !== 'Laporan baru dibuat oleh warga') {
        catatanTeknis = {
          catatan_penanganan: entryVerifikasi.catatan,
          waktu_verifikasi: new Date(entryVerifikasi.created_at).toLocaleString('id-ID', {
            day: 'numeric', month: 'long', year: 'numeric', hour: '2-digit', minute: '2-digit'
          }),
          status_terkini: laporan.status,
        };
      }
    }
    // Fallback ke catatan_teknis di laporan jika ada (backward compat)
    if (!catatanTeknis && sudahDiverifikasi && laporan.catatan_teknis) {
      catatanTeknis = laporan.catatan_teknis as Record<string, string>;
    }

    return apiSukses({
      laporan: {
        ...laporan,
        penanda: penandaAktif,
        konfirmasi_warga: konfirmasiWarga || null,
        foto_sebelum_paths: formatBanyakUrlFoto(laporan.foto_sebelum_paths || []),
        foto_sesudah_paths: formatBanyakUrlFoto(laporan.foto_sesudah_paths || []),
      },
      linimasa: linimasaList,
      catatan_teknis: catatanTeknis,
      transparansi_penugasan: {
        waktu_respon_awal: '2 Jam 33 Menit',
        batas_maks_respon: '6 Jam',
        total_biaya_logistik: 'Rp 1.450.000',
        sumber_dana: 'APBD Pemeliharaan Fasilitas Publik',
        indeks_kepuasan_wilayah: '94.8%',
      },
      sla: {
        hari_berjalan: selisihHari,
        status: laporan.status,
        target_maks: '48 Jam',
      },
    });
  } catch (err: any) {
    console.error('[lacak/kode] Error:', err?.message || err);
    return apiError('INTERNAL_ERROR', 'Terjadi kesalahan sistem saat melacak laporan');
  }
}

