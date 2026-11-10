/**
 * src/lib/contracts/laporan.ts
 * Skema Validasi Zod & Tipe TypeScript untuk Modul Pelaporan Warga
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { z } from 'zod';
import { ProvenanceEnum } from './common.ts';

// Bounding box geografis Kota Surakarta
const SURAKARTA_BOUNDS = {
  minLon: 110.77,
  maxLon: 110.87,
  minLat: -7.60,
  maxLat: -7.52,
};

export const StatusLaporanEnum = z.enum([
  'masuk',
  'ditinjau',
  'sedang_ditangani',
  'selesai',
  'ditolak',
  'dibuka_ulang',
]);
export type StatusLaporan = z.infer<typeof StatusLaporanEnum>;

export const PenandaLaporanEnum = z.enum(['perlu_verifikasi_tambahan']);
export type PenandaLaporan = z.infer<typeof PenandaLaporanEnum>;

// Schema input pembuatan laporan baru
export const BuatLaporanInputSchema = z.object({
  judul: z
    .string()
    .min(5, 'Judul laporan minimal 5 karakter')
    .max(200, 'Judul laporan maksimal 200 karakter')
    .trim(),
  deskripsi: z
    .string()
    .min(20, 'Deskripsi laporan minimal 20 karakter agar jelas bagi petugas')
    .max(2000, 'Deskripsi laporan maksimal 2000 karakter')
    .trim(),
  kategori_id: z.string().uuid('ID Kategori tidak valid'),
  kelurahan_id: z.string().uuid('ID Kelurahan tidak valid').optional(),
  latitude: z
    .number()
    .min(SURAKARTA_BOUNDS.minLat, 'Lokasi berada di luar batas selatan Kota Surakarta (-7.60)')
    .max(SURAKARTA_BOUNDS.maxLat, 'Lokasi berada di luar batas utara Kota Surakarta (-7.52)'),
  longitude: z
    .number()
    .min(SURAKARTA_BOUNDS.minLon, 'Lokasi berada di luar batas barat Kota Surakarta (110.77)')
    .max(SURAKARTA_BOUNDS.maxLon, 'Lokasi berada di luar batas timur Kota Surakarta (110.87)'),
  foto_sebelum_paths: z
    .array(z.string().min(1))
    .min(1, 'Minimal sertakan 1 foto bukti kondisi sebelum perbaikan')
    .max(3, 'Maksimal 3 foto'),
  is_anonim: z.boolean().default(false),
  nama_pelapor: z.string().max(100).optional(),
  email_pelapor: z.string().email('Format email tidak valid').optional(),
  telepon_pelapor: z.string().max(20).optional(),
  turnstile_token: z.string().optional(), // Token validasi Cloudflare Turnstile untuk pelapor anonim
  honeypot: z.string().max(0, 'Bot detected').optional(), // Kolom perangkap spam (harus kosong)
});
export type BuatLaporanInput = z.infer<typeof BuatLaporanInputSchema>;

// Schema respons laporan publik (bebas PII)
export const LaporanPublikItemSchema = z.object({
  id: z.string().uuid(),
  kode_lacak: z.string(),
  judul: z.string(),
  deskripsi: z.string(),
  kategori: z.string(),
  kategori_slug: z.string(),
  kategori_ikon: z.string().nullable().optional(),
  kelurahan: z.string().nullable(),
  kelurahan_kode: z.string().nullable(),
  kecamatan: z.string().nullable(),
  kecamatan_kode: z.string().nullable(),
  latitude: z.number(),
  longitude: z.number(),
  status: StatusLaporanEnum,
  penanda: z.array(PenandaLaporanEnum),
  foto_sebelum_paths: z.array(z.string()),
  foto_sesudah_paths: z.array(z.string()).optional(),
  is_anonim: z.boolean(),
  is_simulasi: z.boolean(),
  provenance: ProvenanceEnum,
  dinas: z.string(),
  dinas_singkatan: z.string(),
  jumlah_dukungan: z.number().int().default(0),
  status_diperbarui_at: z.string().nullable().optional(),
  konfirmasi_jawaban: z.string().nullable().optional(),
  created_at: z.string(),
  updated_at: z.string(),
});
export type LaporanPublikItem = z.infer<typeof LaporanPublikItemSchema>;

// Schema query pencarian laporan serupa
export const LaporanSerupaQuerySchema = z.object({
  kategori_id: z.string().uuid('Kategori ID harus valid'),
  latitude: z.coerce.number(),
  longitude: z.coerce.number(),
  radius_meter: z.coerce.number().min(50).max(2000).default(500),
  maks: z.coerce.number().min(1).max(10).default(5),
});
export type LaporanSerupaQuery = z.infer<typeof LaporanSerupaQuerySchema>;

// Schema query filter laporan publik
export const LaporanPublikFilterSchema = z.object({
  kategori: z.string().optional(),
  kecamatan: z.string().optional(),
  kelurahan: z.string().optional(),
  status: StatusLaporanEnum.optional(),
  sumber: z.enum(['asli', 'simulasi', 'semua']).default('semua'),
  pencarian: z.string().max(100).optional(),
  cursor: z.string().optional(),
  limit: z.coerce.number().int().min(1).max(50).default(20),
  fields: z.enum(['ringkas', 'lengkap']).default('lengkap'),
});
export type LaporanPublikFilter = z.infer<typeof LaporanPublikFilterSchema>;
