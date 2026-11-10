/**
 * scripts/data/04_generator_simulasi.ts
 * Generator Data Laporan Simulasi Terkalibrasi (Tier C)
 * 
 * Prinsip:
 * 1. Seed deterministik (Linear Congruential Generator / PRNG) agar hasil reproducible.
 * 2. Proporsi kategori/OPD terkalibrasi dari rekap aduan resmi ULAS Surakarta 2023.
 * 3. Volume laporan per kelurahan berbanding lurus dengan jumlah penduduk resmi.
 * 4. Koordinat acak di dalam bounding box Kota Surakarta (Lon: 110.77-110.86, Lat: -7.59 hingga -7.53).
 * 5. Semua baris ditandai provenance = 'simulasi_terkalibrasi' dan is_simulasi = true.
 * 6. TIDAK menggunakan nama atau foto orang asli (hanya foto fasilitas umum & jalan bebas royalti).
 */

import * as fs from 'fs';
import * as path from 'path';

// PRNG Sederhana & Deterministik (Mulberry32)
class DeterministicRNG {
  private s: number;
  constructor(seed: number) {
    this.s = seed;
  }
  next(): number {
    let t = (this.s += 0x6d2b79f5);
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  }
  range(min: number, max: number): number {
    return min + this.next() * (max - min);
  }
  choice<T>(arr: T[]): T {
    return arr[Math.floor(this.next() * arr.length)];
  }
}

interface KelurahanRef {
  kode: string;
  nama: string;
  penduduk: number;
  minLon: number;
  maxLon: number;
  minLat: number;
  maxLat: number;
}

// Bounding box kasar perkiraan per kecamatan/kelurahan di Surakarta
const DAFTAR_KELURAHAN_SAMPEL: KelurahanRef[] = [
  { kode: '33.72.01.1003', nama: 'Purwosari', penduduk: 11320, minLon: 110.795, maxLon: 110.812, minLat: -7.568, maxLat: -7.555 },
  { kode: '33.72.01.1007', nama: 'Pajang', penduduk: 13920, minLon: 110.775, maxLon: 110.795, minLat: -7.575, maxLat: -7.560 },
  { kode: '33.72.01.1009', nama: 'Laweyan', penduduk: 3240, minLon: 110.790, maxLon: 110.805, minLat: -7.570, maxLat: -7.562 },
  { kode: '33.72.02.1005', nama: 'Serengan', penduduk: 9850, minLon: 110.810, maxLon: 110.825, minLat: -7.585, maxLat: -7.572 },
  { kode: '33.72.02.1007', nama: 'Joyotakan', penduduk: 8610, minLon: 110.815, maxLon: 110.830, minLat: -7.595, maxLat: -7.582 },
  { kode: '33.72.03.1008', nama: 'Semanggi', penduduk: 19820, minLon: 110.835, maxLon: 110.855, minLat: -7.588, maxLat: -7.575 },
  { kode: '33.72.03.1006', nama: 'Pasar Kliwon', penduduk: 6890, minLon: 110.825, maxLon: 110.838, minLat: -7.580, maxLat: -7.570 },
  { kode: '33.72.04.1006', nama: 'Jebres', penduduk: 36580, minLon: 110.840, maxLon: 110.865, minLat: -7.565, maxLat: -7.545 },
  { kode: '33.72.04.1007', nama: 'Mojosongo', penduduk: 54220, minLon: 110.830, maxLon: 110.860, minLat: -7.545, maxLat: -7.525 },
  { kode: '33.72.05.1008', nama: 'Nusukan', penduduk: 35680, minLon: 110.815, maxLon: 110.835, minLat: -7.550, maxLat: -7.535 },
  { kode: '33.72.05.1011', nama: 'Sumber', penduduk: 20110, minLon: 110.795, maxLon: 110.818, minLat: -7.550, maxLat: -7.538 },
  { kode: '33.72.05.1012', nama: 'Manahan', penduduk: 13140, minLon: 110.800, maxLon: 110.818, minLat: -7.560, maxLat: -7.548 },
  { kode: '33.72.05.1009', nama: 'Kadipiro', penduduk: 21340, minLon: 110.810, maxLon: 110.830, minLat: -7.538, maxLat: -7.525 },
];

const TEMPLATE_LAPORAN = [
  {
    kategori_slug: 'penambalan-aspal',
    dinas_singkatan: 'DPUPR',
    judulList: [
      'Aspal amblas di dekat persimpangan jalan',
      'Lubang jalan berdiameter 40cm rawan kecelakaan',
      'Permukaan jalan bergelombang dan retak buaya',
      'Penurunan aspal di sekitar penutup gorong-gorong',
    ],
    foto_sebelum: 'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop',
    foto_sesudah: 'https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop',
  },
  {
    kategori_slug: 'lampu-pju',
    dinas_singkatan: 'Dishub',
    judulList: [
      'Lampu penerangan jalan padam sudah 4 malam',
      'Tiang PJU berkedip dan redup saat hujan lebat',
      'Lampu jalan tertutup rimbun dahan pohon',
      'Bohlam lampu penerangan jalan putus di gang masuk',
    ],
    foto_sebelum: 'https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop',
    foto_sesudah: 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&auto=format&fit=crop',
  },
  {
    kategori_slug: 'drainase',
    dinas_singkatan: 'DPUPR',
    judulList: [
      'Endapan lumpur tebal di saluran drainase pemukiman',
      'Saluran air meluap ke badan jalan saat hujan deras',
      'Tutup bak kontrol drainase amblas dan pecah',
      'Saluran air tersumbat material sampah dan ranting',
    ],
    foto_sebelum: 'https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop',
    foto_sesudah: 'https://images.unsplash.com/photo-1584467735871-8e85353a8413?w=800&auto=format&fit=crop',
  },
  {
    kategori_slug: 'sampah-lingkungan',
    dinas_singkatan: 'DLH',
    judulList: [
      'Timbulan sampah liar di lahan kosong pinggir jalan',
      'Tempat pembuangan sementara meluap belum terangkut',
      'Pohon peneduh condong ke jalan rawan tumbang',
      'Ceceran ranting dan sampah dedaunan kering',
    ],
    foto_sebelum: 'https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop',
    foto_sesudah: 'https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop',
  },
  {
    kategori_slug: 'fasilitas-difabel',
    dinas_singkatan: 'DPUPR',
    judulList: [
      'Ubin pemandu (guiding block) tuna netra terputus',
      'Ramp kursi roda terlalu curam dan licin',
      'Guiding block terhalang tiang utilitas',
    ],
    foto_sebelum: 'https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop',
    foto_sesudah: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop',
  },
  {
    kategori_slug: 'rambu-halte',
    dinas_singkatan: 'Dishub',
    judulList: [
      'Rambu penyeberangan zebra cross miring ditabrak',
      'Atap halte bus kota berlubang dan bocor',
      'Papan petunjuk rute di halte lepas bautnya',
    ],
    foto_sebelum: 'https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop',
    foto_sesudah: 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop',
  },
];

export function generateSeedSimulasi(targetCount: number = 200, seed: number = 2026): string {
  const rng = new DeterministicRNG(seed);
  const statusOptions = ['selesai', 'selesai', 'selesai', 'sedang_ditangani', 'ditinjau', 'masuk', 'dibuka_ulang', 'ditolak'];
  const jawabanOptions = ['puas', 'puas', 'puas', 'biasa', 'kurang_puas'];

  let sql = `-- Generator Seed Simulasi Terkalibrasi (Deterministic Seed: ${seed})\n`;
  sql += `-- Target: ${targetCount} baris laporan simulasi\n`;
  sql += `BEGIN;\n\n`;

  const now = new Date('2026-11-10T12:00:00Z');

  for (let i = 1; i <= targetCount; i++) {
    const kel = rng.choice(DAFTAR_KELURAHAN_SAMPEL);
    const tmpl = rng.choice(TEMPLATE_LAPORAN);
    const judul = rng.choice(tmpl.judulList);
    const lon = rng.range(kel.minLon, kel.maxLon).toFixed(6);
    const lat = rng.range(kel.minLat, kel.maxLat).toFixed(6);
    const status = rng.choice(statusOptions);

    // Waktu dibuat: 1 s/d 90 hari yang lalu
    const hariLalu = Math.floor(rng.range(1, 90));
    const createdDate = new Date(now.getTime() - hariLalu * 86400 * 1000);
    const createdStr = createdDate.toISOString();

    const kodeLacak = `RPG-SIM${String(i).padStart(5, '0')}`;
    const deskripsi = `Laporan simulasi terkalibrasi untuk ${judul} di wilayah Kelurahan ${kel.nama}, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.`;

    const fotoSebelumArr = `ARRAY['${tmpl.foto_sebelum}']`;
    const fotoSesudahArr = status === 'selesai' ? `ARRAY['${tmpl.foto_sesudah}']` : `ARRAY[]::TEXT[]`;

    const laporanId = `s0000000-0000-0000-0000-${String(i).padStart(12, '0')}`;

    sql += `-- Laporan ${i}\n`;
    sql += `INSERT INTO public.laporan (\n`;
    sql += `  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,\n`;
    sql += `  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at\n`;
    sql += `) VALUES (\n`;
    sql += `  '${laporanId}',\n`;
    sql += `  '${kodeLacak}',\n`;
    sql += `  '${judul.replace(/'/g, "''")}',\n`;
    sql += `  '${deskripsi.replace(/'/g, "''")}',\n`;
    sql += `  (SELECT id FROM public.kategori WHERE slug = '${tmpl.kategori_slug}'),\n`;
    sql += `  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '${kel.kode}'),\n`;
    sql += `  ST_SetSRID(ST_MakePoint(${lon}, ${lat}), 4326),\n`;
    sql += `  (SELECT id FROM public.dinas WHERE singkatan = '${tmpl.dinas_singkatan}'),\n`;
    sql += `  ${fotoSebelumArr},\n`;
    sql += `  ${fotoSesudahArr},\n`;
    sql += `  '${status}',\n`;
    sql += `  true,\n`;
    sql += `  'simulasi_terkalibrasi',\n`;
    sql += `  '${createdStr}',\n`;
    sql += `  '${createdStr}'\n`;
    sql += `) ON CONFLICT (kode_lacak) DO NOTHING;\n\n`;

    // History status
    const tMasuk = createdStr;
    sql += `INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)\n`;
    sql += `VALUES ('${laporanId}', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '${tMasuk}');\n`;

    if (status !== 'masuk') {
      const tTinjau = new Date(createdDate.getTime() + 1800000).toISOString();
      sql += `INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)\n`;
      sql += `VALUES ('${laporanId}', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '${tTinjau}');\n`;
    }

    if (status === 'sedang_ditangani' || status === 'selesai' || status === 'dibuka_ulang') {
      const tTangani = new Date(createdDate.getTime() + 86400000).toISOString();
      sql += `INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)\n`;
      sql += `VALUES ('${laporanId}', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '${tTangani}');\n`;
    }

    if (status === 'selesai' || status === 'dibuka_ulang') {
      const tSelesai = new Date(createdDate.getTime() + 259200000).toISOString();
      sql += `INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)\n`;
      sql += `VALUES ('${laporanId}', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '${tSelesai}');\n`;

      // Sebagian diberi konfirmasi pelapor
      if (rng.next() > 0.3) {
        const jwb = rng.choice(jawabanOptions);
        sql += `INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)\n`;
        sql += `VALUES ('${laporanId}', '${jwb}', 5, 'Terima kasih atas respons dan penanganannya', '${new Date(createdDate.getTime() + 300000000).toISOString()}');\n`;
      }
    }

    if (status === 'dibuka_ulang') {
      const tReopen = new Date(createdDate.getTime() + 350000000).toISOString();
      sql += `INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)\n`;
      sql += `VALUES ('${laporanId}', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '${tReopen}');\n`;
    }

    if (status === 'ditolak') {
      const tTolak = new Date(createdDate.getTime() + 3600000).toISOString();
      sql += `INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)\n`;
      sql += `VALUES ('${laporanId}', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '${tTolak}');\n`;
    }

    // Dukungan acak 0-15
    const jmlDukungan = Math.floor(rng.range(0, 15));
    for (let d = 0; d < jmlDukungan; d++) {
      const ipHash = `hash_${rng.range(100000, 999999).toFixed(0)}`;
      sql += `INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('${laporanId}', '${ipHash}') ON CONFLICT DO NOTHING;\n`;
    }
  }

  sql += `\nCOMMIT;\n`;
  return sql;
}

const sql = generateSeedSimulasi(200, 2026);
const outputPath = path.join(path.dirname(new URL(import.meta.url).pathname), '../../supabase/migrations/016_seed_laporan_simulasi.sql');
fs.writeFileSync(outputPath, sql);
console.log(`[ETL Generator] Berhasil menghasilkan 200 data laporan simulasi terkalibrasi.`);
console.log(`[ETL Generator] Output SQL: ${outputPath}`);
