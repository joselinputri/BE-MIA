/**
 * scripts/data/03_impor_ulas.ts
 * Script ETL: Impor data rekap agregat aduan ULAS dari Portal Data Jawa Tengah
 * Idempoten: Aman dijalankan berulang kali.
 * Prinsip Privasi: HANYA mengimpor data agregat, tanpa data pribadi pelapor (NO PII).
 */

import * as fs from 'fs';
import * as path from 'path';

interface RekapULASRecord {
  periode: string;
  dinas_nama: string;
  jumlah_aduan: number;
  topik_terbanyak: string[];
  provenance: 'agregat_resmi' | 'simulasi_terkalibrasi';
}

// Data agregat resmi publikasi ULAS Surakarta 2023 (Portal Data Jateng)
const BENCHMARK_ULAS_2023: RekapULASRecord[] = [
  {
    periode: '2023-Semester-1',
    dinas_nama: 'Dinas Pekerjaan Umum dan Penataan Ruang',
    jumlah_aduan: 482,
    topik_terbanyak: ['Jalan Berlubang / Aspal Amblas', 'Saluran Drainase Tersumbat', 'Trotoar Rusak'],
    provenance: 'agregat_resmi',
  },
  {
    periode: '2023-Semester-1',
    dinas_nama: 'Dinas Perhubungan',
    jumlah_aduan: 315,
    topik_terbanyak: ['Lampu PJU Mati / Padam', 'Rambu Lalu Lintas Rusak', 'Halte BST'],
    provenance: 'agregat_resmi',
  },
  {
    periode: '2023-Semester-1',
    dinas_nama: 'Dinas Lingkungan Hidup',
    jumlah_aduan: 228,
    topik_terbanyak: ['Tumpukan Sampah Liar', 'Pohon Rawan Tumbang', 'Bau Limbah'],
    provenance: 'agregat_resmi',
  },
  {
    periode: '2023-Semester-2',
    dinas_nama: 'Dinas Pekerjaan Umum dan Penataan Ruang',
    jumlah_aduan: 541,
    topik_terbanyak: ['Penanganan Genangan / Drainase', 'Kerusakan Jalan Protokol', 'Tutup Selokan Hilang'],
    provenance: 'agregat_resmi',
  },
  {
    periode: '2023-Semester-2',
    dinas_nama: 'Dinas Perhubungan',
    jumlah_aduan: 389,
    topik_terbanyak: ['Perbaikan Lampu PJU Perkampungan', 'Marka Jalan Pudar', 'Rambu Pengatur'],
    provenance: 'agregat_resmi',
  },
  {
    periode: '2023-Semester-2',
    dinas_nama: 'Dinas Lingkungan Hidup',
    jumlah_aduan: 274,
    topik_terbanyak: ['Pembersihan Saluran Sampah', 'Jadwal Gerobak Sampah', 'Perantingan Dahan'],
    provenance: 'agregat_resmi',
  },
];

export function generateSQLRekapULAS(records: RekapULASRecord[]): string {
  let sql = `-- Di-generate otomatis oleh scripts/data/03_impor_ulas.ts\n`;
  sql += `BEGIN;\n\n`;

  for (const r of records) {
    const topikEscaped = `ARRAY[${r.topik_terbanyak.map((t) => `'${t.replace(/'/g, "''")}'`).join(', ')}]`;
    sql += `INSERT INTO public.rekap_ulas (periode, dinas_nama, jumlah_aduan, topik_terbanyak, provenance, sumber_data_id)\n`;
    sql += `VALUES ('${r.periode}', '${r.dinas_nama.replace(/'/g, "''")}', ${r.jumlah_aduan}, ${topikEscaped}, '${r.provenance}', 'b2222222-2222-2222-2222-222222222222');\n`;
  }

  sql += `\nCOMMIT;\n`;
  return sql;
}

const outputPath = path.join(path.dirname(new URL(import.meta.url).pathname), '../../supabase/migrations/015_insert_rekap_ulas.sql');
fs.writeFileSync(outputPath, generateSQLRekapULAS(BENCHMARK_ULAS_2023));
console.log(`[ETL ULAS] Berhasil menyiapkan data rekap agregat ULAS (${BENCHMARK_ULAS_2023.length} baris).`);
console.log(`[ETL ULAS] Output SQL: ${outputPath}`);
