/**
 * src/app/api/laporan/route.ts
 * Endpoint Pembuatan Laporan Baru (Anonim & Bernama)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { BuatLaporanInputSchema } from '@/lib/contracts/laporan';
import { apiSukses, apiError } from '@/lib/server/response';
import { evaluasiLaporanCerdas } from '@/lib/server/sanitizer';
import { periksaRateLimit, hashIP } from '@/lib/server/rate-limit';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import { supabaseAdmin, isSupabaseConfigured } from '@/lib/server/supabase-admin';
import { randomBytes } from 'crypto';

function buatKodeLacakKriptografis(): string {
  const tahun = new Date().getFullYear();
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  const bytes = randomBytes(4);
  let randomPart = '';
  for (let i = 0; i < 4; i++) {
    randomPart += chars[bytes[i] % chars.length];
  }
  // Format sesuai UI/UX RAMPUNG: RMP-2026-XXXX (misal: RMP-2026-A7X9)
  return `RMP-${tahun}-${randomPart}`;
}

export async function POST(req: NextRequest) {
  try {
    // Guard: Cek apakah Supabase service role key sudah dikonfigurasi
    if (!isSupabaseConfigured()) {
      return apiError(
        'SERVICE_UNAVAILABLE',
        'Layanan penyimpanan laporan belum aktif. Administrator perlu mengisi SUPABASE_SERVICE_ROLE_KEY di .env.local.'
      );
    }

    const ip = req.headers.get('x-forwarded-for')?.split(',')[0] || '127.0.0.1';
    const auth = await dapatkanKonteksAuth(req.headers.get('authorization') || undefined);

    // 1. Rate Limiting: 5 laporan/jam untuk IP anonim, 10/jam untuk user login
    const maxLimit = auth.isAuthenticated ? 10 : 5;
    const identifier = auth.userId || hashIP(ip);
    const limitCheck = periksaRateLimit(identifier, 'lapor', maxLimit, 3600);

    if (!limitCheck.allowed) {
      return apiError(
        'RATE_LIMITED',
        `Batas pelaporan tercapai. Anda dapat mengirim laporan kembali dalam ${Math.ceil(limitCheck.resetSeconds / 60)} menit.`
      );
    }

    const json = await req.json();

    // 2. Proteksi Honeypot (Anti-bot otomatis)
    if (json.honeypot && json.honeypot.length > 0) {
      return apiError('VALIDATION_ERROR', 'Permintaan ditolak oleh sistem keamanan.');
    }

    // 3. Validasi skema Zod
    const parsed = BuatLaporanInputSchema.safeParse(json);
    if (!parsed.success) {
      return apiError(
        'VALIDATION_ERROR',
        parsed.error.errors[0]?.message || 'Input data laporan tidak valid',
        parsed.error.format()
      );
    }

    const data = parsed.data;

    // 3b. Validasi Token Anti-Bot (Cloudflare Turnstile) untuk pelapor anonim
    if (process.env.TURNSTILE_SECRET_KEY && !auth.isAuthenticated) {
      if (!data.turnstile_token) {
        return apiError('VALIDATION_ERROR', 'Verifikasi anti-bot Turnstile wajib disertakan untuk pelaporan.');
      }
      try {
        const turnstileBody = new URLSearchParams();
        turnstileBody.append('secret', process.env.TURNSTILE_SECRET_KEY);
        turnstileBody.append('response', data.turnstile_token);
        turnstileBody.append('remoteip', ip);

        const turnstileRes = await fetch('https://challenges.cloudflare.com/turnstile/v0/siteverify', {
          method: 'POST',
          body: turnstileBody,
        });
        const turnstileJson = await turnstileRes.json();
        if (!turnstileJson.success) {
          return apiError('VALIDATION_ERROR', 'Verifikasi anti-bot gagal atau token kedaluwarsa.');
        }
      } catch (tErr) {
        // Fallback gracefully jika koneksi Turnstile offline
      }
    }

    // 4. Lapisan Validasi Cerdas (Rule-Based + AI Generatif Fallback)
    const validasiKonten = await evaluasiLaporanCerdas(data.judul, data.deskripsi);

    // 5. Lookup dinas_id dari kategori_id
    const { data: kategoriData, error: errKat } = await supabaseAdmin
      .from('kategori')
      .select('id, dinas_id')
      .eq('id', data.kategori_id)
      .single();

    if (errKat || !kategoriData) {
      return apiError('NOT_FOUND', 'Kategori aduan yang dipilih tidak ditemukan');
    }

    const kodeLacak = buatKodeLacakKriptografis();

    // 6. Simpan Laporan Utama
    const { data: laporanBaru, error: errLaporan } = await supabaseAdmin
      .from('laporan')
      .insert({
        kode_lacak: kodeLacak,
        judul: data.judul,
        deskripsi: data.deskripsi,
        kategori_id: data.kategori_id,
        kelurahan_id: data.kelurahan_id || null,
        koordinat: `SRID=4326;POINT(${data.longitude} ${data.latitude})`,
        dinas_id: kategoriData.dinas_id,
        foto_sebelum_paths: data.foto_sebelum_paths,
        is_anonim: data.is_anonim,
        pelapor_id: data.is_anonim ? null : auth.userId,
        penanda: validasiKonten.penanda,
        provenance: 'asli',
      })
      .select('id, kode_lacak, status, created_at')
      .single();

    if (errLaporan || !laporanBaru) {
      console.error('[laporan POST] DB insert error:', errLaporan?.message, errLaporan?.details, errLaporan?.hint);
      return apiError('INTERNAL_ERROR', 'Gagal menyimpan laporan ke database. Periksa koneksi Supabase dan konfigurasi service role key.');
    }

    // 7. Simpan Kontak Pelapor (Terpisah secara ketat di tabel kontak_pelapor)
    if (data.email_pelapor || data.telepon_pelapor) {
      await supabaseAdmin.from('kontak_pelapor').insert({
        laporan_id: laporanBaru.id,
        user_id: auth.userId,
        email: data.email_pelapor || null,
        telepon: data.telepon_pelapor || null,
        preferensi_notif: data.email_pelapor ? 'email' : 'in_app',
      });
    }

    // 8. Catat status history awal
    await supabaseAdmin.from('status_history').insert({
      laporan_id: laporanBaru.id,
      status_dari: null,
      status_ke: 'masuk',
      catatan: validasiKonten.alasanPenanda || 'Laporan baru dibuat oleh warga',
    });

    return apiSukses(
      {
        id: laporanBaru.id,
        kode_lacak: laporanBaru.kode_lacak,
        status: laporanBaru.status,
        penanda: validasiKonten.penanda,
        saran_perbaikan: validasiKonten.saranPerbaikan,
        created_at: laporanBaru.created_at,
      },
      undefined,
      201
    );
  } catch (error: any) {
    console.error('ERROR LAPORAN POST:', error);
    return apiError('INTERNAL_ERROR', error?.message || 'Terjadi kesalahan sistem saat memproses laporan');
  }
}

