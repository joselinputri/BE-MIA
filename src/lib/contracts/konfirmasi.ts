/**
 * src/lib/contracts/konfirmasi.ts
 * Skema Validasi Zod & Tipe TypeScript untuk Konfirmasi Hasil Sebelum-Sesudah oleh Pelapor
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { z } from 'zod';

export const JawabanKonfirmasiEnum = z.enum(['puas', 'biasa', 'kurang_puas']);
export type JawabanKonfirmasi = z.infer<typeof JawabanKonfirmasiEnum>;

export const KonfirmasiInputSchema = z.object({
  jawaban: JawabanKonfirmasiEnum,
  rating: z.number().int().min(1).max(5).optional(),
  komentar: z.string().max(500, 'Komentar maksimal 500 karakter').optional(),
  minta_buka_ulang: z.boolean().default(false), // Jika pelapor menjawab kurang puas / belum beres
});
export type KonfirmasiInput = z.infer<typeof KonfirmasiInputSchema>;

export const DukungLaporanInputSchema = z.object({
  turnstile_token: z.string().optional(),
});
export type DukungLaporanInput = z.infer<typeof DukungLaporanInputSchema>;

