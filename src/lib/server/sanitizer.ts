/**
 * src/lib/server/sanitizer.ts
 * Lapisan Validasi Konten Rule-Based & Deteksi Spam Bebas ReDoS
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 * 
 * Prinsip:
 * 1. Hanya memberi penanda 'perlu_verifikasi_tambahan' dan saran perbaikan.
 * 2. TIDAK PERNAH menghapus atau menolak laporan secara otomatis.
 * 3. Menggunakan pencocokan string O(N) linier sederhana, bukan regex bersarang rawan ReDoS.
 */

export type PenandaLaporan = 'perlu_verifikasi_tambahan';

// Daftar kata kunci terlarang (spam, promosi komersial, judi, pinjol)
const KATA_KUNCI_SPAM: string[] = [
  'slot',
  'gacor',
  'judi',
  'togel',
  'casino',
  'poker',
  'pinjol',
  'dana cair',
  'tanpa jaminan',
  'bunga rendah',
  'promo diskon',
  'wa.me/',
  'bit.ly/',
  't.me/',
];

export interface HasilValidasiKonten {
  perluVerifikasiTambahan: boolean;
  penanda: PenandaLaporan[];
  alasanPenanda?: string;
  saranPerbaikan: string[];
}

export function periksaKontenLaporan(
  judul: string,
  deskripsi: string
): HasilValidasiKonten {
  const gabunganTeks = `${judul} ${deskripsi}`.toLowerCase();
  const penanda: PenandaLaporan[] = [];
  const saranPerbaikan: string[] = [];
  let perluVerifikasiTambahan = false;
  let alasanPenanda: string | undefined;

  // 1. Cek kata kunci spam / judi / pinjol
  for (const keyword of KATA_KUNCI_SPAM) {
    if (gabunganTeks.includes(keyword)) {
      perluVerifikasiTambahan = true;
      penanda.push('perlu_verifikasi_tambahan');
      alasanPenanda = `Terdeteksi indikasi kata kunci komersial/spam: "${keyword}"`;
      break;
    }
  }

  // 2. Evaluasi kelengkapan teks untuk saran perbaikan kepada pelapor
  if (deskripsi.trim().length < 50) {
    saranPerbaikan.push('Deskripsi cukup singkat. Anda dapat menambahkan patokan bangunan terdekat atau kronologi kejadian agar memudahkan petugas.');
  }

  // Cek apakah ada penyebutan petunjuk arah atau patokan
  const adaPetunjuk = ['depan', 'sebelah', 'dekat', 'gang', 'rt', 'rw', 'samping', 'seberang'].some((w) =>
    gabunganTeks.includes(w)
  );
  if (!adaPetunjuk) {
    saranPerbaikan.push('Disarankan menambahkan patokan lokasi (mis. "depan toko X" atau "sebelah gapura RT 02") agar petugas cepat menemukan titik kerusakan.');
  }

  return {
    perluVerifikasiTambahan,
    penanda,
    alasanPenanda,
    saranPerbaikan,
  };
}
