/**
 * src/app/api/petugas/laporan/[id]/upload-sesudah/route.ts
 * Endpoint Unggah Foto Bukti Penanganan (Sesudah) ke Supabase Storage (Petugas/Admin)
 * Mendukung 2 metode:
 * 1. Unggah Langsung Multipart/Form-Data (File binary langsung divalidasi Magic Bytes & disimpan ke Storage)
 * 2. Permintaan Signed Upload URL (JSON { tipe: "image/jpeg" })
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import {
  generateNamaFileAcak,
  deteksiMimeTypeDariBuffer,
  formatUrlFoto,
  dapatkanThumbnailUrl,
} from '@/lib/server/upload';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function POST(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
    const { id: _laporanId } = await params;
  try {
    const authHeader = req.headers.get('authorization') || undefined;
    const auth = await dapatkanKonteksAuth(authHeader);
    if (!auth.isAuthenticated || (auth.role !== 'petugas' && auth.role !== 'admin')) {
      return apiError('FORBIDDEN', 'Hanya petugas atau admin yang berhak mengunggah foto sesudah');
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

      if (file.size > 5 * 1024 * 1024) {
        return apiError('VALIDATION_ERROR', 'Ukuran foto melebihi batas maksimal 5 MB.');
      }

      const bytes = await file.arrayBuffer();
      const buffer = Buffer.from(bytes);

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
      const pathFile = `sesudah/${namaFile}`;

      const { error: uploadError } = await supabaseAdmin.storage
        .from('laporan-foto')
        .upload(pathFile, buffer, {
          contentType: validasi.mimeType,
          upsert: false,
        });

      if (uploadError) {
        console.error('[upload-sesudah] Storage upload error:', uploadError.message);
        return apiError('INTERNAL_ERROR', 'Gagal mengunggah foto ke storage. Pastikan bucket laporan-foto sudah dibuat.');
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
      return apiError('VALIDATION_ERROR', 'Format file tidak didukung');
    }

    const ekstensi = tipe === 'image/png' ? 'png' : tipe === 'image/webp' ? 'webp' : 'jpg';
    const namaFile = generateNamaFileAcak(ekstensi);
    const pathFile = `sesudah/${namaFile}`;

    const { data, error } = await supabaseAdmin.storage
      .from('laporan-foto')
      .createSignedUploadUrl(pathFile);

    if (error || !data) {
      console.error('[upload-sesudah] Signed URL error:', error?.message);
      return apiError('INTERNAL_ERROR', 'Gagal membuat URL upload bertandatangan. Pastikan Supabase Storage sudah aktif.');
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
    console.error('[upload-sesudah] Error:', err?.message || err);
    return apiError('INTERNAL_ERROR', 'Gagal memproses unggah foto sesudah');
  }
}
