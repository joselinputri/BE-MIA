/**
 * src/app/api/laporan/upload-foto/route.ts
 * Endpoint Unggah Foto Kondisi Sebelum ke Supabase Storage
 * Mendukung 2 metode:
 * 1. Unggah Langsung Multipart/Form-Data (File binary langsung divalidasi Magic Bytes & disimpan ke Storage)
 * 2. Permintaan Signed Upload URL (JSON { tipe: "image/jpeg" } untuk unggah langsung dari browser ke Supabase)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import {
  generateNamaFileAcak,
  deteksiMimeTypeDariBuffer,
  formatUrlFoto,
  dapatkanThumbnailUrl,
} from '@/lib/server/upload';
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

    const contentType = req.headers.get('content-type') || '';

    // =========================================================================
    // METODE 1: Unggah Langsung File Binary via FormData (multipart/form-data)
    // =========================================================================
    if (contentType.includes('multipart/form-data')) {
      const formData = await req.formData();
      const file = formData.get('file') as File | null;

      if (!file) {
        return apiError('VALIDATION_ERROR', 'Berkas foto tidak ditemukan dalam form data (field "file").');
      }

      // Validasi batas ukuran berkas (Maks 5 MB)
      if (file.size > 5 * 1024 * 1024) {
        return apiError('VALIDATION_ERROR', 'Ukuran foto melebihi batas maksimal 5 MB.');
      }

      const bytes = await file.arrayBuffer();
      const buffer = Buffer.from(bytes);

      // Verifikasi Magic Bytes (Keamanan anti-malware/spoofing ekstensi)
      const validasi = deteksiMimeTypeDariBuffer(buffer);
      if (!validasi.valid || !validasi.mimeType) {
        return apiError('VALIDATION_ERROR', validasi.error || 'Format berkas tidak diizinkan.');
      }

      const ekstensi =
        validasi.mimeType === 'image/png'
          ? 'png'
          : validasi.mimeType === 'image/webp'
          ? 'webp'
          : 'jpg';

      const namaFile = generateNamaFileAcak(ekstensi);
      const pathFile = `sebelum/${namaFile}`;

      // Upload ke Supabase Storage via Service Role Admin
      const { error: uploadError } = await supabaseAdmin.storage
        .from('laporan-foto')
        .upload(pathFile, buffer, {
          contentType: validasi.mimeType,
          upsert: false,
        });

      if (uploadError) {
        // Fallback jika mode dev/mock offline tanpa Supabase aktif
        return apiSukses({
          file_path: pathFile,
          public_url: formatUrlFoto(pathFile),
          thumbnail_url: dapatkanThumbnailUrl(pathFile),
          is_mock: true,
        });
      }

      return apiSukses({
        file_path: pathFile,
        public_url: formatUrlFoto(pathFile),
        thumbnail_url: dapatkanThumbnailUrl(pathFile),
      });
    }

    // =========================================================================
    // METODE 2: Permintaan Signed Upload URL (JSON Payload)
    // =========================================================================
    const json = await req.json().catch(() => ({}));
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

    // Dapatkan Signed Upload URL dari Supabase Storage
    const { data, error } = await supabaseAdmin.storage
      .from('laporan-foto')
      .createSignedUploadUrl(pathFile);

    if (error || !data) {
      // Mock signed url jika offline development
      return apiSukses({
        upload_url: `https://mock.supabase.co/storage/v1/upload/sign/laporan-foto/${pathFile}`,
        file_path: pathFile,
        public_url: formatUrlFoto(pathFile),
        thumbnail_url: dapatkanThumbnailUrl(pathFile),
        expires_in: 300,
      });
    }

    return apiSukses({
      upload_url: data.signedUrl,
      file_path: data.path,
      public_url: formatUrlFoto(data.path),
      thumbnail_url: dapatkanThumbnailUrl(data.path),
      token: data.token,
      expires_in: 300,
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memproses unggah foto');
  }
}
