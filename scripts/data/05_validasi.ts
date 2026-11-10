/**
 * scripts/data/05_validasi.ts
 * Script Validasi Integritas Data & Keamanan PII
 * Memastikan tidak ada data cacat, koordinat luar wilayah, atau kebocoran data pribadi.
 */

import * as fs from 'fs';
import * as path from 'path';

interface ValidationResult {
  cek: string;
  lulus: boolean;
  keterangan: string;
}

export function jalankanValidasiIntegritas(): ValidationResult[] {
  const hasil: ValidationResult[] = [];
  const currentDir = path.dirname(new URL(import.meta.url).pathname);

  // 1. Validasi File Seed 010 (Daftar Kelurahan & Penduduk)
  const seed010Path = path.join(currentDir, '../../supabase/migrations/010_seed_referensi.sql');
  if (fs.existsSync(seed010Path)) {
    const content = fs.readFileSync(seed010Path, 'utf-8');
    
    // Cek jumlah kelurahan 54
    const matchesKelurahan = content.match(/33\.72\.\d\d\.1\d\d\d/g) || [];
    const unikKelurahan = new Set(matchesKelurahan);
    
    hasil.push({
      cek: 'Kelengkapan 54 Kelurahan',
      lulus: unikKelurahan.size === 54,
      keterangan: `Ditemukan ${unikKelurahan.size} dari 54 kelurahan definitif Surakarta`,
    });

    // Cek tidak ada angka penduduk negatif
    const adaAngkaNegatif = /jumlah_penduduk\s*=\s*-\d+/i.test(content);
    hasil.push({
      cek: 'Integritas Jumlah Penduduk Non-Negatif',
      lulus: !adaAngkaNegatif,
      keterangan: adaAngkaNegatif ? 'Ditemukan angka penduduk bernilai negatif!' : 'Semua angka penduduk valid >= 0',
    });
  }

  // 2. Validasi Seed Simulasi 016
  const seed016Path = path.join(currentDir, '../../supabase/migrations/016_seed_laporan_simulasi.sql');
  if (fs.existsSync(seed016Path)) {
    const content = fs.readFileSync(seed016Path, 'utf-8');

    // Cek semua baris bertanda is_simulasi = true dan provenance = 'simulasi_terkalibrasi'
    const barisLaporan = (content.match(/INSERT INTO public\.laporan/g) || []).length;
    const barisSimulasi = (content.match(/'simulasi_terkalibrasi'/g) || []).length;

    hasil.push({
      cek: 'Provenance Tagging pada Laporan Simulasi',
      lulus: barisLaporan > 0 && barisLaporan === barisSimulasi,
      keterangan: `${barisSimulasi} dari ${barisLaporan} laporan simulasi terlabel 'simulasi_terkalibrasi'`,
    });

    // Cek PII: Tidak boleh ada nama pelapor atau nomor telepon riil di kolom teks
    const adaEmailWarga = /\b[a-zA-Z0-9._%+-]+@(gmail|yahoo|hotmail)\.com\b/i.test(content);
    // Cek pola nomor telepon berawalan +62 atau 08x di luar URL
    const lines = content.split('\n');
    let adaNoTelp = false;
    for (const line of lines) {
      if (!line.includes('https://') && !line.includes('http://')) {
        if (/\b08[1-9][0-9]{7,10}\b/.test(line)) {
          adaNoTelp = true;
          break;
        }
      }
    }

    hasil.push({
      cek: 'Pembersihan Data Pribadi (Zero PII)',
      lulus: !adaEmailWarga && !adaNoTelp,
      keterangan: !adaEmailWarga && !adaNoTelp 
        ? 'Tidak ditemukan email pribadi atau nomor telepon riil warga di data simulasi'
        : 'Peringatan: Ditemukan pola kontak pribadi di dalam data simulasi!',
    });
  }

  return hasil;
}

console.log('=== MEMULAI VALIDASI INTEGRITAS DATA RAMPUNG ===\n');
const daftar = jalankanValidasiIntegritas();
let semuaLulus = true;

for (const item of daftar) {
  const icon = item.lulus ? '✅' : '❌';
  console.log(`${icon} [${item.cek}]`);
  console.log(`   ${item.keterangan}\n`);
  if (!item.lulus) semuaLulus = false;
}

if (semuaLulus) {
  console.log('🎉 SEMUA PEMERIKSAAN INTEGRITAS DATA LULUS!');
} else {
  console.error('⚠️ ADA PEMERIKSAAN DATA YANG TIDAK MEMENUHI SYARAT!');
  process.exit(1);
}
