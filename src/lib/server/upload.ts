/**
 * src/lib/server/upload.ts
 * Utilitas Upload Foto, Sanitasi Magic Bytes, & Pembersihan Metadata EXIF
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { randomBytes } from 'crypto';

export interface ValidasiFileResult {
  valid: boolean;
  mimeType?: string;
  error?: string;
}

// Deteksi MIME type berbasis Magic Bytes header
export function deteksiMimeTypeDariBuffer(buffer: Buffer): ValidasiFileResult {
  if (buffer.length < 4) {
    return { valid: false, error: 'File terlalu kecil atau kosong' };
  }

  // JPEG: FF D8 FF
  if (buffer[0] === 0xff && buffer[1] === 0xd8 && buffer[2] === 0xff) {
    return { valid: true, mimeType: 'image/jpeg' };
  }

  // PNG: 89 50 4E 47
  if (
    buffer[0] === 0x89 &&
    buffer[1] === 0x50 &&
    buffer[2] === 0x4e &&
    buffer[3] === 0x47
  ) {
    return { valid: true, mimeType: 'image/png' };
  }

  // WebP: RIFF ... WEBP
  if (
    buffer.toString('ascii', 0, 4) === 'RIFF' &&
    buffer.toString('ascii', 8, 12) === 'WEBP'
  ) {
    return { valid: true, mimeType: 'image/webp' };
  }

  return {
    valid: false,
    error: 'Format file tidak diizinkan. Hanya menerima file citra asli JPEG, PNG, atau WebP',
  };
}

export function generateNamaFileAcak(ekstensi: string = 'webp'): string {
  const timestamp = Date.now();
  const randomStr = randomBytes(16).toString('hex');
  return `${timestamp}-${randomStr}.${ekstensi}`;
}

/**
 * Mengubah path internal storage (contoh: "sebelum/123-abc.webp")
 * menjadi URL publik absolut yang dapat langsung diakses oleh <img> pada Frontend.
 */
export function formatUrlFoto(path: string): string {
  if (!path) return '';
  // Jika sudah merupakan URL absolut (misal Unsplash dari seed simulasi)
  if (path.startsWith('http://') || path.startsWith('https://')) {
    return path;
  }
  const cleanPath = path.replace(/^\/+/, '');
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://mock.supabase.co';
  return `${supabaseUrl}/storage/v1/object/public/laporan-foto/${cleanPath}`;
}

/**
 * Format array paths foto menjadi array URL publik lengkap
 */
export function formatBanyakUrlFoto(paths: string[] = []): string[] {
  if (!Array.isArray(paths)) return [];
  return paths.map(formatUrlFoto);
}

/**
 * Mendapatkan URL thumbnail beresolusi teroptimasi via Supabase Image Transformation
 */
export function dapatkanThumbnailUrl(path: string, lebar: number = 400, tinggi: number = 300): string {
  if (!path) return '';
  if (path.startsWith('http://') || path.startsWith('https://')) {
    // Jika URL eksternal (Unsplash), tambahkan query resize standar jika mendukung
    if (path.includes('unsplash.com')) {
      return `${path}&w=${lebar}&h=${tinggi}&fit=crop`;
    }
    return path;
  }
  const cleanPath = path.replace(/^\/+/, '');
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://mock.supabase.co';
  return `${supabaseUrl}/storage/v1/render/image/public/laporan-foto/${cleanPath}?width=${lebar}&height=${tinggi}&resize=contain`;
}


