/**
 * src/lib/contracts/dashboard.ts
 * Skema Validasi Zod & Tipe TypeScript untuk Modul Analitik & Dashboard (Civic Insight)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { z } from 'zod';
import { ProvenanceEnum } from './common';

// Filter parameter bersama untuk seluruh endpoint analitik
export const DashboardFilterSchema = z.object({
  periode_mulai: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'Format tanggal YYYY-MM-DD').optional(),
  periode_akhir: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'Format tanggal YYYY-MM-DD').optional(),
  kategori: z.string().optional(),
  kecamatan: z.string().optional(),
  kelurahan: z.string().optional(),
  sumber: z.enum(['asli', 'simulasi', 'semua']).default('semua'),
});
export type DashboardFilter = z.infer<typeof DashboardFilterSchema>;

// Tren Bulanan
export const TrenBulananItemSchema = z.object({
  bulan: z.string(), // '2026-01-01'
  jumlah_masuk: z.number().int().nonnegative(),
  jumlah_selesai: z.number().int().nonnegative(),
  jumlah_ditolak: z.number().int().nonnegative(),
  jumlah_aktif: z.number().int().nonnegative(),
  provenance_campuran: z.boolean(),
});
export type TrenBulananItem = z.infer<typeof TrenBulananItemSchema>;

// Waktu Penanganan
export const WaktuPenangananItemSchema = z.object({
  kategori: z.string(),
  kategori_slug: z.string(),
  dinas: z.string(),
  dinas_singkatan: z.string(),
  median_hari: z.number(),
  rata_rata_hari: z.number(),
  jumlah_selesai: z.number().int(),
  jumlah_terlambat: z.number().int(),
});
export type WaktuPenangananItem = z.infer<typeof WaktuPenangananItemSchema>;

// Laporan Per Kapita (per 10.000 Penduduk)
export const PerKapitaItemSchema = z.object({
  kelurahan: z.string(),
  kelurahan_kode: z.string(),
  kecamatan: z.string(),
  jumlah_penduduk: z.number().int().nonnegative(),
  jumlah_laporan: z.number().int().nonnegative(),
  laporan_per_10k: z.number(),
  provenance_penduduk: ProvenanceEnum,
  lolos_ambang_batas: z.boolean(), // Ambang minimal 5 laporan agar peringkat valid
});
export type PerKapitaItem = z.infer<typeof PerKapitaItemSchema>;

// Konfirmasi Pelapor & Reopen Rate
export const KonfirmasiStatistikSchema = z.object({
  total_selesai: z.number().int().nonnegative(),
  total_dikonfirmasi: z.number().int().nonnegative(),
  persen_dikonfirmasi: z.number(),
  persen_puas: z.number(),
  persen_biasa: z.number(),
  persen_kurang_puas: z.number(),
  total_dibuka_ulang: z.number().int().nonnegative(),
  persen_dibuka_ulang: z.number(),
});
export type KonfirmasiStatistik = z.infer<typeof KonfirmasiStatistikSchema>;

// Umur Laporan Belum Selesai (Backlog Age)
export const UmurLaporanItemSchema = z.object({
  rentang_hari: z.string(), // '0-3 hari', '4-7 hari', dst
  jumlah: z.number().int().nonnegative(),
  jumlah_terlambat: z.number().int().nonnegative(),
});
export type UmurLaporanItem = z.infer<typeof UmurLaporanItemSchema>;

// Template Insight Deskriptif Otomatis
export const CivicInsightSchema = z.object({
  id: z.string(),
  kategori: z.enum(['tren', 'kecepatan', 'kepuasan', 'wilayah']),
  judul: z.string(),
  deskripsi: z.string(),
  tipe_penanda: z.enum(['positif', 'perhatian', 'netral']),
  sumber_terkait: z.string(),
});
export type CivicInsight = z.infer<typeof CivicInsightSchema>;

// Ringkasan Landing Page (Papan Tanggap Beranda)
export const RingkasanLandingSchema = z.object({
  laporan_bulan_ini: z.number().int(),
  laporan_selesai: z.number().int(),
  persentase_selesai: z.number(),
  sedang_dikerjakan: z.number().int(),
  rata_rata_harian: z.number(),
  kinerja_dinas: z.array(
    z.object({
      singkatan: z.string(),
      nama: z.string(),
      rata_hari: z.number(),
      persen_tuntas: z.number(),
    })
  ),
});
export type RingkasanLanding = z.infer<typeof RingkasanLandingSchema>;

