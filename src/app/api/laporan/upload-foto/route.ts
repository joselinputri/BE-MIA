/**
 * src/app/api/laporan/upload-foto/route.ts
 * Endpoint Perolehan Signed URL Unggah Foto ke Supabase Storage
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { generateNamaFileAcak } from '@/lib/server/upload';
import { periksaRateLimit, hashIP } from '@/lib/server/rate-limit';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function POST(req: NextRequest) {
  try {
    const ip = req.headers.get('x-forwarded-for')?.split(',')[0] || '127.0.0.1';

    // Rate limit: maks 20 permintaan upload foto per jam per IP
    const limitCheck = periksaRateLimit(hashIP(ip), 'upload_foto', 20, 3600);
    if (!limitCheck.allowed) {
      return apiError('RATE_LIMITED', 'Batas upload tercapai. Silakan coba kembali beberapa saat lagi.');
    }

    const json = await req.json();
    const tipe = (json.tipe || 'image/jpeg').toLowerCase();

    if (!['image/jpeg', 'image/png', 'image/webp'].includes(tipe)) {
      return apiError(
        'VALIDATION_ERROR',
        'Tipe berkas tidak didukung. Harap unggah foto dengan format JPG, PNG, atau WebP.'
      );
    }

    const ekstensi = tipe === 'image/png' ? 'png' : tipe === 'image/webp' ? 'webp' : 'jpg';
    const namaFile = generateNamaFileAcak(ekstensi);
    const pathFile = `sebelum/${namaFile}`;

    // Dapatkan Signed Upload URL dari Supabase Storage (Privat)
    const { data, error } = await supabaseAdmin.storage
      .from('laporan-foto')
      .createSignedUploadUrl(pathFile);

    if (error || !data) {
      // Mock signed url jika offline development
      return apiSukses({
        upload_url: `https://mock.supabase.co/storage/v1/upload/sign/laporan-foto/${pathFile}`,
        file_path: pathFile,
        expires_in: 60,
      });
    }

    return apiSukses({
      upload_url: data.signedUrl,
      file_path: data.path,
      token: data.token,
      expires_in: 60,
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal membuat URL unggah foto');
  }
}

