/**
 * src/app/api/petugas/laporan/[id]/upload-sesudah/route.ts
 * Endpoint Perolehan Signed URL Unggah Foto Sesudah Perbaikan (Petugas)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import { generateNamaFileAcak } from '@/lib/server/upload';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function POST(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const auth = await dapatkanKonteksAuth();
    if (!auth.isAuthenticated || (auth.role !== 'petugas' && auth.role !== 'admin')) {
      return apiError('FORBIDDEN', 'Hanya petugas atau admin yang berhak mengunggah foto sesudah');
    }

    const json = await req.json();
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
    return apiError('INTERNAL_ERROR', 'Gagal membuat URL unggah foto sesudah');
  }
}

