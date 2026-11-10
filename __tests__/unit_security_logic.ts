/**
 * __tests__/unit_security_logic.ts
 * Pengujian Unit Zero-Dependency Logika Kritis Backend & Keamanan
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { validasiTransisiStatus } from '../src/lib/server/state-machine.ts';
import { periksaKontenLaporan } from '../src/lib/server/sanitizer.ts';
import { periksaRateLimit, hashIP } from '../src/lib/server/rate-limit.ts';
import { deteksiMimeTypeDariBuffer, generateNamaFileAcak } from '../src/lib/server/upload.ts';

interface TestItem {
  kategori: string;
  nama: string;
  lulus: boolean;
  keterangan: string;
}

const hasil: TestItem[] = [];

function uji(kategori: string, nama: string, kondisi: boolean, keterangan: string) {
  hasil.push({ kategori, nama, lulus: kondisi, keterangan });
}

console.log('====================================================');
console.log('PENGUJIAN KEAMANAN & LOGIKA BACKEND RAMPUNG (ZERO-DEP)');
console.log('====================================================\n');

// 1. STATE MACHINE
// Skenario A: Warga mencoba bypass ubah status sendiri ke selesai -> DITOLAK
const r1 = validasiTransisiStatus('sedang_ditangani', 'selesai', 'warga');
uji('State Machine', 'Warga dilarang mengubah status tiket ke "selesai"', !r1.valid, r1.pesan);

// Skenario B: Petugas menyelesaikan tanpa foto sesudah -> DITOLAK
const r2 = validasiTransisiStatus('sedang_ditangani', 'selesai', 'petugas', 'Sudah dikerjakan', []);
uji('State Machine', 'Penyelesaian tanpa foto bukti sesudah wajib ditolak', !r2.valid, r2.pesan);

// Skenario C: Petugas menyelesaikan DENGAN foto sesudah -> DITERIMA
const r3 = validasiTransisiStatus('sedang_ditangani', 'selesai', 'petugas', 'Pekerjaan tuntas', ['foto_sesudah.jpg']);
uji('State Machine', 'Penyelesaian dengan foto bukti sesudah diterima', r3.valid, 'OK');

// Skenario D: Petugas menolak tanpa alasan -> DITOLAK
const r4 = validasiTransisiStatus('masuk', 'ditolak', 'petugas', '');
uji('State Machine', 'Penolakan tanpa catatan alasan minimal 10 huruf ditolak', !r4.valid, r4.pesan);

// Skenario E: Pelapor warga membuka kembali tiket selesai (audit gotong royong) -> DITERIMA
const r5 = validasiTransisiStatus('selesai', 'dibuka_ulang', 'warga');
uji('State Machine', 'Warga berhak membuka ulang laporan selesai yang belum beres', r5.valid, 'OK');

// 2. SPAM & CONTENT SANITIZER (BEBAS ReDoS)
const s1 = periksaKontenLaporan('Promo pinjol cair', 'Ayo main slot gacor deposit cepat tanpa jaminan');
uji(
  'Content Sanitizer',
  'Kata kunci spam judi & pinjol ditandai "perlu_verifikasi_tambahan"',
  s1.perluVerifikasiTambahan && s1.penanda.includes('perlu_verifikasi_tambahan'),
  s1.alasanPenanda || ''
);

const s2 = periksaKontenLaporan('Jalan berlubang depan pasar', 'Mohon segera diperbaiki karena sering ada motor terjatuh saat hujan');
uji(
  'Content Sanitizer',
  'Laporan wajar tidak ditandai spam',
  !s2.perluVerifikasiTambahan && s2.penanda.length === 0,
  'Laporan bersih'
);

// 3. RATE LIMITER
const testId = `ip_${Date.now()}`;
let terblokir = false;
for (let i = 0; i < 6; i++) {
  const check = periksaRateLimit(testId, 'test_limit', 5, 60);
  if (!check.allowed) {
    terblokir = true;
    break;
  }
}
uji('Rate Limiter', 'Permintaan melampaui limit (5/menit) otomatis diblokir', terblokir, 'Rate limit 429 aktif');

// 4. FILE UPLOAD SECURITY (MAGIC BYTES)
// File palsu (PHP web shell)
const fakePhp = Buffer.from('<?php system($_GET["c"]); ?>');
const f1 = deteksiMimeTypeDariBuffer(fakePhp);
uji('Upload Security', 'File executable/PHP palsu ditolak berbasis Magic Bytes', !f1.valid, f1.error || '');

// File asli JPEG (FF D8 FF)
const validJpeg = Buffer.from([0xff, 0xd8, 0xff, 0xe0, 0x00, 0x10]);
const f2 = deteksiMimeTypeDariBuffer(validJpeg);
uji('Upload Security', 'File JPEG asli dengan magic bytes FF D8 FF diterima', f2.valid && f2.mimeType === 'image/jpeg', 'Valid JPEG');

// File acak nama unik
const randomName = generateNamaFileAcak('webp');
uji('Upload Security', 'Nama file diacak kriptografis dengan timestamp & hex random', randomName.endsWith('.webp') && randomName.length > 20, randomName);

// 5. BOUNDING BOX SURAKARTA VALIDATION
function cekKoordinatSurakarta(lat: number, lon: number): boolean {
  return lat >= -7.60 && lat <= -7.52 && lon >= 110.77 && lon <= 110.87;
}

uji('Geospasial', 'Koordinat di dalam Kota Surakarta (Purwosari) lolos validasi', cekKoordinatSurakarta(-7.561, 110.803), 'Valid');
uji('Geospasial', 'Koordinat di luar wilayah (Jakarta / Monas) ditolak', !cekKoordinatSurakarta(-6.175, 106.827), 'Ditolak');

// Tampilkan Rangkuman
let allPassed = true;
for (const item of hasil) {
  const icon = item.lulus ? '✅' : '❌';
  console.log(`${icon} [${item.kategori}] ${item.nama}`);
  console.log(`   Keterangan: ${item.keterangan}\n`);
  if (!item.lulus) allPassed = false;
}

if (allPassed) {
  console.log('🎉 SEMUA PENGUJIAN LOGIKA KEAMANAN BACKEND LULUS 100%!');
} else {
  console.error('⚠️ ADA PENGUJIAN YANG GAGAL!');
  process.exit(1);
}

