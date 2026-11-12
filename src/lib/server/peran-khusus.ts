/**
 * src/lib/server/peran-khusus.ts
 * Whitelist Email & Kode Khusus untuk Petugas Lapangan & Administrator
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

export const ADMIN_EMAILS = [
  'admin@surakarta.go.id',
  'admin.rampung@surakarta.go.id',
  'renereneen@gmail.com', // Akun pengembang / penguji utama
];

export const PETUGAS_EMAILS = [
  'petugas@surakarta.go.id',
  'dpupr@surakarta.go.id',
  'dishub@surakarta.go.id',
  'dlh@surakarta.go.id',
];

/**
 * Cek peran otomatis berbasis pola email
 * Mendukung kode unik untuk tim juri/penguji:
 * - Email berakhiran atau mengandung "+admin" atau "+petugas"
 *   Contoh: juri+admin@gmail.com, rampung.admin@gmail.com -> 'admin'
 *   Contoh: juri+petugas@gmail.com, rampung.petugas@gmail.com -> 'petugas'
 * - Domain resmi instansi (@surakarta.go.id)
 */
export function tentukanPeranDariEmail(email?: string | null): 'warga' | 'petugas' | 'admin' {
  if (!email) return 'warga';
  const cleanEmail = email.trim().toLowerCase();

  // 1. Whitelist eksplisit
  if (ADMIN_EMAILS.includes(cleanEmail)) return 'admin';
  if (PETUGAS_EMAILS.includes(cleanEmail)) return 'petugas';

  // 2. Kode unik penilai/juri (kemudahan demo kompetisi)
  // Contoh: admin-juri@..., *admin*@surakarta.go.id, *+admin*@gmail.com
  if (cleanEmail.includes('+admin') || cleanEmail.startsWith('admin.') || cleanEmail.startsWith('admin_') || cleanEmail.startsWith('admin-')) {
    return 'admin';
  }
  if (cleanEmail.includes('+petugas') || cleanEmail.startsWith('petugas.') || cleanEmail.startsWith('petugas_') || cleanEmail.startsWith('petugas-')) {
    return 'petugas';
  }

  return 'warga';
}
