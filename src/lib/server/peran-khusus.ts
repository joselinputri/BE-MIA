/**
 * src/lib/server/peran-khusus.ts
 * Whitelist Email Khusus Administrator & Petugas
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

export const ADMIN_EMAILS = [
  'admin@surakarta.go.id',
  'admin.rampung@surakarta.go.id',
  'renereneen@gmail.com',
  'jose.surakarta13@gmail.com',
  'josesurakarta13@gmail.com',
  'jose@surakarta13.com',
  'jose@surakarta.go.id',
];

export const PETUGAS_EMAILS = [
  'petugas@surakarta.go.id',
  'petugas.rampung@surakarta.go.id',
  'dpupr@surakarta.go.id',
  'dishub@surakarta.go.id',
  'dlh@surakarta.go.id',
];

/**
 * Cek peran akun secara ketat berbasis email
 */
export function tentukanPeranDariEmail(email?: string | null): 'warga' | 'petugas' | 'admin' {
  if (!email) return 'warga';
  const cleanEmail = email.trim().toLowerCase();

  // 1. Whitelist Administrator
  if (ADMIN_EMAILS.includes(cleanEmail)) return 'admin';

  // 2. Whitelist Petugas Lapangan
  if (PETUGAS_EMAILS.includes(cleanEmail)) return 'petugas';

  // Selain email khusus di atas, seluruh pendaftar murni sebagai warga
  return 'warga';
}
