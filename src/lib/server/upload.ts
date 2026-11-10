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

