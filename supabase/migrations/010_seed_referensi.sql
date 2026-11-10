-- =============================================================================
-- 010_seed_referensi.sql
-- Seed Data Master: Dinas, Kategori, Kecamatan, dan 54 Kelurahan Kota Surakarta
-- Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
-- =============================================================================
-- File ini idempoten (menggunakan ON CONFLICT DO UPDATE / DO NOTHING).
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. SUMBER DATA REFERENSI
-- ---------------------------------------------------------------------------
INSERT INTO public.sumber_data (id, nama, url, tahun_data, tanggal_akses, lisensi, catatan_pengolahan, provenance)
VALUES 
  (
    'a1111111-1111-1111-1111-111111111111',
    'Dispendukcapil Kota Surakarta - Data Agregat Kependudukan',
    'https://dispendukcapil.surakarta.go.id',
    2023,
    '2026-11-10',
    'Data Terbuka Pemerintah Kota Surakarta',
    'Data agregat resmi jumlah penduduk Kota Surakarta Semester 2 Tahun 2023',
    'agregat_resmi'
  ),
  (
    'b2222222-2222-2222-2222-222222222222',
    'Portal Data Jawa Tengah - Rekap ULAS',
    'https://data.jatengprov.go.id',
    2023,
    '2026-11-10',
    'Open Data Pemerintah Provinsi Jawa Tengah',
    'Agregat volume dan distribusi aduan ULAS Surakarta per OPD',
    'agregat_resmi'
  ),
  (
    'c3333333-3333-3333-3333-333333333333',
    'Kemendagri / BPS - Kode dan Batas Administrasi Wilayah Surakarta',
    'https://surakartakota.bps.go.id',
    2023,
    '2026-11-10',
    'Publikasi Resmi BPS & Kemendagri',
    'Daftar 5 kecamatan dan 54 kelurahan definitif di Kota Surakarta',
    'asli'
  )
ON CONFLICT (id) DO UPDATE SET 
  nama = EXCLUDED.nama,
  url = EXCLUDED.url,
  catatan_pengolahan = EXCLUDED.catatan_pengolahan;

-- ---------------------------------------------------------------------------
-- 2. DINAS / ORGANISASI PERANGKAT DAERAH (OPD)
-- ---------------------------------------------------------------------------
INSERT INTO public.dinas (id, nama, singkatan, deskripsi, is_aktif)
VALUES
  (
    'd1111111-0000-0000-0000-000000000001',
    'Dinas Pekerjaan Umum dan Penataan Ruang',
    'DPUPR',
    'Menangani pemeliharaan jalan, jembatan, saluran drainase, serta fasilitas fisik kota',
    true
  ),
  (
    'd2222222-0000-0000-0000-000000000002',
    'Dinas Perhubungan',
    'Dishub',
    'Menangani penerangan jalan umum (PJU), marka jalan, rambu lalu lintas, dan halte',
    true
  ),
  (
    'd3333333-0000-0000-0000-000000000003',
    'Dinas Lingkungan Hidup',
    'DLH',
    'Menangani pengelolaan sampah liar, kebersihan ruang publik, dan pemangkasan pohon rawan',
    true
  ),
  (
    'd4444444-0000-0000-0000-000000000004',
    'Satuan Polisi Pamong Praja',
    'Satpol PP',
    'Menangani ketertiban umum, penertiban reklame liar, dan pemulihan fungsi trotoar dari okupasi pedagang',
    true
  )
ON CONFLICT (singkatan) DO UPDATE SET
  nama = EXCLUDED.nama,
  deskripsi = EXCLUDED.deskripsi,
  is_aktif = EXCLUDED.is_aktif;

-- ---------------------------------------------------------------------------
-- 3. KATEGORI ADUAN
-- ---------------------------------------------------------------------------
INSERT INTO public.kategori (id, nama, slug, ikon, dinas_id, sla_hari, is_aktif)
VALUES
  (
    'k1111111-0000-0000-0000-000000000001',
    'Penambalan Aspal',
    'penambalan-aspal',
    'hammer',
    'd1111111-0000-0000-0000-000000000001',
    7,
    true
  ),
  (
    'k2222222-0000-0000-0000-000000000002',
    'Lampu PJU',
    'lampu-pju',
    'lightbulb',
    'd2222222-0000-0000-0000-000000000002',
    5,
    true
  ),
  (
    'k3333333-0000-0000-0000-000000000003',
    'Drainase & Saluran Air',
    'drainase',
    'droplets',
    'd1111111-0000-0000-0000-000000000001',
    14,
    true
  ),
  (
    'k4444444-0000-0000-0000-000000000004',
    'Sampah & Lingkungan',
    'sampah-lingkungan',
    'trash-2',
    'd3333333-0000-0000-0000-000000000003',
    3,
    true
  ),
  (
    'k5555555-0000-0000-0000-000000000005',
    'Fasilitas Difabel',
    'fasilitas-difabel',
    'accessibility',
    'd1111111-0000-0000-0000-000000000001',
    14,
    true
  ),
  (
    'k6666666-0000-0000-0000-000000000006',
    'Rambu & Halte',
    'rambu-halte',
    'signpost',
    'd2222222-0000-0000-0000-000000000002',
    7,
    true
  )
ON CONFLICT (slug) DO UPDATE SET
  nama = EXCLUDED.nama,
  ikon = EXCLUDED.ikon,
  dinas_id = EXCLUDED.dinas_id,
  sla_hari = EXCLUDED.sla_hari;

-- ---------------------------------------------------------------------------
-- 4. KECAMATAN (5 Kecamatan Resmi Surakarta)
-- ---------------------------------------------------------------------------
INSERT INTO public.kecamatan (id, nama, kode_wilayah, jumlah_penduduk, provenance, sumber_data_id)
VALUES
  ('c1000000-0000-0000-0000-000000000001', 'Laweyan', '33.72.01', 104523, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('c2000000-0000-0000-0000-000000000002', 'Serengan', '33.72.02', 52310, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('c3000000-0000-0000-0000-000000000003', 'Pasar Kliwon', '33.72.03', 88470, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('c4000000-0000-0000-0000-000000000004', 'Jebres', '33.72.04', 151240, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('c5000000-0000-0000-0000-000000000005', 'Banjarsari', '33.72.05', 191103, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111')
ON CONFLICT (kode_wilayah) DO UPDATE SET
  nama = EXCLUDED.nama,
  jumlah_penduduk = EXCLUDED.jumlah_penduduk;

-- ---------------------------------------------------------------------------
-- 5. KELURAHAN (54 Kelurahan Lengkap di 5 Kecamatan)
-- ---------------------------------------------------------------------------

-- KECAMATAN LAWEYAN (11 Kelurahan)
INSERT INTO public.kelurahan (nama, kode_wilayah, kecamatan_id, jumlah_penduduk, provenance, sumber_data_id)
VALUES
  ('Penumping', '33.72.01.1001', 'c1000000-0000-0000-0000-000000000001', 5214, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Sriwedari', '33.72.01.1002', 'c1000000-0000-0000-0000-000000000001', 5480, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Purwosari', '33.72.01.1003', 'c1000000-0000-0000-0000-000000000001', 11320, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kerten', '33.72.01.1004', 'c1000000-0000-0000-0000-000000000001', 10185, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Jajar', '33.72.01.1005', 'c1000000-0000-0000-0000-000000000001', 12450, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Karangasem', '33.72.01.1006', 'c1000000-0000-0000-0000-000000000001', 11840, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Pajang', '33.72.01.1007', 'c1000000-0000-0000-0000-000000000001', 13920, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Sondakan', '33.72.01.1008', 'c1000000-0000-0000-0000-000000000001', 11750, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Laweyan', '33.72.01.1009', 'c1000000-0000-0000-0000-000000000001', 3240, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Bumi', '33.72.01.1010', 'c1000000-0000-0000-0000-000000000001', 7894, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Panularan', '33.72.01.1011', 'c1000000-0000-0000-0000-000000000001', 11230, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111')
ON CONFLICT (kode_wilayah) DO UPDATE SET
  nama = EXCLUDED.nama,
  jumlah_penduduk = EXCLUDED.jumlah_penduduk;

-- KECAMATAN SERENGAN (7 Kelurahan)
INSERT INTO public.kelurahan (nama, kode_wilayah, kecamatan_id, jumlah_penduduk, provenance, sumber_data_id)
VALUES
  ('Kemlayan', '33.72.02.1001', 'c2000000-0000-0000-0000-000000000002', 3940, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Jayengan', '33.72.02.1002', 'c2000000-0000-0000-0000-000000000002', 5120, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kratonan', '33.72.02.1003', 'c2000000-0000-0000-0000-000000000002', 5860, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Tipes', '33.72.02.1004', 'c2000000-0000-0000-0000-000000000002', 11450, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Serengan', '33.72.02.1005', 'c2000000-0000-0000-0000-000000000002', 9850, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Danukusuman', '33.72.02.1006', 'c2000000-0000-0000-0000-000000000002', 7480, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Joyotakan', '33.72.02.1007', 'c2000000-0000-0000-0000-000000000002', 8610, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111')
ON CONFLICT (kode_wilayah) DO UPDATE SET
  nama = EXCLUDED.nama,
  jumlah_penduduk = EXCLUDED.jumlah_penduduk;

-- KECAMATAN PASAR KLIWON (10 Kelurahan)
INSERT INTO public.kelurahan (nama, kode_wilayah, kecamatan_id, jumlah_penduduk, provenance, sumber_data_id)
VALUES
  ('Kauman', '33.72.03.1001', 'c3000000-0000-0000-0000-000000000003', 3820, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kampung Baru', '33.72.03.1002', 'c3000000-0000-0000-0000-000000000003', 4180, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kedung Lumbu', '33.72.03.1003', 'c3000000-0000-0000-0000-000000000003', 5920, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Baluwarti', '33.72.03.1004', 'c3000000-0000-0000-0000-000000000003', 7540, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Gajahan', '33.72.03.1005', 'c3000000-0000-0000-0000-000000000003', 5630, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Pasar Kliwon', '33.72.03.1006', 'c3000000-0000-0000-0000-000000000003', 6890, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Joyosuran', '33.72.03.1007', 'c3000000-0000-0000-0000-000000000003', 10450, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Semanggi', '33.72.03.1008', 'c3000000-0000-0000-0000-000000000003', 19820, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Mojo', '33.72.03.1009', 'c3000000-0000-0000-0000-000000000003', 13410, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Sangkrah', '33.72.03.1010', 'c3000000-0000-0000-0000-000000000003', 10810, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111')
ON CONFLICT (kode_wilayah) DO UPDATE SET
  nama = EXCLUDED.nama,
  jumlah_penduduk = EXCLUDED.jumlah_penduduk;

-- KECAMATAN JEBRES (11 Kelurahan)
INSERT INTO public.kelurahan (nama, kode_wilayah, kecamatan_id, jumlah_penduduk, provenance, sumber_data_id)
VALUES
  ('Sudiroprajan', '33.72.04.1001', 'c4000000-0000-0000-0000-000000000004', 4210, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Gandekan', '33.72.04.1002', 'c4000000-0000-0000-0000-000000000004', 9250, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Sewu', '33.72.04.1003', 'c4000000-0000-0000-0000-000000000004', 7890, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Jagalan', '33.72.04.1004', 'c4000000-0000-0000-0000-000000000004', 12100, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Pucangsawit', '33.72.04.1005', 'c4000000-0000-0000-0000-000000000004', 14250, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Jebres', '33.72.04.1006', 'c4000000-0000-0000-0000-000000000004', 36580, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Mojosongo', '33.72.04.1007', 'c4000000-0000-0000-0000-000000000004', 54220, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Tegalharjo', '33.72.04.1008', 'c4000000-0000-0000-0000-000000000004', 4520, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Purwodiningratan', '33.72.04.1009', 'c4000000-0000-0000-0000-000000000004', 4310, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kepatihan Kulon', '33.72.04.1010', 'c4000000-0000-0000-0000-000000000004', 2110, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kepatihan Wetan', '33.72.04.1011', 'c4000000-0000-0000-0000-000000000004', 1800, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111')
ON CONFLICT (kode_wilayah) DO UPDATE SET
  nama = EXCLUDED.nama,
  jumlah_penduduk = EXCLUDED.jumlah_penduduk;

-- KECAMATAN BANJARSARI (15 Kelurahan)
INSERT INTO public.kelurahan (nama, kode_wilayah, kecamatan_id, jumlah_penduduk, provenance, sumber_data_id)
VALUES
  ('Keprabon', '33.72.05.1001', 'c5000000-0000-0000-0000-000000000005', 3150, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Timuran', '33.72.05.1002', 'c5000000-0000-0000-0000-000000000005', 3240, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Ketelan', '33.72.05.1003', 'c5000000-0000-0000-0000-000000000005', 4380, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Punggawan', '33.72.05.1004', 'c5000000-0000-0000-0000-000000000005', 4620, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kestalan', '33.72.05.1005', 'c5000000-0000-0000-0000-000000000005', 3890, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Setabelan', '33.72.05.1006', 'c5000000-0000-0000-0000-000000000005', 4720, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Gilingan', '33.72.05.1007', 'c5000000-0000-0000-0000-000000000005', 18450, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Nusukan', '33.72.05.1008', 'c5000000-0000-0000-0000-000000000005', 35680, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kadipiro', '33.72.05.1009', 'c5000000-0000-0000-0000-000000000005', 21340, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Banyuanyar', '33.72.05.1010', 'c5000000-0000-0000-0000-000000000005', 16820, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Sumber', '33.72.05.1011', 'c5000000-0000-0000-0000-000000000005', 20110, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Manahan', '33.72.05.1012', 'c5000000-0000-0000-0000-000000000005', 13140, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Mangkubumen', '33.72.05.1013', 'c5000000-0000-0000-0000-000000000005', 9870, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Joglo', '33.72.05.1014', 'c5000000-0000-0000-0000-000000000005', 12390, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Banjarsari', '33.72.05.1015', 'c5000000-0000-0000-0000-000000000005', 12793, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111')
ON CONFLICT (kode_wilayah) DO UPDATE SET
  nama = EXCLUDED.nama,
  jumlah_penduduk = EXCLUDED.jumlah_penduduk;

