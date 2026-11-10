/**
 * __tests__/backend.test.ts
 * Pengujian Unit & Integrasi Logika Backend RAMPUNG
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { validasiTransisiStatus } from '../src/lib/server/state-machine.ts';
import { periksaKontenLaporan } from '../src/lib/server/sanitizer.ts';
import { periksaRateLimit } from '../src/lib/server/rate-limit.ts';
import { deteksiMimeTypeDariBuffer, generateNamaFileAcak } from '../src/lib/server/upload.ts';
import { BuatLaporanInputSchema } from '../src/lib/contracts/laporan.ts';
import { UbahStatusInputSchema } from '../src/lib/contracts/petugas.ts';

interface TestResult {
  modul: string;
  skenario: string;
  lulus: boolean;
  keterangan: string;
}

const hasilUji: TestResult[] = [];

function uji(modul: string, skenario: string, kondisi: boolean, keterangan: string) {
  hasilUji.push({ modul, skenario, lulus: kondisi, keterangan });
}

export function jalankanPengujianBackend() {
  console.log('====================================================');
  console.log('MEMULAI SUITE PENGUJIAN OTOMATIS BACKEND RAMPUNG');
  console.log('====================================================\n');

  // ---------------------------------------------------------------------------
  // 1. PENGUJIAN MESIN STATUS (STATE MACHINE)
  // ---------------------------------------------------------------------------
  // A. Warga tidak boleh mengubah status laporan langsung ke selesai
  const res1 = validasiTransisiStatus('sedang_ditangani', 'selesai', 'warga');
  uji(
    'State Machine',
    'Warga dilarang mengubah tiket ke status selesai',
    !res1.valid,
    res1.pesan
  );

  // B. Petugas mengubah sedang_ditangani -> selesai WAJIB melampirkan foto sesudah
  const res2 = validasiTransisiStatus('sedang_ditangani', 'selesai', 'petugas', 'Sudah diperbaiki', []);
  uji(
    'State Machine',
    'Penyelesaian tiket tanpa foto bukti sesudah wajib ditolak',
    !res2.valid,
    res2.pesan
  );

  // C. Petugas menolak laporan tanpa catatan alasan wajib ditolak
  const res3 = validasiTransisiStatus('masuk', 'ditolak', 'petugas', '');
  uji(
    'State Machine',
    'Penolakan tiket tanpa catatan alasan minimal 10 huruf wajib ditolak',
    !res3.valid,
    res3.pesan
  );

  // D. Pelapor warga berhak membuka ulang laporan selesai jika belum beres
  const res4 = validasiTransisiStatus('selesai', 'dibuka_ulang', 'warga');
  uji(
    'State Machine',
    'Warga diizinkan membuka ulang laporan selesai',
    res4.valid,
    'Transisi dibuka_ulang diizinkan'
  );

  // ---------------------------------------------------------------------------
  // 2. PENGUJIAN VALIDASI ZOD INPUT
  // ---------------------------------------------------------------------------
  // A. Koordinat di luar Surakarta (mis. Monas Jakarta: -6.175, 106.827) wajib ditolak
  const parseLuarSolo = BuatLaporanInputSchema.safeParse({
    judul: 'Jalan rusak parah',
    deskripsi: 'Kerusakan jalan aspal berlubang parah di tengah persimpangan jalan protokol',
    kategori_id: 'k1111111-0000-0000-0000-000000000001',
    latitude: -6.175,
    longitude: 106.827,
    foto_sebelum_paths: ['sebelum/foto1.jpg'],
  });
  uji(
    'Zod Validation',
    'Koordinat di luar bounding box Surakarta wajib ditolak',
    !parseLuarSolo.success,
    'Validasi geografis berhasil menolak koordinat Jakarta'
  );

  // B. Koordinat valid di dalam Surakarta (mis. Purwosari: -7.561, 110.803) diterima
  const parseDalamSolo = BuatLaporanInputSchema.safeParse({
    judul: 'Jalan rusak depan stasiun Purwosari',
    deskripsi: 'Kerusakan jalan aspal berlubang parah di dekat pintu keluar stasiun',
    kategori_id: 'd1111111-0000-0000-0000-000000000001',
    latitude: -7.561,
    longitude: 110.803,
    foto_sebelum_paths: ['sebelum/foto1.jpg'],
  });
  uji(
    'Zod Validation',
    'Koordinat sah di dalam Kota Surakarta diterima',
    parseDalamSolo.success,
    'Data valid diterima sistem'
  );

  // ---------------------------------------------------------------------------
  // 3. PENGUJIAN DETEKSI SPAM / RULE-BASED SANITIZER
  // ---------------------------------------------------------------------------
  const hasilSpam = periksaKontenLaporan('Promo pinjol cair cepat', 'Daftar slot gacor dana cair tanpa jaminan');
  uji(
    'Content Sanitizer',
    'Teks spam judi/pinjol otomatis ditandai perlu_verifikasi_tambahan',
    hasilSpam.perluVerifikasiTambahan && hasilSpam.penanda.includes('perlu_verifikasi_tambahan'),
    hasilSpam.alasanPenanda || 'Terdeteksi'
  );

  // ---------------------------------------------------------------------------
  // 4. PENGUJIAN RATE LIMITING
  // ---------------------------------------------------------------------------
  const testId = `test-user-${Date.now()}`;
  let rateTerblokir = false;
  for (let i = 0; i < 7; i++) {
    const cek = periksaRateLimit(testId, 'test_lapor', 5, 60);
    if (!cek.allowed) {
      rateTerblokir = true;
      break;
    }
  }
  uji(
    'Rate Limiting',
    'Permintaan di atas batas ambang (5 req) berhasil diblokir',
    rateTerblokir,
    'Rate limit 429 terpicu'
  );

  // ---------------------------------------------------------------------------
  // 5. PENGUJIAN KEAMANAN UPLOAD FOTO (MAGIC BYTES)
  // ---------------------------------------------------------------------------
  // File palsu (script PHP yang dinamai .jpg)
  const fakePhpBuffer = Buffer.from('<?php echo "evil"; ?>');
  const cekFilePalsu = deteksiMimeTypeDariBuffer(fakePhpBuffer);
  uji(
    'File Upload Security',
    'File skrip PHP palsu yang berkedok gambar ditolak berdasarkan magic bytes',
    !cekFilePalsu.valid,
    cekFilePalsu.error || 'Ditolak'
  );

  // File gambar JPEG asli (Magic bytes: FF D8 FF)
  const validJpegBuffer = Buffer.from([0xff, 0xd8, 0xff, 0xe0, 0x00, 0x10]);
  const cekFileAsli = deteksiMimeTypeDariBuffer(validJpegBuffer);
  uji(
    'File Upload Security',
    'File gambar JPEG asli diterima',
    cekFileAsli.valid && cekFileAsli.mimeType === 'image/jpeg',
    'MIME JPEG valid'
  );

  // ---------------------------------------------------------------------------
  // LAPORAN HASIL AKHIR
  // ---------------------------------------------------------------------------
  let semuaLulus = true;
  for (const item of hasilUji) {
    const icon = item.lulus ? '✅' : '❌';
    console.log(`${icon} [${item.modul}] ${item.skenario}`);
    console.log(`   Catatan: ${item.keterangan}\n`);
    if (!item.lulus) semuaLulus = false;
  }

  if (semuaLulus) {
    console.log('🎉 SELURUH PENGUJIAN UNIT & INTEGRASI KEAMANAN LULUS 100%!');
  } else {
    console.error('⚠️ TERDAPAT PENGUJIAN YANG GAGAL!');
    process.exit(1);
  }
}

jalankanPengujianBackend();
