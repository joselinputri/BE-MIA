/**
 * src/lib/contracts/petugas.ts
 * Skema Validasi Zod & Tipe TypeScript untuk Panel Petugas / Instansi
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { z } from 'zod';
import { StatusLaporanEnum } from './laporan.ts';

// Schema ubah status laporan oleh petugas
export const UbahStatusInputSchema = z.object({
  status_ke: StatusLaporanEnum,
  catatan: z.string().max(1000).optional(),
  foto_sesudah_paths: z.array(z.string().min(1)).max(3).optional(),
}).refine(
  (data) => {
    // Jika status ke ditolak, catatan wajib diisi minimal 10 karakter
    if (data.status_ke === 'ditolak') {
      return !!data.catatan && data.catatan.trim().length >= 10;
    }
    return true;
  },
  {
    message: 'Penolakan laporan wajib disertai alasan/catatan minimal 10 karakter',
    path: ['catatan'],
  }
).refine(
  (data) => {
    // Jika status ke selesai, foto bukti pengerjaan sesudah wajib disertakan
    if (data.status_ke === 'selesai') {
      return !!data.foto_sesudah_paths && data.foto_sesudah_paths.length >= 1;
    }
    return true;
  },
  {
    message: 'Penyelesaian laporan wajib menyertakan minimal 1 foto bukti sesudah perbaikan',
    path: ['foto_sesudah_paths'],
  }
);
export type UbahStatusInput = z.infer<typeof UbahStatusInputSchema>;

// Schema antrean laporan petugas
export const AntreanPetugasQuerySchema = z.object({
  status: StatusLaporanEnum.optional(),
  prioritas: z.enum(['semua', 'terlambat', 'perlu_verifikasi']).default('semua'),
  cursor: z.string().optional(),
  limit: z.coerce.number().int().min(1).max(50).default(20),
});
export type AntreanPetugasQuery = z.infer<typeof AntreanPetugasQuerySchema>;
