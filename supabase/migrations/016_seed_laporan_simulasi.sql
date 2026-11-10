-- Generator Seed Simulasi Terkalibrasi (Deterministic Seed: 2026)
-- Target: 200 baris laporan simulasi
BEGIN;

-- Laporan 1
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000001',
  'RPG-SIM00001',
  'Lampu jalan tertutup rimbun dahan pohon',
  'Laporan simulasi terkalibrasi untuk Lampu jalan tertutup rimbun dahan pohon di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.847370, -7.586020), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-10T12:00:00.000Z',
  '2026-09-10T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000001', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-10T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000001', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-10T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000001', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-11T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000001', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-13T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000001', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-13T23:20:00.000Z');
-- Laporan 2
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000002',
  'RPG-SIM00002',
  'Tempat pembuangan sementara meluap belum terangkut',
  'Laporan simulasi terkalibrasi untuk Tempat pembuangan sementara meluap belum terangkut di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.796947, -7.565667), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-04T12:00:00.000Z',
  '2026-10-04T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000002', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-04T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000002', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-04T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000002', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-05T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000002', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-07T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000002', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-07T23:20:00.000Z');
-- Laporan 3
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000003',
  'RPG-SIM00003',
  'Bohlam lampu penerangan jalan putus di gang masuk',
  'Laporan simulasi terkalibrasi untuk Bohlam lampu penerangan jalan putus di gang masuk di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.804301, -7.562462), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-10-16T12:00:00.000Z',
  '2026-10-16T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000003', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-16T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000003', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-16T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000003', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-17T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000003', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-19T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000003', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-10-20T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000003', 'hash_357990') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000003', 'hash_697400') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000003', 'hash_858205') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000003', 'hash_371066') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000003', 'hash_926777') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000003', 'hash_172340') ON CONFLICT DO NOTHING;
-- Laporan 4
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000004',
  'RPG-SIM00004',
  'Saluran air tersumbat material sampah dan ranting',
  'Laporan simulasi terkalibrasi untuk Saluran air tersumbat material sampah dan ranting di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.807613, -7.562866), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-09-10T12:00:00.000Z',
  '2026-09-10T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000004', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-10T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000004', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-10T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000004', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-09-10T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000004', 'hash_428591') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000004', 'hash_128024') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000004', 'hash_993657') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000004', 'hash_264082') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000004', 'hash_969961') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000004', 'hash_847892') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000004', 'hash_346930') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000004', 'hash_543404') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000004', 'hash_259677') ON CONFLICT DO NOTHING;
-- Laporan 5
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000005',
  'RPG-SIM00005',
  'Ceceran ranting dan sampah dedaunan kering',
  'Laporan simulasi terkalibrasi untuk Ceceran ranting dan sampah dedaunan kering di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.825354, -7.530210), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-09-26T12:00:00.000Z',
  '2026-09-26T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000005', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-26T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000005', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-26T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000005', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-27T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000005', 'hash_790962') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000005', 'hash_618587') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000005', 'hash_705924') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000005', 'hash_971305') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000005', 'hash_436065') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000005', 'hash_111811') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000005', 'hash_260769') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000005', 'hash_171926') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000005', 'hash_956552') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000005', 'hash_934234') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000005', 'hash_256281') ON CONFLICT DO NOTHING;
-- Laporan 6
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000006',
  'RPG-SIM00006',
  'Tutup bak kontrol drainase amblas dan pecah',
  'Laporan simulasi terkalibrasi untuk Tutup bak kontrol drainase amblas dan pecah di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.794323, -7.562415), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-11-08T12:00:00.000Z',
  '2026-11-08T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000006', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-08T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000006', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-08T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000006', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-11-08T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_657362') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_896398') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_310555') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_638358') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_596704') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_117602') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_919944') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_879124') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_967159') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_812761') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_123019') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_957920') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_942297') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000006', 'hash_528137') ON CONFLICT DO NOTHING;
-- Laporan 7
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000007',
  'RPG-SIM00007',
  'Aspal amblas di dekat persimpangan jalan',
  'Laporan simulasi terkalibrasi untuk Aspal amblas di dekat persimpangan jalan di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.851563, -7.576100), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-10-23T12:00:00.000Z',
  '2026-10-23T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000007', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-23T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000007', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-23T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000007', 'hash_547086') ON CONFLICT DO NOTHING;
-- Laporan 8
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000008',
  'RPG-SIM00008',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.816435, -7.528756), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-10-23T12:00:00.000Z',
  '2026-10-23T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000008', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-23T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000008', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-23T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000008', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-24T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000008', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-26T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000008', 'kurang_puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-26T23:20:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000008', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-10-27T13:13:20.000Z');
-- Laporan 9
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000009',
  'RPG-SIM00009',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.855127, -7.560932), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-12T12:00:00.000Z',
  '2026-10-12T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000009', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-12T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000009', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-12T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000009', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-13T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000009', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-15T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_429077') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_152534') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_459277') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_427892') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_921750') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_853453') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_675897') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_774175') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_427422') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_324158') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_527688') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_305693') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000009', 'hash_149611') ON CONFLICT DO NOTHING;
-- Laporan 10
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000010',
  'RPG-SIM00010',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.791300, -7.560235), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-26T12:00:00.000Z',
  '2026-10-26T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000010', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-26T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000010', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-26T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000010', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000010', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-29T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000010', 'hash_914690') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000010', 'hash_179180') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000010', 'hash_352321') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000010', 'hash_135947') ON CONFLICT DO NOTHING;
-- Laporan 11
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000011',
  'RPG-SIM00011',
  'Ceceran ranting dan sampah dedaunan kering',
  'Laporan simulasi terkalibrasi untuk Ceceran ranting dan sampah dedaunan kering di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.849074, -7.554723), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-09-11T12:00:00.000Z',
  '2026-09-11T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000011', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-11T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000011', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-11T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_556862') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_464477') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_689802') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_772236') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_220509') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_402686') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_480720') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_482293') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_211327') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_251724') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_410877') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_163416') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000011', 'hash_503554') ON CONFLICT DO NOTHING;
-- Laporan 12
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000012',
  'RPG-SIM00012',
  'Lampu penerangan jalan padam sudah 4 malam',
  'Laporan simulasi terkalibrasi untuk Lampu penerangan jalan padam sudah 4 malam di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.840275, -7.579176), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-10-13T12:00:00.000Z',
  '2026-10-13T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000012', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-13T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000012', 'hash_296459') ON CONFLICT DO NOTHING;
-- Laporan 13
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000013',
  'RPG-SIM00013',
  'Papan petunjuk rute di halte lepas bautnya',
  'Laporan simulasi terkalibrasi untuk Papan petunjuk rute di halte lepas bautnya di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.812767, -7.557965), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-05T12:00:00.000Z',
  '2026-10-05T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000013', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-05T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000013', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-05T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000013', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-06T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000013', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-08T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000013', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-08T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000013', 'hash_965815') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000013', 'hash_541617') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000013', 'hash_487857') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000013', 'hash_568187') ON CONFLICT DO NOTHING;
-- Laporan 14
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000014',
  'RPG-SIM00014',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.817392, -7.548210), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-10T12:00:00.000Z',
  '2026-10-10T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000014', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-10T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000014', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-10T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000014', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-11T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000014', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-13T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000014', 'hash_111543') ON CONFLICT DO NOTHING;
-- Laporan 15
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000015',
  'RPG-SIM00015',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.821338, -7.594233), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-11-04T12:00:00.000Z',
  '2026-11-04T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000015', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-04T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000015', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-04T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000015', 'hash_173220') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000015', 'hash_467744') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000015', 'hash_403369') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000015', 'hash_542654') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000015', 'hash_592371') ON CONFLICT DO NOTHING;
-- Laporan 16
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000016',
  'RPG-SIM00016',
  'Atap halte bus kota berlubang dan bocor',
  'Laporan simulasi terkalibrasi untuk Atap halte bus kota berlubang dan bocor di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.851031, -7.562296), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-08-31T12:00:00.000Z',
  '2026-08-31T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000016', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-31T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000016', 'hash_674841') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000016', 'hash_383319') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000016', 'hash_765875') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000016', 'hash_762530') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000016', 'hash_215587') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000016', 'hash_737553') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000016', 'hash_725705') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000016', 'hash_553483') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000016', 'hash_212336') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000016', 'hash_986798') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000016', 'hash_556144') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000016', 'hash_557044') ON CONFLICT DO NOTHING;
-- Laporan 17
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000017',
  'RPG-SIM00017',
  'Pohon peneduh condong ke jalan rawan tumbang',
  'Laporan simulasi terkalibrasi untuk Pohon peneduh condong ke jalan rawan tumbang di wilayah Kelurahan Pasar Kliwon, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1006'),
  ST_SetSRID(ST_MakePoint(110.837349, -7.576078), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-09-04T12:00:00.000Z',
  '2026-09-04T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000017', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-04T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000017', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-04T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000017', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-05T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_113347') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_999510') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_593129') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_252930') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_381525') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_939533') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_623007') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_850893') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_899873') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_952399') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_925857') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_334475') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000017', 'hash_415385') ON CONFLICT DO NOTHING;
-- Laporan 18
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000018',
  'RPG-SIM00018',
  'Lubang jalan berdiameter 40cm rawan kecelakaan',
  'Laporan simulasi terkalibrasi untuk Lubang jalan berdiameter 40cm rawan kecelakaan di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.828410, -7.543650), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-10-11T12:00:00.000Z',
  '2026-10-11T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000018', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-11T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000018', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-11T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000018', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-12T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000018', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-14T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000018', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-10-15T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000018', 'hash_876931') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000018', 'hash_794608') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000018', 'hash_309521') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000018', 'hash_564616') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000018', 'hash_130533') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000018', 'hash_550478') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000018', 'hash_218458') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000018', 'hash_830522') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000018', 'hash_585557') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000018', 'hash_668385') ON CONFLICT DO NOTHING;
-- Laporan 19
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000019',
  'RPG-SIM00019',
  'Atap halte bus kota berlubang dan bocor',
  'Laporan simulasi terkalibrasi untuk Atap halte bus kota berlubang dan bocor di wilayah Kelurahan Pasar Kliwon, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1006'),
  ST_SetSRID(ST_MakePoint(110.830429, -7.570346), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-08-22T12:00:00.000Z',
  '2026-08-22T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000019', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-22T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000019', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-22T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000019', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-08-22T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000019', 'hash_877220') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000019', 'hash_979669') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000019', 'hash_949054') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000019', 'hash_128954') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000019', 'hash_238511') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000019', 'hash_603826') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000019', 'hash_299199') ON CONFLICT DO NOTHING;
-- Laporan 20
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000020',
  'RPG-SIM00020',
  'Endapan lumpur tebal di saluran drainase pemukiman',
  'Laporan simulasi terkalibrasi untuk Endapan lumpur tebal di saluran drainase pemukiman di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.786035, -7.573347), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-09-20T12:00:00.000Z',
  '2026-09-20T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000020', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-20T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000020', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-20T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000020', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-21T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000020', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-23T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000020', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-23T23:20:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000020', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-09-24T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000020', 'hash_239917') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000020', 'hash_633834') ON CONFLICT DO NOTHING;
-- Laporan 21
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000021',
  'RPG-SIM00021',
  'Papan petunjuk rute di halte lepas bautnya',
  'Laporan simulasi terkalibrasi untuk Papan petunjuk rute di halte lepas bautnya di wilayah Kelurahan Pasar Kliwon, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1006'),
  ST_SetSRID(ST_MakePoint(110.829993, -7.575972), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-10-16T12:00:00.000Z',
  '2026-10-16T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000021', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-16T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000021', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-16T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000021', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-10-16T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000021', 'hash_443906') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000021', 'hash_540971') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000021', 'hash_272118') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000021', 'hash_663036') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000021', 'hash_422422') ON CONFLICT DO NOTHING;
-- Laporan 22
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000022',
  'RPG-SIM00022',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.803677, -7.564320), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-08-16T12:00:00.000Z',
  '2026-08-16T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000022', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-16T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000022', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-16T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000022', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-17T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000022', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-19T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000022', 'biasa', 5, 'Terima kasih atas respons dan penanganannya', '2026-08-19T23:20:00.000Z');
-- Laporan 23
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000023',
  'RPG-SIM00023',
  'Timbulan sampah liar di lahan kosong pinggir jalan',
  'Laporan simulasi terkalibrasi untuk Timbulan sampah liar di lahan kosong pinggir jalan di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.833253, -7.536027), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-09-08T12:00:00.000Z',
  '2026-09-08T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000023', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-08T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000023', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-08T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000023', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-09-08T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000023', 'hash_174172') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000023', 'hash_816422') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000023', 'hash_774964') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000023', 'hash_895884') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000023', 'hash_758274') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000023', 'hash_853162') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000023', 'hash_772466') ON CONFLICT DO NOTHING;
-- Laporan 24
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000024',
  'RPG-SIM00024',
  'Lampu penerangan jalan padam sudah 4 malam',
  'Laporan simulasi terkalibrasi untuk Lampu penerangan jalan padam sudah 4 malam di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.792307, -7.564543), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-10-16T12:00:00.000Z',
  '2026-10-16T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000024', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-16T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000024', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-16T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000024', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-10-16T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000024', 'hash_552656') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000024', 'hash_491047') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000024', 'hash_148761') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000024', 'hash_894334') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000024', 'hash_448730') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000024', 'hash_463377') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000024', 'hash_485853') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000024', 'hash_444709') ON CONFLICT DO NOTHING;
-- Laporan 25
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000025',
  'RPG-SIM00025',
  'Tempat pembuangan sementara meluap belum terangkut',
  'Laporan simulasi terkalibrasi untuk Tempat pembuangan sementara meluap belum terangkut di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.819576, -7.582985), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-08-27T12:00:00.000Z',
  '2026-08-27T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000025', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000025', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-27T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000025', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-28T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_479934') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_264171') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_967600') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_891795') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_405859') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_664588') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_538326') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_115915') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_481749') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_745182') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_779781') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_754066') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_393970') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000025', 'hash_997135') ON CONFLICT DO NOTHING;
-- Laporan 26
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000026',
  'RPG-SIM00026',
  'Saluran air meluap ke badan jalan saat hujan deras',
  'Laporan simulasi terkalibrasi untuk Saluran air meluap ke badan jalan saat hujan deras di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.817221, -7.587485), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-08-26T12:00:00.000Z',
  '2026-08-26T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000026', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-26T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000026', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-26T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000026', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-27T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000026', 'hash_734076') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000026', 'hash_377846') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000026', 'hash_147702') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000026', 'hash_460193') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000026', 'hash_474724') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000026', 'hash_394083') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000026', 'hash_564726') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000026', 'hash_788567') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000026', 'hash_185520') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000026', 'hash_545858') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000026', 'hash_328158') ON CONFLICT DO NOTHING;
-- Laporan 27
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000027',
  'RPG-SIM00027',
  'Tiang PJU berkedip dan redup saat hujan lebat',
  'Laporan simulasi terkalibrasi untuk Tiang PJU berkedip dan redup saat hujan lebat di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.800778, -7.559038), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-11-01T12:00:00.000Z',
  '2026-11-01T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000027', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000027', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-01T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000027', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-11-02T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000027', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-04T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000027', 'kurang_puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-11-04T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000027', 'hash_949859') ON CONFLICT DO NOTHING;
-- Laporan 28
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000028',
  'RPG-SIM00028',
  'Lubang jalan berdiameter 40cm rawan kecelakaan',
  'Laporan simulasi terkalibrasi untuk Lubang jalan berdiameter 40cm rawan kecelakaan di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.811134, -7.535782), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-09-07T12:00:00.000Z',
  '2026-09-07T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000028', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-07T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000028', 'hash_178567') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000028', 'hash_999066') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000028', 'hash_361796') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000028', 'hash_120638') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000028', 'hash_517283') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000028', 'hash_780238') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000028', 'hash_964133') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000028', 'hash_625286') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000028', 'hash_515641') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000028', 'hash_865938') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000028', 'hash_475587') ON CONFLICT DO NOTHING;
-- Laporan 29
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000029',
  'RPG-SIM00029',
  'Saluran air tersumbat material sampah dan ranting',
  'Laporan simulasi terkalibrasi untuk Saluran air tersumbat material sampah dan ranting di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.826497, -7.544330), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1584467735871-8e85353a8413?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-13T12:00:00.000Z',
  '2026-09-13T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000029', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-13T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000029', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-13T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000029', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-14T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000029', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-16T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000029', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-16T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000029', 'hash_903498') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000029', 'hash_439792') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000029', 'hash_167663') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000029', 'hash_857183') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000029', 'hash_442456') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000029', 'hash_217440') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000029', 'hash_113492') ON CONFLICT DO NOTHING;
-- Laporan 30
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000030',
  'RPG-SIM00030',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.839272, -7.576510), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-08-19T12:00:00.000Z',
  '2026-08-19T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000030', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-19T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000030', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-19T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000030', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-20T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000030', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-22T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000030', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-08-22T23:20:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000030', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-08-23T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000030', 'hash_765065') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000030', 'hash_623816') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000030', 'hash_812831') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000030', 'hash_395763') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000030', 'hash_946810') ON CONFLICT DO NOTHING;
-- Laporan 31
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000031',
  'RPG-SIM00031',
  'Tiang PJU berkedip dan redup saat hujan lebat',
  'Laporan simulasi terkalibrasi untuk Tiang PJU berkedip dan redup saat hujan lebat di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.816126, -7.526099), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-10-13T12:00:00.000Z',
  '2026-10-13T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000031', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-13T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000031', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-13T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000031', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-10-13T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000031', 'hash_183389') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000031', 'hash_941714') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000031', 'hash_858984') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000031', 'hash_368366') ON CONFLICT DO NOTHING;
-- Laporan 32
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000032',
  'RPG-SIM00032',
  'Tiang PJU berkedip dan redup saat hujan lebat',
  'Laporan simulasi terkalibrasi untuk Tiang PJU berkedip dan redup saat hujan lebat di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.817193, -7.580427), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-10-03T12:00:00.000Z',
  '2026-10-03T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000032', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-03T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000032', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-03T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000032', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-04T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000032', 'hash_835034') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000032', 'hash_559255') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000032', 'hash_462127') ON CONFLICT DO NOTHING;
-- Laporan 33
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000033',
  'RPG-SIM00033',
  'Lampu jalan tertutup rimbun dahan pohon',
  'Laporan simulasi terkalibrasi untuk Lampu jalan tertutup rimbun dahan pohon di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.825934, -7.587302), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-08-22T12:00:00.000Z',
  '2026-08-22T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000033', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-22T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000033', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-22T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000033', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-08-22T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000033', 'hash_235047') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000033', 'hash_608777') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000033', 'hash_293378') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000033', 'hash_170214') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000033', 'hash_952878') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000033', 'hash_159669') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000033', 'hash_481120') ON CONFLICT DO NOTHING;
-- Laporan 34
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000034',
  'RPG-SIM00034',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.791517, -7.562879), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-10-04T12:00:00.000Z',
  '2026-10-04T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000034', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-04T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000034', 'hash_830680') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000034', 'hash_683128') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000034', 'hash_531023') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000034', 'hash_776163') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000034', 'hash_765686') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000034', 'hash_493910') ON CONFLICT DO NOTHING;
-- Laporan 35
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000035',
  'RPG-SIM00035',
  'Pohon peneduh condong ke jalan rawan tumbang',
  'Laporan simulasi terkalibrasi untuk Pohon peneduh condong ke jalan rawan tumbang di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.843428, -7.532203), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-09-04T12:00:00.000Z',
  '2026-09-04T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000035', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-04T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000035', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-04T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000035', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-05T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_803265') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_490441') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_758265') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_739742') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_723383') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_111353') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_625496') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_285672') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_688148') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_916739') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_440365') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_707050') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_160136') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000035', 'hash_463978') ON CONFLICT DO NOTHING;
-- Laporan 36
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000036',
  'RPG-SIM00036',
  'Lubang jalan berdiameter 40cm rawan kecelakaan',
  'Laporan simulasi terkalibrasi untuk Lubang jalan berdiameter 40cm rawan kecelakaan di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.827616, -7.587315), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-10-03T12:00:00.000Z',
  '2026-10-03T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000036', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-03T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000036', 'hash_969907') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000036', 'hash_351247') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000036', 'hash_436023') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000036', 'hash_558025') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000036', 'hash_949822') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000036', 'hash_762861') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000036', 'hash_462226') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000036', 'hash_167079') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000036', 'hash_354000') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000036', 'hash_548699') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000036', 'hash_726517') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000036', 'hash_850113') ON CONFLICT DO NOTHING;
-- Laporan 37
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000037',
  'RPG-SIM00037',
  'Papan petunjuk rute di halte lepas bautnya',
  'Laporan simulasi terkalibrasi untuk Papan petunjuk rute di halte lepas bautnya di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.803034, -7.548629), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-08-17T12:00:00.000Z',
  '2026-08-17T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000037', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-17T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000037', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-17T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000037', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-18T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000037', 'hash_384698') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000037', 'hash_351756') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000037', 'hash_918924') ON CONFLICT DO NOTHING;
-- Laporan 38
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000038',
  'RPG-SIM00038',
  'Atap halte bus kota berlubang dan bocor',
  'Laporan simulasi terkalibrasi untuk Atap halte bus kota berlubang dan bocor di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.849544, -7.561857), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-18T12:00:00.000Z',
  '2026-09-18T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000038', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-18T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000038', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-18T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000038', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-19T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000038', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-21T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_958538') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_223960') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_968932') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_701017') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_412530') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_237719') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_808905') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_956534') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_302904') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_139503') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_471444') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_398719') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_473042') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000038', 'hash_217531') ON CONFLICT DO NOTHING;
-- Laporan 39
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000039',
  'RPG-SIM00039',
  'Lampu jalan tertutup rimbun dahan pohon',
  'Laporan simulasi terkalibrasi untuk Lampu jalan tertutup rimbun dahan pohon di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.790670, -7.563227), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-09-10T12:00:00.000Z',
  '2026-09-10T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000039', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-10T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000039', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-10T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000039', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-09-10T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000039', 'hash_738199') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000039', 'hash_796455') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000039', 'hash_996024') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000039', 'hash_278725') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000039', 'hash_304538') ON CONFLICT DO NOTHING;
-- Laporan 40
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000040',
  'RPG-SIM00040',
  'Timbulan sampah liar di lahan kosong pinggir jalan',
  'Laporan simulasi terkalibrasi untuk Timbulan sampah liar di lahan kosong pinggir jalan di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.817514, -7.532527), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-18T12:00:00.000Z',
  '2026-09-18T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000040', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-18T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000040', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-18T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000040', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-19T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000040', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-21T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000040', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-21T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000040', 'hash_660390') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000040', 'hash_168366') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000040', 'hash_966088') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000040', 'hash_750298') ON CONFLICT DO NOTHING;
-- Laporan 41
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000041',
  'RPG-SIM00041',
  'Lampu penerangan jalan padam sudah 4 malam',
  'Laporan simulasi terkalibrasi untuk Lampu penerangan jalan padam sudah 4 malam di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.815492, -7.576342), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-11-03T12:00:00.000Z',
  '2026-11-03T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000041', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-03T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000041', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-03T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000041', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-11-04T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000041', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-06T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_222139') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_166236') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_705731') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_162142') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_988760') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_527401') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_780774') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_486554') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_840387') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_960766') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_690895') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_418225') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000041', 'hash_647125') ON CONFLICT DO NOTHING;
-- Laporan 42
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000042',
  'RPG-SIM00042',
  'Lubang jalan berdiameter 40cm rawan kecelakaan',
  'Laporan simulasi terkalibrasi untuk Lubang jalan berdiameter 40cm rawan kecelakaan di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.820339, -7.576567), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-09-16T12:00:00.000Z',
  '2026-09-16T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000042', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-16T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000042', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-16T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000042', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-09-16T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000042', 'hash_715700') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000042', 'hash_575949') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000042', 'hash_413557') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000042', 'hash_848622') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000042', 'hash_582834') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000042', 'hash_917404') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000042', 'hash_637069') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000042', 'hash_490713') ON CONFLICT DO NOTHING;
-- Laporan 43
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000043',
  'RPG-SIM00043',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.843457, -7.556215), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-10-21T12:00:00.000Z',
  '2026-10-21T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000043', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-21T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000043', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-21T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000043', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-10-21T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000043', 'hash_828819') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000043', 'hash_952651') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000043', 'hash_334024') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000043', 'hash_561182') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000043', 'hash_411679') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000043', 'hash_370160') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000043', 'hash_930806') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000043', 'hash_765115') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000043', 'hash_354016') ON CONFLICT DO NOTHING;
-- Laporan 44
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000044',
  'RPG-SIM00044',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.824277, -7.536519), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-09-04T12:00:00.000Z',
  '2026-09-04T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000044', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-04T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000044', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-04T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000044', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-05T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000044', 'hash_938840') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000044', 'hash_183248') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000044', 'hash_428721') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000044', 'hash_848608') ON CONFLICT DO NOTHING;
-- Laporan 45
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000045',
  'RPG-SIM00045',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.790212, -7.569736), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-22T12:00:00.000Z',
  '2026-09-22T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000045', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-22T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000045', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-22T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000045', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-23T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000045', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-25T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000045', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-25T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000045', 'hash_367641') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000045', 'hash_448310') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000045', 'hash_225157') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000045', 'hash_467084') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000045', 'hash_628180') ON CONFLICT DO NOTHING;
-- Laporan 46
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000046',
  'RPG-SIM00046',
  'Ceceran ranting dan sampah dedaunan kering',
  'Laporan simulasi terkalibrasi untuk Ceceran ranting dan sampah dedaunan kering di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.793146, -7.564281), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-27T12:00:00.000Z',
  '2026-10-27T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000046', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000046', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-27T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000046', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-28T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000046', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-30T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000046', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-30T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000046', 'hash_777507') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000046', 'hash_397579') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000046', 'hash_578318') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000046', 'hash_865431') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000046', 'hash_949238') ON CONFLICT DO NOTHING;
-- Laporan 47
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000047',
  'RPG-SIM00047',
  'Tiang PJU berkedip dan redup saat hujan lebat',
  'Laporan simulasi terkalibrasi untuk Tiang PJU berkedip dan redup saat hujan lebat di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.826140, -7.528962), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-10-17T12:00:00.000Z',
  '2026-10-17T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000047', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-17T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000047', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-17T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000047', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-18T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000047', 'hash_299007') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000047', 'hash_148990') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000047', 'hash_981007') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000047', 'hash_267499') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000047', 'hash_457403') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000047', 'hash_573642') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000047', 'hash_831980') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000047', 'hash_925316') ON CONFLICT DO NOTHING;
-- Laporan 48
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000048',
  'RPG-SIM00048',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.804370, -7.549010), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-10-28T12:00:00.000Z',
  '2026-10-28T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000048', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-28T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000048', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-28T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000048', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-29T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_120473') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_525839') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_343916') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_739669') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_380270') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_673827') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_576334') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_583305') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_915195') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_551531') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_398959') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_758430') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_898493') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000048', 'hash_153835') ON CONFLICT DO NOTHING;
-- Laporan 49
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000049',
  'RPG-SIM00049',
  'Lampu penerangan jalan padam sudah 4 malam',
  'Laporan simulasi terkalibrasi untuk Lampu penerangan jalan padam sudah 4 malam di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.782456, -7.564213), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-10-03T12:00:00.000Z',
  '2026-10-03T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000049', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-03T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000049', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-03T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000049', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-10-03T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000049', 'hash_294103') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000049', 'hash_583514') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000049', 'hash_644597') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000049', 'hash_124205') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000049', 'hash_717736') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000049', 'hash_923811') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000049', 'hash_450922') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000049', 'hash_232987') ON CONFLICT DO NOTHING;
-- Laporan 50
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000050',
  'RPG-SIM00050',
  'Papan petunjuk rute di halte lepas bautnya',
  'Laporan simulasi terkalibrasi untuk Papan petunjuk rute di halte lepas bautnya di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.811576, -7.541254), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-08-27T12:00:00.000Z',
  '2026-08-27T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000050', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000050', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-27T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000050', 'hash_645139') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000050', 'hash_771649') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000050', 'hash_199574') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000050', 'hash_305041') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000050', 'hash_748350') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000050', 'hash_984101') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000050', 'hash_612717') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000050', 'hash_304247') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000050', 'hash_844598') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000050', 'hash_932722') ON CONFLICT DO NOTHING;
-- Laporan 51
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000051',
  'RPG-SIM00051',
  'Saluran air meluap ke badan jalan saat hujan deras',
  'Laporan simulasi terkalibrasi untuk Saluran air meluap ke badan jalan saat hujan deras di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.793035, -7.566754), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-09-27T12:00:00.000Z',
  '2026-09-27T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000051', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000051', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-27T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000051', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-09-27T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000051', 'hash_464904') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000051', 'hash_290837') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000051', 'hash_956623') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000051', 'hash_464623') ON CONFLICT DO NOTHING;
-- Laporan 52
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000052',
  'RPG-SIM00052',
  'Tutup bak kontrol drainase amblas dan pecah',
  'Laporan simulasi terkalibrasi untuk Tutup bak kontrol drainase amblas dan pecah di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.830418, -7.537218), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1584467735871-8e85353a8413?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-01T12:00:00.000Z',
  '2026-09-01T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000052', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000052', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-01T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000052', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-02T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000052', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-04T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000052', 'hash_525290') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000052', 'hash_808085') ON CONFLICT DO NOTHING;
-- Laporan 53
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000053',
  'RPG-SIM00053',
  'Timbulan sampah liar di lahan kosong pinggir jalan',
  'Laporan simulasi terkalibrasi untuk Timbulan sampah liar di lahan kosong pinggir jalan di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.850606, -7.534601), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-11-07T12:00:00.000Z',
  '2026-11-07T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000053', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-07T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000053', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-07T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000053', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-11-07T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000053', 'hash_857943') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000053', 'hash_462400') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000053', 'hash_125485') ON CONFLICT DO NOTHING;
-- Laporan 54
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000054',
  'RPG-SIM00054',
  'Tutup bak kontrol drainase amblas dan pecah',
  'Laporan simulasi terkalibrasi untuk Tutup bak kontrol drainase amblas dan pecah di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.840094, -7.553641), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1584467735871-8e85353a8413?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-25T12:00:00.000Z',
  '2026-09-25T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000054', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-25T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000054', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-25T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000054', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-26T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000054', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-28T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000054', 'hash_648850') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000054', 'hash_594991') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000054', 'hash_475785') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000054', 'hash_586847') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000054', 'hash_480013') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000054', 'hash_412939') ON CONFLICT DO NOTHING;
-- Laporan 55
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000055',
  'RPG-SIM00055',
  'Guiding block terhalang tiang utilitas',
  'Laporan simulasi terkalibrasi untuk Guiding block terhalang tiang utilitas di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.808404, -7.549005), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-11-08T12:00:00.000Z',
  '2026-11-08T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000055', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-08T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000055', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-08T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000055', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-11-09T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000055', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-11T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000055', 'kurang_puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-11-11T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000055', 'hash_316319') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000055', 'hash_317598') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000055', 'hash_353669') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000055', 'hash_958040') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000055', 'hash_687646') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000055', 'hash_779817') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000055', 'hash_465588') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000055', 'hash_601648') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000055', 'hash_974325') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000055', 'hash_725474') ON CONFLICT DO NOTHING;
-- Laporan 56
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000056',
  'RPG-SIM00056',
  'Pohon peneduh condong ke jalan rawan tumbang',
  'Laporan simulasi terkalibrasi untuk Pohon peneduh condong ke jalan rawan tumbang di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.821193, -7.532814), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-10-27T12:00:00.000Z',
  '2026-10-27T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000056', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000056', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-27T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000056', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-28T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000056', 'hash_200181') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000056', 'hash_128748') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000056', 'hash_658273') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000056', 'hash_670337') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000056', 'hash_616869') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000056', 'hash_789020') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000056', 'hash_538814') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000056', 'hash_658256') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000056', 'hash_424227') ON CONFLICT DO NOTHING;
-- Laporan 57
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000057',
  'RPG-SIM00057',
  'Lampu penerangan jalan padam sudah 4 malam',
  'Laporan simulasi terkalibrasi untuk Lampu penerangan jalan padam sudah 4 malam di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.823530, -7.531388), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-25T12:00:00.000Z',
  '2026-09-25T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000057', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-25T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000057', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-25T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000057', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-26T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000057', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-28T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000057', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-28T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_137641') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_783094') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_369885') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_768550') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_610324') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_852211') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_591673') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_394649') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_425338') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_793284') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_866770') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_314684') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000057', 'hash_902240') ON CONFLICT DO NOTHING;
-- Laporan 58
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000058',
  'RPG-SIM00058',
  'Guiding block terhalang tiang utilitas',
  'Laporan simulasi terkalibrasi untuk Guiding block terhalang tiang utilitas di wilayah Kelurahan Pasar Kliwon, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1006'),
  ST_SetSRID(ST_MakePoint(110.837540, -7.574738), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-11-01T12:00:00.000Z',
  '2026-11-01T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000058', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000058', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-01T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000058', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-11-01T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000058', 'hash_569597') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000058', 'hash_220668') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000058', 'hash_194715') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000058', 'hash_849522') ON CONFLICT DO NOTHING;
-- Laporan 59
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000059',
  'RPG-SIM00059',
  'Timbulan sampah liar di lahan kosong pinggir jalan',
  'Laporan simulasi terkalibrasi untuk Timbulan sampah liar di lahan kosong pinggir jalan di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.794113, -7.564664), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-29T12:00:00.000Z',
  '2026-10-29T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000059', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-29T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000059', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-29T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000059', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-30T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000059', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-01T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000059', 'biasa', 5, 'Terima kasih atas respons dan penanganannya', '2026-11-01T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000059', 'hash_940225') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000059', 'hash_852720') ON CONFLICT DO NOTHING;
-- Laporan 60
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000060',
  'RPG-SIM00060',
  'Papan petunjuk rute di halte lepas bautnya',
  'Laporan simulasi terkalibrasi untuk Papan petunjuk rute di halte lepas bautnya di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.803794, -7.546421), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-11-06T12:00:00.000Z',
  '2026-11-06T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000060', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-06T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000060', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-06T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000060', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-11-07T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000060', 'hash_473253') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000060', 'hash_328911') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000060', 'hash_338310') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000060', 'hash_155653') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000060', 'hash_639891') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000060', 'hash_811297') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000060', 'hash_419634') ON CONFLICT DO NOTHING;
-- Laporan 61
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000061',
  'RPG-SIM00061',
  'Guiding block terhalang tiang utilitas',
  'Laporan simulasi terkalibrasi untuk Guiding block terhalang tiang utilitas di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.832051, -7.540465), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-18T12:00:00.000Z',
  '2026-09-18T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000061', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-18T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000061', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-18T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000061', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-19T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000061', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-21T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000061', 'kurang_puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-21T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000061', 'hash_910455') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000061', 'hash_318322') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000061', 'hash_118974') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000061', 'hash_184236') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000061', 'hash_569678') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000061', 'hash_572556') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000061', 'hash_172545') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000061', 'hash_193251') ON CONFLICT DO NOTHING;
-- Laporan 62
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000062',
  'RPG-SIM00062',
  'Atap halte bus kota berlubang dan bocor',
  'Laporan simulasi terkalibrasi untuk Atap halte bus kota berlubang dan bocor di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.778709, -7.560955), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-10-16T12:00:00.000Z',
  '2026-10-16T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000062', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-16T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_681675') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_316461') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_469258') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_255579') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_381067') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_814731') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_945271') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_397829') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_910302') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_990276') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_444011') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_645561') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000062', 'hash_668395') ON CONFLICT DO NOTHING;
-- Laporan 63
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000063',
  'RPG-SIM00063',
  'Timbulan sampah liar di lahan kosong pinggir jalan',
  'Laporan simulasi terkalibrasi untuk Timbulan sampah liar di lahan kosong pinggir jalan di wilayah Kelurahan Pasar Kliwon, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1006'),
  ST_SetSRID(ST_MakePoint(110.837340, -7.571673), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-10-23T12:00:00.000Z',
  '2026-10-23T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000063', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-23T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000063', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-23T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000063', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-24T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000063', 'hash_551851') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000063', 'hash_834927') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000063', 'hash_935129') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000063', 'hash_266871') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000063', 'hash_158540') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000063', 'hash_127557') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000063', 'hash_183393') ON CONFLICT DO NOTHING;
-- Laporan 64
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000064',
  'RPG-SIM00064',
  'Papan petunjuk rute di halte lepas bautnya',
  'Laporan simulasi terkalibrasi untuk Papan petunjuk rute di halte lepas bautnya di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.819788, -7.533436), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-09-20T12:00:00.000Z',
  '2026-09-20T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000064', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-20T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000064', 'hash_717348') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000064', 'hash_654226') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000064', 'hash_940593') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000064', 'hash_729740') ON CONFLICT DO NOTHING;
-- Laporan 65
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000065',
  'RPG-SIM00065',
  'Endapan lumpur tebal di saluran drainase pemukiman',
  'Laporan simulasi terkalibrasi untuk Endapan lumpur tebal di saluran drainase pemukiman di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.810430, -7.578493), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-10-23T12:00:00.000Z',
  '2026-10-23T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000065', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-23T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_901886') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_260047') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_247914') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_525011') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_461612') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_740872') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_951910') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_148184') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_704077') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_928984') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_374118') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_320136') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000065', 'hash_247665') ON CONFLICT DO NOTHING;
-- Laporan 66
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000066',
  'RPG-SIM00066',
  'Saluran air meluap ke badan jalan saat hujan deras',
  'Laporan simulasi terkalibrasi untuk Saluran air meluap ke badan jalan saat hujan deras di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.812742, -7.541561), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1584467735871-8e85353a8413?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-21T12:00:00.000Z',
  '2026-09-21T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000066', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-21T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000066', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-21T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000066', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-22T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000066', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-24T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000066', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-24T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000066', 'hash_905092') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000066', 'hash_820054') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000066', 'hash_659435') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000066', 'hash_308986') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000066', 'hash_187494') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000066', 'hash_287140') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000066', 'hash_155637') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000066', 'hash_159244') ON CONFLICT DO NOTHING;
-- Laporan 67
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000067',
  'RPG-SIM00067',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.854217, -7.527445), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-13T12:00:00.000Z',
  '2026-10-13T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000067', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-13T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000067', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-13T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000067', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-14T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000067', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-16T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000067', 'hash_282924') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000067', 'hash_910464') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000067', 'hash_913057') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000067', 'hash_688697') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000067', 'hash_131439') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000067', 'hash_301834') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000067', 'hash_286558') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000067', 'hash_234544') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000067', 'hash_361284') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000067', 'hash_542264') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000067', 'hash_409714') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000067', 'hash_511068') ON CONFLICT DO NOTHING;
-- Laporan 68
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000068',
  'RPG-SIM00068',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.809242, -7.561978), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-08-24T12:00:00.000Z',
  '2026-08-24T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000068', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-24T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000068', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-24T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000068', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-25T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000068', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-27T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000068', 'biasa', 5, 'Terima kasih atas respons dan penanganannya', '2026-08-27T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000068', 'hash_384992') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000068', 'hash_521025') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000068', 'hash_214796') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000068', 'hash_514694') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000068', 'hash_328500') ON CONFLICT DO NOTHING;
-- Laporan 69
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000069',
  'RPG-SIM00069',
  'Endapan lumpur tebal di saluran drainase pemukiman',
  'Laporan simulasi terkalibrasi untuk Endapan lumpur tebal di saluran drainase pemukiman di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.856537, -7.560882), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-10-10T12:00:00.000Z',
  '2026-10-10T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000069', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-10T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000069', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-10T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000069', 'hash_248897') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000069', 'hash_885649') ON CONFLICT DO NOTHING;
-- Laporan 70
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000070',
  'RPG-SIM00070',
  'Atap halte bus kota berlubang dan bocor',
  'Laporan simulasi terkalibrasi untuk Atap halte bus kota berlubang dan bocor di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.831671, -7.545621), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-04T12:00:00.000Z',
  '2026-09-04T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000070', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-04T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000070', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-04T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000070', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-05T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000070', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-07T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000070', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-07T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_279558') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_247999') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_767710') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_168433') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_583401') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_362174') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_815822') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_712306') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_628291') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_172766') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_681370') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_542479') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000070', 'hash_666910') ON CONFLICT DO NOTHING;
-- Laporan 71
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000071',
  'RPG-SIM00071',
  'Penurunan aspal di sekitar penutup gorong-gorong',
  'Laporan simulasi terkalibrasi untuk Penurunan aspal di sekitar penutup gorong-gorong di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.777083, -7.572314), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-08-25T12:00:00.000Z',
  '2026-08-25T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000071', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-25T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000071', 'hash_968677') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000071', 'hash_208900') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000071', 'hash_195011') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000071', 'hash_636289') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000071', 'hash_467371') ON CONFLICT DO NOTHING;
-- Laporan 72
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000072',
  'RPG-SIM00072',
  'Saluran air tersumbat material sampah dan ranting',
  'Laporan simulasi terkalibrasi untuk Saluran air tersumbat material sampah dan ranting di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.863172, -7.545561), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1584467735871-8e85353a8413?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-04T12:00:00.000Z',
  '2026-10-04T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000072', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-04T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000072', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-04T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000072', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-05T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000072', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-07T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000072', 'biasa', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-07T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000072', 'hash_883493') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000072', 'hash_885559') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000072', 'hash_311353') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000072', 'hash_261516') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000072', 'hash_945433') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000072', 'hash_313292') ON CONFLICT DO NOTHING;
-- Laporan 73
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000073',
  'RPG-SIM00073',
  'Tiang PJU berkedip dan redup saat hujan lebat',
  'Laporan simulasi terkalibrasi untuk Tiang PJU berkedip dan redup saat hujan lebat di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.800808, -7.557039), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-08-26T12:00:00.000Z',
  '2026-08-26T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000073', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-26T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000073', 'hash_100915') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000073', 'hash_787520') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000073', 'hash_312194') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000073', 'hash_243515') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000073', 'hash_977737') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000073', 'hash_252780') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000073', 'hash_309222') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000073', 'hash_916289') ON CONFLICT DO NOTHING;
-- Laporan 74
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000074',
  'RPG-SIM00074',
  'Timbulan sampah liar di lahan kosong pinggir jalan',
  'Laporan simulasi terkalibrasi untuk Timbulan sampah liar di lahan kosong pinggir jalan di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.847042, -7.550894), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-09-20T12:00:00.000Z',
  '2026-09-20T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000074', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-20T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000074', 'hash_516599') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000074', 'hash_850317') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000074', 'hash_239463') ON CONFLICT DO NOTHING;
-- Laporan 75
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000075',
  'RPG-SIM00075',
  'Ramp kursi roda terlalu curam dan licin',
  'Laporan simulasi terkalibrasi untuk Ramp kursi roda terlalu curam dan licin di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.852706, -7.586873), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-09-12T12:00:00.000Z',
  '2026-09-12T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000075', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-12T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000075', 'hash_204941') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000075', 'hash_719880') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000075', 'hash_230368') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000075', 'hash_193070') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000075', 'hash_368050') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000075', 'hash_144603') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000075', 'hash_965151') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000075', 'hash_714614') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000075', 'hash_333906') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000075', 'hash_742406') ON CONFLICT DO NOTHING;
-- Laporan 76
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000076',
  'RPG-SIM00076',
  'Bohlam lampu penerangan jalan putus di gang masuk',
  'Laporan simulasi terkalibrasi untuk Bohlam lampu penerangan jalan putus di gang masuk di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.820491, -7.528080), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-22T12:00:00.000Z',
  '2026-10-22T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000076', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-22T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000076', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-22T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000076', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-23T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000076', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-25T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000076', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-25T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000076', 'hash_460375') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000076', 'hash_864916') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000076', 'hash_605256') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000076', 'hash_187855') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000076', 'hash_283101') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000076', 'hash_428029') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000076', 'hash_486881') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000076', 'hash_550426') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000076', 'hash_358691') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000076', 'hash_986245') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000076', 'hash_393049') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000076', 'hash_890375') ON CONFLICT DO NOTHING;
-- Laporan 77
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000077',
  'RPG-SIM00077',
  'Guiding block terhalang tiang utilitas',
  'Laporan simulasi terkalibrasi untuk Guiding block terhalang tiang utilitas di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.813965, -7.529803), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-11-05T12:00:00.000Z',
  '2026-11-05T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000077', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-05T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000077', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-05T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000077', 'hash_488336') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000077', 'hash_561041') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000077', 'hash_750680') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000077', 'hash_602484') ON CONFLICT DO NOTHING;
-- Laporan 78
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000078',
  'RPG-SIM00078',
  'Penurunan aspal di sekitar penutup gorong-gorong',
  'Laporan simulasi terkalibrasi untuk Penurunan aspal di sekitar penutup gorong-gorong di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.805723, -7.552473), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-09-29T12:00:00.000Z',
  '2026-09-29T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000078', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-29T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000078', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-29T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000078', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-30T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000078', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-02T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000078', 'kurang_puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-02T23:20:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000078', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-10-03T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000078', 'hash_694825') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000078', 'hash_337301') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000078', 'hash_876252') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000078', 'hash_229285') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000078', 'hash_371232') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000078', 'hash_360530') ON CONFLICT DO NOTHING;
-- Laporan 79
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000079',
  'RPG-SIM00079',
  'Tiang PJU berkedip dan redup saat hujan lebat',
  'Laporan simulasi terkalibrasi untuk Tiang PJU berkedip dan redup saat hujan lebat di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.826367, -7.541273), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-09T12:00:00.000Z',
  '2026-10-09T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000079', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-09T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000079', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-09T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000079', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-10T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000079', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-12T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000079', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-12T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000079', 'hash_513843') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000079', 'hash_179484') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000079', 'hash_805376') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000079', 'hash_932202') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000079', 'hash_655981') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000079', 'hash_357309') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000079', 'hash_651418') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000079', 'hash_815653') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000079', 'hash_781947') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000079', 'hash_623106') ON CONFLICT DO NOTHING;
-- Laporan 80
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000080',
  'RPG-SIM00080',
  'Tempat pembuangan sementara meluap belum terangkut',
  'Laporan simulasi terkalibrasi untuk Tempat pembuangan sementara meluap belum terangkut di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.823372, -7.534374), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-08-21T12:00:00.000Z',
  '2026-08-21T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000080', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-21T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000080', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-21T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000080', 'hash_389679') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000080', 'hash_750787') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000080', 'hash_311684') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000080', 'hash_589840') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000080', 'hash_421783') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000080', 'hash_148183') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000080', 'hash_646905') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000080', 'hash_704958') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000080', 'hash_749903') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000080', 'hash_112410') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000080', 'hash_110104') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000080', 'hash_439369') ON CONFLICT DO NOTHING;
-- Laporan 81
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000081',
  'RPG-SIM00081',
  'Papan petunjuk rute di halte lepas bautnya',
  'Laporan simulasi terkalibrasi untuk Papan petunjuk rute di halte lepas bautnya di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.811651, -7.536457), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-03T12:00:00.000Z',
  '2026-10-03T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000081', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-03T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000081', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-03T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000081', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-04T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000081', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-06T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000081', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-06T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000081', 'hash_822534') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000081', 'hash_704555') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000081', 'hash_470804') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000081', 'hash_173954') ON CONFLICT DO NOTHING;
-- Laporan 82
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000082',
  'RPG-SIM00082',
  'Atap halte bus kota berlubang dan bocor',
  'Laporan simulasi terkalibrasi untuk Atap halte bus kota berlubang dan bocor di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.827677, -7.590671), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-05T12:00:00.000Z',
  '2026-10-05T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000082', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-05T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000082', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-05T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000082', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-06T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000082', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-08T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000082', 'biasa', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-08T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_527228') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_444456') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_802471') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_713118') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_851998') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_234719') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_337615') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_512382') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_285390') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_289558') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_394402') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_524200') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000082', 'hash_499486') ON CONFLICT DO NOTHING;
-- Laporan 83
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000083',
  'RPG-SIM00083',
  'Bohlam lampu penerangan jalan putus di gang masuk',
  'Laporan simulasi terkalibrasi untuk Bohlam lampu penerangan jalan putus di gang masuk di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.821958, -7.594996), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-23T12:00:00.000Z',
  '2026-10-23T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000083', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-23T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000083', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-23T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000083', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-24T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000083', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-26T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000083', 'hash_587347') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000083', 'hash_988322') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000083', 'hash_580763') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000083', 'hash_617189') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000083', 'hash_767039') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000083', 'hash_874814') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000083', 'hash_342584') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000083', 'hash_442176') ON CONFLICT DO NOTHING;
-- Laporan 84
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000084',
  'RPG-SIM00084',
  'Ramp kursi roda terlalu curam dan licin',
  'Laporan simulasi terkalibrasi untuk Ramp kursi roda terlalu curam dan licin di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.842335, -7.537488), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-11-05T12:00:00.000Z',
  '2026-11-05T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000084', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-05T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000084', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-05T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000084', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-11-05T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000084', 'hash_427589') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000084', 'hash_559603') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000084', 'hash_787237') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000084', 'hash_974165') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000084', 'hash_624099') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000084', 'hash_642976') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000084', 'hash_144430') ON CONFLICT DO NOTHING;
-- Laporan 85
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000085',
  'RPG-SIM00085',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.795502, -7.567224), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-11-08T12:00:00.000Z',
  '2026-11-08T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000085', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-08T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000085', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-08T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000085', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-11-09T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000085', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-11T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000085', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-11-11T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_222280') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_633658') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_157423') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_507250') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_899005') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_335499') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_469382') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_492328') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_412357') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_244516') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_219572') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_459457') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000085', 'hash_345307') ON CONFLICT DO NOTHING;
-- Laporan 86
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000086',
  'RPG-SIM00086',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.822475, -7.531459), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-09-28T12:00:00.000Z',
  '2026-09-28T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000086', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-28T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000086', 'hash_315662') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000086', 'hash_131090') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000086', 'hash_891458') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000086', 'hash_250532') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000086', 'hash_234103') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000086', 'hash_339518') ON CONFLICT DO NOTHING;
-- Laporan 87
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000087',
  'RPG-SIM00087',
  'Ceceran ranting dan sampah dedaunan kering',
  'Laporan simulasi terkalibrasi untuk Ceceran ranting dan sampah dedaunan kering di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.781298, -7.566108), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-10-04T12:00:00.000Z',
  '2026-10-04T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000087', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-04T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000087', 'hash_834516') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000087', 'hash_976987') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000087', 'hash_642307') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000087', 'hash_688396') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000087', 'hash_128146') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000087', 'hash_596054') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000087', 'hash_684243') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000087', 'hash_578336') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000087', 'hash_758145') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000087', 'hash_380014') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000087', 'hash_857356') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000087', 'hash_664072') ON CONFLICT DO NOTHING;
-- Laporan 88
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000088',
  'RPG-SIM00088',
  'Saluran air tersumbat material sampah dan ranting',
  'Laporan simulasi terkalibrasi untuk Saluran air tersumbat material sampah dan ranting di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.840141, -7.579435), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-10-19T12:00:00.000Z',
  '2026-10-19T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000088', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-19T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000088', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-19T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000088', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-20T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000088', 'hash_497175') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000088', 'hash_145226') ON CONFLICT DO NOTHING;
-- Laporan 89
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000089',
  'RPG-SIM00089',
  'Lampu jalan tertutup rimbun dahan pohon',
  'Laporan simulasi terkalibrasi untuk Lampu jalan tertutup rimbun dahan pohon di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.805519, -7.564504), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-09-09T12:00:00.000Z',
  '2026-09-09T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000089', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-09T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000089', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-09T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000089', 'hash_530373') ON CONFLICT DO NOTHING;
-- Laporan 90
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000090',
  'RPG-SIM00090',
  'Guiding block terhalang tiang utilitas',
  'Laporan simulasi terkalibrasi untuk Guiding block terhalang tiang utilitas di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.802953, -7.549544), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-11-01T12:00:00.000Z',
  '2026-11-01T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000090', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000090', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-01T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000090', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-11-02T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000090', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-04T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000090', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-11-04T23:20:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000090', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-11-05T13:13:20.000Z');
-- Laporan 91
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000091',
  'RPG-SIM00091',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.834326, -7.528807), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-09-12T12:00:00.000Z',
  '2026-09-12T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000091', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-12T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000091', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-12T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000091', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-13T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000091', 'hash_172435') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000091', 'hash_463293') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000091', 'hash_203354') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000091', 'hash_439524') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000091', 'hash_822694') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000091', 'hash_461624') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000091', 'hash_452399') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000091', 'hash_777397') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000091', 'hash_780677') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000091', 'hash_790700') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000091', 'hash_901591') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000091', 'hash_166740') ON CONFLICT DO NOTHING;
-- Laporan 92
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000092',
  'RPG-SIM00092',
  'Ramp kursi roda terlalu curam dan licin',
  'Laporan simulasi terkalibrasi untuk Ramp kursi roda terlalu curam dan licin di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.821294, -7.581093), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-05T12:00:00.000Z',
  '2026-09-05T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000092', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-05T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000092', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-05T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000092', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-06T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000092', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-08T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000092', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-08T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000092', 'hash_218170') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000092', 'hash_577853') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000092', 'hash_869029') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000092', 'hash_436953') ON CONFLICT DO NOTHING;
-- Laporan 93
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000093',
  'RPG-SIM00093',
  'Saluran air meluap ke badan jalan saat hujan deras',
  'Laporan simulasi terkalibrasi untuk Saluran air meluap ke badan jalan saat hujan deras di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.817011, -7.573059), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-09-08T12:00:00.000Z',
  '2026-09-08T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000093', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-08T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000093', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-08T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000093', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-09T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_701016') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_964419') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_911072') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_518478') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_566154') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_373893') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_408656') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_627177') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_802645') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_777825') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_750262') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_493245') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000093', 'hash_185726') ON CONFLICT DO NOTHING;
-- Laporan 94
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000094',
  'RPG-SIM00094',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.832193, -7.544883), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-25T12:00:00.000Z',
  '2026-09-25T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000094', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-25T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000094', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-25T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000094', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-26T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000094', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-28T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000094', 'hash_663762') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000094', 'hash_354015') ON CONFLICT DO NOTHING;
-- Laporan 95
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000095',
  'RPG-SIM00095',
  'Papan petunjuk rute di halte lepas bautnya',
  'Laporan simulasi terkalibrasi untuk Papan petunjuk rute di halte lepas bautnya di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.792469, -7.563910), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-12T12:00:00.000Z',
  '2026-09-12T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000095', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-12T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000095', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-12T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000095', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-13T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000095', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-15T12:00:00.000Z');
-- Laporan 96
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000096',
  'RPG-SIM00096',
  'Guiding block terhalang tiang utilitas',
  'Laporan simulasi terkalibrasi untuk Guiding block terhalang tiang utilitas di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.831010, -7.549553), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-10-29T12:00:00.000Z',
  '2026-10-29T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000096', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-29T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000096', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-29T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000096', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-10-29T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000096', 'hash_930739') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000096', 'hash_365913') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000096', 'hash_150800') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000096', 'hash_447927') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000096', 'hash_949554') ON CONFLICT DO NOTHING;
-- Laporan 97
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000097',
  'RPG-SIM00097',
  'Timbulan sampah liar di lahan kosong pinggir jalan',
  'Laporan simulasi terkalibrasi untuk Timbulan sampah liar di lahan kosong pinggir jalan di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.845844, -7.532240), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-10-27T12:00:00.000Z',
  '2026-10-27T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000097', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000097', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-27T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000097', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-28T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000097', 'hash_409875') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000097', 'hash_315612') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000097', 'hash_212591') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000097', 'hash_170920') ON CONFLICT DO NOTHING;
-- Laporan 98
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000098',
  'RPG-SIM00098',
  'Tiang PJU berkedip dan redup saat hujan lebat',
  'Laporan simulasi terkalibrasi untuk Tiang PJU berkedip dan redup saat hujan lebat di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.790270, -7.572836), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-09-03T12:00:00.000Z',
  '2026-09-03T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000098', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-03T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000098', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-03T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000098', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-04T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000098', 'hash_279838') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000098', 'hash_945362') ON CONFLICT DO NOTHING;
-- Laporan 99
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000099',
  'RPG-SIM00099',
  'Ceceran ranting dan sampah dedaunan kering',
  'Laporan simulasi terkalibrasi untuk Ceceran ranting dan sampah dedaunan kering di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.823367, -7.536551), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-02T12:00:00.000Z',
  '2026-10-02T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000099', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-02T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000099', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-02T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000099', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-03T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000099', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-05T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000099', 'kurang_puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-05T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000099', 'hash_761386') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000099', 'hash_573147') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000099', 'hash_710125') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000099', 'hash_938357') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000099', 'hash_260244') ON CONFLICT DO NOTHING;
-- Laporan 100
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000100',
  'RPG-SIM00100',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.817948, -7.542930), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-10-13T12:00:00.000Z',
  '2026-10-13T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000100', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-13T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000100', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-13T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000100', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-14T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000100', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-16T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000100', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-16T23:20:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000100', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-10-17T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000100', 'hash_400043') ON CONFLICT DO NOTHING;
-- Laporan 101
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000101',
  'RPG-SIM00101',
  'Guiding block terhalang tiang utilitas',
  'Laporan simulasi terkalibrasi untuk Guiding block terhalang tiang utilitas di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.822043, -7.548018), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-23T12:00:00.000Z',
  '2026-09-23T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000101', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-23T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000101', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-23T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000101', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-24T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000101', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-26T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000101', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-26T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000101', 'hash_463095') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000101', 'hash_383251') ON CONFLICT DO NOTHING;
-- Laporan 102
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000102',
  'RPG-SIM00102',
  'Endapan lumpur tebal di saluran drainase pemukiman',
  'Laporan simulasi terkalibrasi untuk Endapan lumpur tebal di saluran drainase pemukiman di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.819113, -7.529578), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1584467735871-8e85353a8413?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-26T12:00:00.000Z',
  '2026-09-26T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000102', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-26T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000102', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-26T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000102', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000102', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-29T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000102', 'biasa', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-29T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000102', 'hash_735162') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000102', 'hash_567424') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000102', 'hash_696058') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000102', 'hash_419428') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000102', 'hash_344804') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000102', 'hash_277695') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000102', 'hash_344798') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000102', 'hash_507641') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000102', 'hash_953552') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000102', 'hash_691414') ON CONFLICT DO NOTHING;
-- Laporan 103
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000103',
  'RPG-SIM00103',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.812396, -7.540744), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-21T12:00:00.000Z',
  '2026-09-21T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000103', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-21T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000103', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-21T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000103', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-22T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000103', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-24T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000103', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-24T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000103', 'hash_183792') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000103', 'hash_839782') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000103', 'hash_992876') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000103', 'hash_450007') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000103', 'hash_806693') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000103', 'hash_982992') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000103', 'hash_904755') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000103', 'hash_991317') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000103', 'hash_416711') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000103', 'hash_816991') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000103', 'hash_472038') ON CONFLICT DO NOTHING;
-- Laporan 104
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000104',
  'RPG-SIM00104',
  'Aspal amblas di dekat persimpangan jalan',
  'Laporan simulasi terkalibrasi untuk Aspal amblas di dekat persimpangan jalan di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.810670, -7.528788), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-09-01T12:00:00.000Z',
  '2026-09-01T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000104', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000104', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-01T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000104', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-09-01T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_238996') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_302769') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_795073') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_789617') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_984496') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_983799') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_806361') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_551346') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_839525') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_453681') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_571231') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_708120') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000104', 'hash_139754') ON CONFLICT DO NOTHING;
-- Laporan 105
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000105',
  'RPG-SIM00105',
  'Bohlam lampu penerangan jalan putus di gang masuk',
  'Laporan simulasi terkalibrasi untuk Bohlam lampu penerangan jalan putus di gang masuk di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.821631, -7.578563), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-08-18T12:00:00.000Z',
  '2026-08-18T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000105', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-18T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000105', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-18T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000105', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-19T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000105', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-21T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000105', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-08-22T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000105', 'hash_909672') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000105', 'hash_940156') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000105', 'hash_243242') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000105', 'hash_201882') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000105', 'hash_739265') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000105', 'hash_293663') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000105', 'hash_964279') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000105', 'hash_315483') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000105', 'hash_704767') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000105', 'hash_354535') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000105', 'hash_792502') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000105', 'hash_741833') ON CONFLICT DO NOTHING;
-- Laporan 106
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000106',
  'RPG-SIM00106',
  'Ramp kursi roda terlalu curam dan licin',
  'Laporan simulasi terkalibrasi untuk Ramp kursi roda terlalu curam dan licin di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.790081, -7.572028), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-11-06T12:00:00.000Z',
  '2026-11-06T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000106', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-06T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000106', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-06T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000106', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-11-06T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000106', 'hash_984959') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000106', 'hash_334281') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000106', 'hash_851997') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000106', 'hash_762656') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000106', 'hash_137565') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000106', 'hash_530865') ON CONFLICT DO NOTHING;
-- Laporan 107
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000107',
  'RPG-SIM00107',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.799584, -7.564782), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-11-09T12:00:00.000Z',
  '2026-11-09T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000107', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-09T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000107', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-09T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000107', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-11-10T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000107', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-12T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000107', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-11-12T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000107', 'hash_518943') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000107', 'hash_667156') ON CONFLICT DO NOTHING;
-- Laporan 108
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000108',
  'RPG-SIM00108',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.796508, -7.563055), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-17T12:00:00.000Z',
  '2026-09-17T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000108', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-17T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000108', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-17T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000108', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-18T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000108', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-20T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000108', 'biasa', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-20T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000108', 'hash_254035') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000108', 'hash_655693') ON CONFLICT DO NOTHING;
-- Laporan 109
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000109',
  'RPG-SIM00109',
  'Ceceran ranting dan sampah dedaunan kering',
  'Laporan simulasi terkalibrasi untuk Ceceran ranting dan sampah dedaunan kering di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.802791, -7.539347), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-11-08T12:00:00.000Z',
  '2026-11-08T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000109', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-08T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000109', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-08T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000109', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-11-09T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000109', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-11T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000109', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-11-11T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000109', 'hash_244893') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000109', 'hash_554936') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000109', 'hash_241206') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000109', 'hash_787769') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000109', 'hash_261051') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000109', 'hash_639218') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000109', 'hash_773393') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000109', 'hash_629413') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000109', 'hash_321106') ON CONFLICT DO NOTHING;
-- Laporan 110
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000110',
  'RPG-SIM00110',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.810349, -7.553014), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-17T12:00:00.000Z',
  '2026-09-17T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000110', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-17T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000110', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-17T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000110', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-18T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000110', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-20T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000110', 'hash_154250') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000110', 'hash_644356') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000110', 'hash_656357') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000110', 'hash_149831') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000110', 'hash_320994') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000110', 'hash_844745') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000110', 'hash_830340') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000110', 'hash_636888') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000110', 'hash_797391') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000110', 'hash_430540') ON CONFLICT DO NOTHING;
-- Laporan 111
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000111',
  'RPG-SIM00111',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.823056, -7.575648), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-01T12:00:00.000Z',
  '2026-10-01T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000111', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000111', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-01T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000111', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-02T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000111', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-04T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000111', 'hash_851064') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000111', 'hash_569309') ON CONFLICT DO NOTHING;
-- Laporan 112
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000112',
  'RPG-SIM00112',
  'Guiding block terhalang tiang utilitas',
  'Laporan simulasi terkalibrasi untuk Guiding block terhalang tiang utilitas di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.816919, -7.584026), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-11-05T12:00:00.000Z',
  '2026-11-05T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000112', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-05T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000112', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-05T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000112', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-11-06T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000112', 'hash_880328') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000112', 'hash_359164') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000112', 'hash_603424') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000112', 'hash_461947') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000112', 'hash_598791') ON CONFLICT DO NOTHING;
-- Laporan 113
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000113',
  'RPG-SIM00113',
  'Tempat pembuangan sementara meluap belum terangkut',
  'Laporan simulasi terkalibrasi untuk Tempat pembuangan sementara meluap belum terangkut di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.807080, -7.555074), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-08-17T12:00:00.000Z',
  '2026-08-17T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000113', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-17T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000113', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-17T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000113', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-18T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000113', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-20T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000113', 'kurang_puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-08-20T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000113', 'hash_124741') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000113', 'hash_397441') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000113', 'hash_968538') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000113', 'hash_353623') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000113', 'hash_781904') ON CONFLICT DO NOTHING;
-- Laporan 114
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000114',
  'RPG-SIM00114',
  'Saluran air tersumbat material sampah dan ranting',
  'Laporan simulasi terkalibrasi untuk Saluran air tersumbat material sampah dan ranting di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.847925, -7.581218), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-11-06T12:00:00.000Z',
  '2026-11-06T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000114', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-06T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000114', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-06T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000114', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-11-07T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_598653') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_578860') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_142926') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_547170') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_491726') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_642227') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_765871') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_923704') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_782723') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_523228') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_629586') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_389378') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_996093') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000114', 'hash_814040') ON CONFLICT DO NOTHING;
-- Laporan 115
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000115',
  'RPG-SIM00115',
  'Atap halte bus kota berlubang dan bocor',
  'Laporan simulasi terkalibrasi untuk Atap halte bus kota berlubang dan bocor di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.827603, -7.588707), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-17T12:00:00.000Z',
  '2026-09-17T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000115', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-17T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000115', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-17T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000115', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-18T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000115', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-20T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000115', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-20T23:20:00.000Z');
-- Laporan 116
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000116',
  'RPG-SIM00116',
  'Penurunan aspal di sekitar penutup gorong-gorong',
  'Laporan simulasi terkalibrasi untuk Penurunan aspal di sekitar penutup gorong-gorong di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.823587, -7.584005), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-15T12:00:00.000Z',
  '2026-09-15T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000116', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-15T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000116', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-15T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000116', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-16T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000116', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-18T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000116', 'kurang_puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-18T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000116', 'hash_189746') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000116', 'hash_781607') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000116', 'hash_599165') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000116', 'hash_103009') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000116', 'hash_471598') ON CONFLICT DO NOTHING;
-- Laporan 117
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000117',
  'RPG-SIM00117',
  'Atap halte bus kota berlubang dan bocor',
  'Laporan simulasi terkalibrasi untuk Atap halte bus kota berlubang dan bocor di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.826308, -7.534808), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-08-15T12:00:00.000Z',
  '2026-08-15T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000117', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-15T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000117', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-15T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000117', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-16T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000117', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-18T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000117', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-08-19T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000117', 'hash_730012') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000117', 'hash_192964') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000117', 'hash_186047') ON CONFLICT DO NOTHING;
-- Laporan 118
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000118',
  'RPG-SIM00118',
  'Bohlam lampu penerangan jalan putus di gang masuk',
  'Laporan simulasi terkalibrasi untuk Bohlam lampu penerangan jalan putus di gang masuk di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.818822, -7.583505), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-10-08T12:00:00.000Z',
  '2026-10-08T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000118', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-08T12:00:00.000Z');
-- Laporan 119
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000119',
  'RPG-SIM00119',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.832965, -7.544891), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-08-25T12:00:00.000Z',
  '2026-08-25T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000119', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-25T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000119', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-25T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000119', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-26T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000119', 'hash_958093') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000119', 'hash_324970') ON CONFLICT DO NOTHING;
-- Laporan 120
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000120',
  'RPG-SIM00120',
  'Bohlam lampu penerangan jalan putus di gang masuk',
  'Laporan simulasi terkalibrasi untuk Bohlam lampu penerangan jalan putus di gang masuk di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.850300, -7.536438), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-08-20T12:00:00.000Z',
  '2026-08-20T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000120', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-20T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000120', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-20T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000120', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-21T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000120', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-23T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000120', 'biasa', 5, 'Terima kasih atas respons dan penanganannya', '2026-08-23T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000120', 'hash_340547') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000120', 'hash_856403') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000120', 'hash_714970') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000120', 'hash_251939') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000120', 'hash_339404') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000120', 'hash_212302') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000120', 'hash_808838') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000120', 'hash_104208') ON CONFLICT DO NOTHING;
-- Laporan 121
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000121',
  'RPG-SIM00121',
  'Lampu penerangan jalan padam sudah 4 malam',
  'Laporan simulasi terkalibrasi untuk Lampu penerangan jalan padam sudah 4 malam di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.845284, -7.576854), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-10-28T12:00:00.000Z',
  '2026-10-28T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000121', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-28T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000121', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-28T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000121', 'hash_270868') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000121', 'hash_130322') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000121', 'hash_779422') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000121', 'hash_715850') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000121', 'hash_974422') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000121', 'hash_791945') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000121', 'hash_953798') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000121', 'hash_153839') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000121', 'hash_950652') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000121', 'hash_170430') ON CONFLICT DO NOTHING;
-- Laporan 122
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000122',
  'RPG-SIM00122',
  'Ceceran ranting dan sampah dedaunan kering',
  'Laporan simulasi terkalibrasi untuk Ceceran ranting dan sampah dedaunan kering di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.822632, -7.547753), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-06T12:00:00.000Z',
  '2026-10-06T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000122', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-06T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000122', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-06T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000122', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-07T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000122', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-09T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000122', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-09T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000122', 'hash_319720') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000122', 'hash_901263') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000122', 'hash_857983') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000122', 'hash_872682') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000122', 'hash_470482') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000122', 'hash_640043') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000122', 'hash_342970') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000122', 'hash_487016') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000122', 'hash_721072') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000122', 'hash_716448') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000122', 'hash_915439') ON CONFLICT DO NOTHING;
-- Laporan 123
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000123',
  'RPG-SIM00123',
  'Endapan lumpur tebal di saluran drainase pemukiman',
  'Laporan simulasi terkalibrasi untuk Endapan lumpur tebal di saluran drainase pemukiman di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.817588, -7.584357), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-09-27T12:00:00.000Z',
  '2026-09-27T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000123', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000123', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-27T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000123', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-09-27T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000123', 'hash_666568') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000123', 'hash_843701') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000123', 'hash_360355') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000123', 'hash_251316') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000123', 'hash_840889') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000123', 'hash_504867') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000123', 'hash_533823') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000123', 'hash_386206') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000123', 'hash_812003') ON CONFLICT DO NOTHING;
-- Laporan 124
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000124',
  'RPG-SIM00124',
  'Atap halte bus kota berlubang dan bocor',
  'Laporan simulasi terkalibrasi untuk Atap halte bus kota berlubang dan bocor di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.797629, -7.543890), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-10-01T12:00:00.000Z',
  '2026-10-01T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000124', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000124', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-01T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000124', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-02T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_228956') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_204787') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_963979') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_573728') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_309593') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_760858') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_836379') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_435992') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_501951') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_440459') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_321773') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_902692') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_464167') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000124', 'hash_348274') ON CONFLICT DO NOTHING;
-- Laporan 125
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000125',
  'RPG-SIM00125',
  'Tiang PJU berkedip dan redup saat hujan lebat',
  'Laporan simulasi terkalibrasi untuk Tiang PJU berkedip dan redup saat hujan lebat di wilayah Kelurahan Pasar Kliwon, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1006'),
  ST_SetSRID(ST_MakePoint(110.825714, -7.577139), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-08-24T12:00:00.000Z',
  '2026-08-24T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000125', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-24T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000125', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-24T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000125', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-25T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000125', 'hash_721839') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000125', 'hash_777001') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000125', 'hash_526434') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000125', 'hash_951330') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000125', 'hash_728758') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000125', 'hash_317836') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000125', 'hash_158822') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000125', 'hash_131466') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000125', 'hash_342717') ON CONFLICT DO NOTHING;
-- Laporan 126
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000126',
  'RPG-SIM00126',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.857642, -7.550784), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-13T12:00:00.000Z',
  '2026-10-13T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000126', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-13T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000126', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-13T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000126', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-14T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000126', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-16T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000126', 'hash_520636') ON CONFLICT DO NOTHING;
-- Laporan 127
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000127',
  'RPG-SIM00127',
  'Atap halte bus kota berlubang dan bocor',
  'Laporan simulasi terkalibrasi untuk Atap halte bus kota berlubang dan bocor di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.804697, -7.569630), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-09-16T12:00:00.000Z',
  '2026-09-16T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000127', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-16T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000127', 'hash_434904') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000127', 'hash_438352') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000127', 'hash_395026') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000127', 'hash_771847') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000127', 'hash_675728') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000127', 'hash_678480') ON CONFLICT DO NOTHING;
-- Laporan 128
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000128',
  'RPG-SIM00128',
  'Ramp kursi roda terlalu curam dan licin',
  'Laporan simulasi terkalibrasi untuk Ramp kursi roda terlalu curam dan licin di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.803406, -7.567256), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-08-23T12:00:00.000Z',
  '2026-08-23T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000128', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-23T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000128', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-23T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000128', 'hash_407254') ON CONFLICT DO NOTHING;
-- Laporan 129
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000129',
  'RPG-SIM00129',
  'Tempat pembuangan sementara meluap belum terangkut',
  'Laporan simulasi terkalibrasi untuk Tempat pembuangan sementara meluap belum terangkut di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.844493, -7.535430), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-08-20T12:00:00.000Z',
  '2026-08-20T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000129', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-20T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000129', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-20T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000129', 'hash_568803') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000129', 'hash_587394') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000129', 'hash_339487') ON CONFLICT DO NOTHING;
-- Laporan 130
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000130',
  'RPG-SIM00130',
  'Tiang PJU berkedip dan redup saat hujan lebat',
  'Laporan simulasi terkalibrasi untuk Tiang PJU berkedip dan redup saat hujan lebat di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.807107, -7.557353), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-08-26T12:00:00.000Z',
  '2026-08-26T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000130', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-26T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000130', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-26T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000130', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000130', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-29T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000130', 'hash_503797') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000130', 'hash_212774') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000130', 'hash_297324') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000130', 'hash_423454') ON CONFLICT DO NOTHING;
-- Laporan 131
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000131',
  'RPG-SIM00131',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.787926, -7.571636), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-27T12:00:00.000Z',
  '2026-10-27T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000131', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000131', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-27T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000131', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-28T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000131', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-30T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000131', 'hash_388838') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000131', 'hash_896459') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000131', 'hash_725039') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000131', 'hash_644757') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000131', 'hash_374276') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000131', 'hash_765674') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000131', 'hash_425644') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000131', 'hash_511089') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000131', 'hash_339671') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000131', 'hash_166476') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000131', 'hash_408632') ON CONFLICT DO NOTHING;
-- Laporan 132
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000132',
  'RPG-SIM00132',
  'Tiang PJU berkedip dan redup saat hujan lebat',
  'Laporan simulasi terkalibrasi untuk Tiang PJU berkedip dan redup saat hujan lebat di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.786716, -7.561355), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-01T12:00:00.000Z',
  '2026-09-01T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000132', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000132', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-01T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000132', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-02T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000132', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-04T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000132', 'hash_997460') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000132', 'hash_384999') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000132', 'hash_432287') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000132', 'hash_167935') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000132', 'hash_553901') ON CONFLICT DO NOTHING;
-- Laporan 133
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000133',
  'RPG-SIM00133',
  'Penurunan aspal di sekitar penutup gorong-gorong',
  'Laporan simulasi terkalibrasi untuk Penurunan aspal di sekitar penutup gorong-gorong di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.819267, -7.584011), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-11T12:00:00.000Z',
  '2026-10-11T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000133', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-11T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000133', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-11T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000133', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-12T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000133', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-14T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000133', 'hash_340675') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000133', 'hash_523781') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000133', 'hash_984248') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000133', 'hash_723451') ON CONFLICT DO NOTHING;
-- Laporan 134
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000134',
  'RPG-SIM00134',
  'Aspal amblas di dekat persimpangan jalan',
  'Laporan simulasi terkalibrasi untuk Aspal amblas di dekat persimpangan jalan di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.796403, -7.565220), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-10-29T12:00:00.000Z',
  '2026-10-29T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000134', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-29T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000134', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-29T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000134', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-30T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000134', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000134', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-11-02T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000134', 'hash_913349') ON CONFLICT DO NOTHING;
-- Laporan 135
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000135',
  'RPG-SIM00135',
  'Aspal amblas di dekat persimpangan jalan',
  'Laporan simulasi terkalibrasi untuk Aspal amblas di dekat persimpangan jalan di wilayah Kelurahan Pasar Kliwon, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1006'),
  ST_SetSRID(ST_MakePoint(110.834293, -7.574170), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-08-17T12:00:00.000Z',
  '2026-08-17T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000135', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-17T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000135', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-17T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000135', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-18T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000135', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-20T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000135', 'kurang_puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-08-20T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000135', 'hash_122219') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000135', 'hash_656753') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000135', 'hash_159283') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000135', 'hash_688602') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000135', 'hash_845390') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000135', 'hash_130968') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000135', 'hash_621565') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000135', 'hash_678510') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000135', 'hash_892728') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000135', 'hash_206509') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000135', 'hash_801477') ON CONFLICT DO NOTHING;
-- Laporan 136
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000136',
  'RPG-SIM00136',
  'Saluran air tersumbat material sampah dan ranting',
  'Laporan simulasi terkalibrasi untuk Saluran air tersumbat material sampah dan ranting di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.832264, -7.535253), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-10-11T12:00:00.000Z',
  '2026-10-11T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000136', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-11T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000136', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-11T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000136', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-10-11T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000136', 'hash_611726') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000136', 'hash_657513') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000136', 'hash_985635') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000136', 'hash_943618') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000136', 'hash_424314') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000136', 'hash_678806') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000136', 'hash_915763') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000136', 'hash_845710') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000136', 'hash_120594') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000136', 'hash_651595') ON CONFLICT DO NOTHING;
-- Laporan 137
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000137',
  'RPG-SIM00137',
  'Saluran air tersumbat material sampah dan ranting',
  'Laporan simulasi terkalibrasi untuk Saluran air tersumbat material sampah dan ranting di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.807595, -7.557747), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-08-14T12:00:00.000Z',
  '2026-08-14T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000137', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-14T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000137', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-14T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000137', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-08-14T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_900630') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_331786') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_473674') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_277939') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_811206') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_840317') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_378119') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_782882') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_212554') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_276649') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_635535') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_468243') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000137', 'hash_471065') ON CONFLICT DO NOTHING;
-- Laporan 138
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000138',
  'RPG-SIM00138',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.820151, -7.529314), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-09-22T12:00:00.000Z',
  '2026-09-22T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000138', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-22T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000138', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-22T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000138', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-23T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000138', 'hash_348590') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000138', 'hash_986582') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000138', 'hash_248423') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000138', 'hash_530268') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000138', 'hash_979857') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000138', 'hash_330998') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000138', 'hash_459944') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000138', 'hash_538161') ON CONFLICT DO NOTHING;
-- Laporan 139
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000139',
  'RPG-SIM00139',
  'Pohon peneduh condong ke jalan rawan tumbang',
  'Laporan simulasi terkalibrasi untuk Pohon peneduh condong ke jalan rawan tumbang di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.816294, -7.548933), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-28T12:00:00.000Z',
  '2026-09-28T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000139', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-28T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000139', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-28T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000139', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-29T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000139', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-01T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000139', 'hash_290174') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000139', 'hash_904163') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000139', 'hash_519083') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000139', 'hash_870386') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000139', 'hash_412794') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000139', 'hash_389902') ON CONFLICT DO NOTHING;
-- Laporan 140
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000140',
  'RPG-SIM00140',
  'Bohlam lampu penerangan jalan putus di gang masuk',
  'Laporan simulasi terkalibrasi untuk Bohlam lampu penerangan jalan putus di gang masuk di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.841359, -7.585593), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-09-21T12:00:00.000Z',
  '2026-09-21T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000140', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-21T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000140', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-21T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000140', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-22T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000140', 'hash_198582') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000140', 'hash_331393') ON CONFLICT DO NOTHING;
-- Laporan 141
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000141',
  'RPG-SIM00141',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.823614, -7.572914), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-10-03T12:00:00.000Z',
  '2026-10-03T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000141', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-03T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000141', 'hash_842767') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000141', 'hash_842347') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000141', 'hash_401569') ON CONFLICT DO NOTHING;
-- Laporan 142
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000142',
  'RPG-SIM00142',
  'Ramp kursi roda terlalu curam dan licin',
  'Laporan simulasi terkalibrasi untuk Ramp kursi roda terlalu curam dan licin di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.860984, -7.564645), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-10-01T12:00:00.000Z',
  '2026-10-01T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000142', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000142', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-01T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000142', 'hash_248151') ON CONFLICT DO NOTHING;
-- Laporan 143
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000143',
  'RPG-SIM00143',
  'Pohon peneduh condong ke jalan rawan tumbang',
  'Laporan simulasi terkalibrasi untuk Pohon peneduh condong ke jalan rawan tumbang di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.789664, -7.568912), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-27T12:00:00.000Z',
  '2026-09-27T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000143', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000143', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-27T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000143', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-28T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000143', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-30T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000143', 'kurang_puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-30T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000143', 'hash_814837') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000143', 'hash_630420') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000143', 'hash_484761') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000143', 'hash_471414') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000143', 'hash_697184') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000143', 'hash_228836') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000143', 'hash_744179') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000143', 'hash_162654') ON CONFLICT DO NOTHING;
-- Laporan 144
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000144',
  'RPG-SIM00144',
  'Aspal amblas di dekat persimpangan jalan',
  'Laporan simulasi terkalibrasi untuk Aspal amblas di dekat persimpangan jalan di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.811203, -7.566422), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-09-09T12:00:00.000Z',
  '2026-09-09T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000144', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-09T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000144', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-09T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000144', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-09-09T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000144', 'hash_971422') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000144', 'hash_488515') ON CONFLICT DO NOTHING;
-- Laporan 145
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000145',
  'RPG-SIM00145',
  'Aspal amblas di dekat persimpangan jalan',
  'Laporan simulasi terkalibrasi untuk Aspal amblas di dekat persimpangan jalan di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.840760, -7.585916), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-28T12:00:00.000Z',
  '2026-09-28T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000145', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-28T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000145', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-28T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000145', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-29T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000145', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-01T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000145', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-01T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000145', 'hash_648079') ON CONFLICT DO NOTHING;
-- Laporan 146
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000146',
  'RPG-SIM00146',
  'Guiding block terhalang tiang utilitas',
  'Laporan simulasi terkalibrasi untuk Guiding block terhalang tiang utilitas di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.835013, -7.579316), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-15T12:00:00.000Z',
  '2026-09-15T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000146', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-15T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000146', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-15T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000146', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-16T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000146', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-18T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_677613') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_883125') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_814828') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_603355') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_187963') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_737680') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_931670') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_122796') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_491547') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_395661') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_457042') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_495933') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000146', 'hash_713933') ON CONFLICT DO NOTHING;
-- Laporan 147
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000147',
  'RPG-SIM00147',
  'Lampu jalan tertutup rimbun dahan pohon',
  'Laporan simulasi terkalibrasi untuk Lampu jalan tertutup rimbun dahan pohon di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.845114, -7.564514), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-20T12:00:00.000Z',
  '2026-10-20T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000147', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-20T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000147', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-20T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000147', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-21T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000147', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-23T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000147', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-23T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000147', 'hash_817785') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000147', 'hash_687630') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000147', 'hash_417384') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000147', 'hash_837731') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000147', 'hash_272578') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000147', 'hash_533214') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000147', 'hash_668183') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000147', 'hash_468319') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000147', 'hash_412646') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000147', 'hash_418104') ON CONFLICT DO NOTHING;
-- Laporan 148
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000148',
  'RPG-SIM00148',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.824250, -7.536468), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-10-31T12:00:00.000Z',
  '2026-10-31T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000148', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-31T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000148', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-31T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_449838') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_885739') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_203749') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_945246') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_687265') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_709595') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_246566') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_840132') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_150857') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_904089') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_559606') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_982316') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_203643') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000148', 'hash_134964') ON CONFLICT DO NOTHING;
-- Laporan 149
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000149',
  'RPG-SIM00149',
  'Saluran air meluap ke badan jalan saat hujan deras',
  'Laporan simulasi terkalibrasi untuk Saluran air meluap ke badan jalan saat hujan deras di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.836326, -7.528097), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-08-13T12:00:00.000Z',
  '2026-08-13T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000149', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-13T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000149', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-13T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000149', 'hash_350179') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000149', 'hash_456370') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000149', 'hash_733971') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000149', 'hash_354587') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000149', 'hash_614939') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000149', 'hash_977816') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000149', 'hash_351705') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000149', 'hash_688002') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000149', 'hash_279805') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000149', 'hash_321274') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000149', 'hash_776747') ON CONFLICT DO NOTHING;
-- Laporan 150
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000150',
  'RPG-SIM00150',
  'Ceceran ranting dan sampah dedaunan kering',
  'Laporan simulasi terkalibrasi untuk Ceceran ranting dan sampah dedaunan kering di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.824325, -7.581067), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-11-09T12:00:00.000Z',
  '2026-11-09T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000150', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-09T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000150', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-09T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000150', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-11-10T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000150', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-12T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000150', 'kurang_puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-11-12T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000150', 'hash_678585') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000150', 'hash_331678') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000150', 'hash_604267') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000150', 'hash_605741') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000150', 'hash_412024') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000150', 'hash_683722') ON CONFLICT DO NOTHING;
-- Laporan 151
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000151',
  'RPG-SIM00151',
  'Lampu penerangan jalan padam sudah 4 malam',
  'Laporan simulasi terkalibrasi untuk Lampu penerangan jalan padam sudah 4 malam di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.825040, -7.593093), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-09-29T12:00:00.000Z',
  '2026-09-29T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000151', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-29T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000151', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-29T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000151', 'hash_527606') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000151', 'hash_683840') ON CONFLICT DO NOTHING;
-- Laporan 152
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000152',
  'RPG-SIM00152',
  'Atap halte bus kota berlubang dan bocor',
  'Laporan simulasi terkalibrasi untuk Atap halte bus kota berlubang dan bocor di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.820230, -7.581938), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-01T12:00:00.000Z',
  '2026-09-01T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000152', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000152', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-01T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000152', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-02T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000152', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-04T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000152', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-04T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000152', 'hash_729672') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000152', 'hash_967643') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000152', 'hash_425608') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000152', 'hash_391234') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000152', 'hash_930779') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000152', 'hash_270625') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000152', 'hash_563890') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000152', 'hash_310363') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000152', 'hash_761733') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000152', 'hash_824473') ON CONFLICT DO NOTHING;
-- Laporan 153
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000153',
  'RPG-SIM00153',
  'Ceceran ranting dan sampah dedaunan kering',
  'Laporan simulasi terkalibrasi untuk Ceceran ranting dan sampah dedaunan kering di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.813690, -7.556403), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-10-25T12:00:00.000Z',
  '2026-10-25T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000153', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-25T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000153', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-25T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000153', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-10-25T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000153', 'hash_543519') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000153', 'hash_537484') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000153', 'hash_910653') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000153', 'hash_249266') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000153', 'hash_467080') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000153', 'hash_421274') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000153', 'hash_969906') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000153', 'hash_526746') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000153', 'hash_756337') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000153', 'hash_325057') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000153', 'hash_373035') ON CONFLICT DO NOTHING;
-- Laporan 154
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000154',
  'RPG-SIM00154',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.816045, -7.548803), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-08-31T12:00:00.000Z',
  '2026-08-31T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000154', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-31T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000154', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-31T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000154', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000154', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-03T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000154', 'hash_103374') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000154', 'hash_272479') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000154', 'hash_254904') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000154', 'hash_802405') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000154', 'hash_945093') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000154', 'hash_525050') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000154', 'hash_139189') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000154', 'hash_170051') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000154', 'hash_179261') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000154', 'hash_195368') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000154', 'hash_679800') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000154', 'hash_919832') ON CONFLICT DO NOTHING;
-- Laporan 155
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000155',
  'RPG-SIM00155',
  'Saluran air tersumbat material sampah dan ranting',
  'Laporan simulasi terkalibrasi untuk Saluran air tersumbat material sampah dan ranting di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.833407, -7.539538), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-08-27T12:00:00.000Z',
  '2026-08-27T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000155', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000155', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-27T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000155', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-28T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000155', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-30T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000155', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-08-31T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000155', 'hash_108149') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000155', 'hash_779338') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000155', 'hash_412785') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000155', 'hash_234831') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000155', 'hash_683057') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000155', 'hash_210431') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000155', 'hash_403352') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000155', 'hash_340727') ON CONFLICT DO NOTHING;
-- Laporan 156
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000156',
  'RPG-SIM00156',
  'Guiding block terhalang tiang utilitas',
  'Laporan simulasi terkalibrasi untuk Guiding block terhalang tiang utilitas di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.818897, -7.533401), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-09-19T12:00:00.000Z',
  '2026-09-19T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000156', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-19T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000156', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-19T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000156', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-09-19T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_638401') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_373431') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_423071') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_716593') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_706863') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_474629') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_148477') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_228925') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_685689') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_214748') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_997527') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_531648') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000156', 'hash_402791') ON CONFLICT DO NOTHING;
-- Laporan 157
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000157',
  'RPG-SIM00157',
  'Bohlam lampu penerangan jalan putus di gang masuk',
  'Laporan simulasi terkalibrasi untuk Bohlam lampu penerangan jalan putus di gang masuk di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.804085, -7.549650), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-10-29T12:00:00.000Z',
  '2026-10-29T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000157', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-29T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000157', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-29T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000157', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-10-29T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000157', 'hash_776875') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000157', 'hash_505941') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000157', 'hash_741218') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000157', 'hash_254870') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000157', 'hash_663106') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000157', 'hash_216079') ON CONFLICT DO NOTHING;
-- Laporan 158
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000158',
  'RPG-SIM00158',
  'Penurunan aspal di sekitar penutup gorong-gorong',
  'Laporan simulasi terkalibrasi untuk Penurunan aspal di sekitar penutup gorong-gorong di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.791599, -7.563350), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-10-23T12:00:00.000Z',
  '2026-10-23T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000158', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-23T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000158', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-23T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000158', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-10-23T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000158', 'hash_472308') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000158', 'hash_858527') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000158', 'hash_895703') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000158', 'hash_150312') ON CONFLICT DO NOTHING;
-- Laporan 159
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000159',
  'RPG-SIM00159',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.805889, -7.540256), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-10-15T12:00:00.000Z',
  '2026-10-15T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000159', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-15T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000159', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-15T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000159', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-10-15T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000159', 'hash_819099') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000159', 'hash_745150') ON CONFLICT DO NOTHING;
-- Laporan 160
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000160',
  'RPG-SIM00160',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.796160, -7.539375), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-30T12:00:00.000Z',
  '2026-09-30T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000160', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-30T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000160', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-30T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000160', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-01T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000160', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-03T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000160', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-03T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000160', 'hash_281536') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000160', 'hash_104163') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000160', 'hash_177365') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000160', 'hash_928704') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000160', 'hash_791179') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000160', 'hash_709303') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000160', 'hash_958451') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000160', 'hash_248840') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000160', 'hash_118361') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000160', 'hash_704993') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000160', 'hash_234424') ON CONFLICT DO NOTHING;
-- Laporan 161
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000161',
  'RPG-SIM00161',
  'Tempat pembuangan sementara meluap belum terangkut',
  'Laporan simulasi terkalibrasi untuk Tempat pembuangan sementara meluap belum terangkut di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.820602, -7.590138), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-24T12:00:00.000Z',
  '2026-10-24T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000161', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-24T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000161', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-24T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000161', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-25T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000161', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-27T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000161', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-27T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000161', 'hash_689201') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000161', 'hash_386228') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000161', 'hash_478208') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000161', 'hash_858785') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000161', 'hash_401464') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000161', 'hash_219751') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000161', 'hash_567390') ON CONFLICT DO NOTHING;
-- Laporan 162
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000162',
  'RPG-SIM00162',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.844739, -7.577162), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-09-07T12:00:00.000Z',
  '2026-09-07T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000162', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-07T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000162', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-07T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000162', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-09-07T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000162', 'hash_648150') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000162', 'hash_287539') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000162', 'hash_614295') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000162', 'hash_129793') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000162', 'hash_199114') ON CONFLICT DO NOTHING;
-- Laporan 163
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000163',
  'RPG-SIM00163',
  'Endapan lumpur tebal di saluran drainase pemukiman',
  'Laporan simulasi terkalibrasi untuk Endapan lumpur tebal di saluran drainase pemukiman di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.859333, -7.546541), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-10-16T12:00:00.000Z',
  '2026-10-16T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000163', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-16T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000163', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-16T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000163', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-17T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000163', 'hash_663435') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000163', 'hash_258120') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000163', 'hash_328208') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000163', 'hash_950968') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000163', 'hash_832030') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000163', 'hash_977430') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000163', 'hash_753435') ON CONFLICT DO NOTHING;
-- Laporan 164
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000164',
  'RPG-SIM00164',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.817861, -7.537701), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-09-17T12:00:00.000Z',
  '2026-09-17T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000164', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-17T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000164', 'hash_971890') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000164', 'hash_357399') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000164', 'hash_444491') ON CONFLICT DO NOTHING;
-- Laporan 165
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000165',
  'RPG-SIM00165',
  'Saluran air meluap ke badan jalan saat hujan deras',
  'Laporan simulasi terkalibrasi untuk Saluran air meluap ke badan jalan saat hujan deras di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.821172, -7.572921), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-09-29T12:00:00.000Z',
  '2026-09-29T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000165', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-29T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000165', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-29T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000165', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-30T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000165', 'hash_451414') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000165', 'hash_651763') ON CONFLICT DO NOTHING;
-- Laporan 166
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000166',
  'RPG-SIM00166',
  'Guiding block terhalang tiang utilitas',
  'Laporan simulasi terkalibrasi untuk Guiding block terhalang tiang utilitas di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.799825, -7.559565), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-15T12:00:00.000Z',
  '2026-09-15T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000166', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-15T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000166', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-15T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000166', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-16T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000166', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-18T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_888937') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_427627') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_898804') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_681262') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_263097') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_853051') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_252217') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_629399') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_980677') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_515692') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_638727') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_871891') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000166', 'hash_166811') ON CONFLICT DO NOTHING;
-- Laporan 167
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000167',
  'RPG-SIM00167',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.802195, -7.545311), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-10-26T12:00:00.000Z',
  '2026-10-26T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000167', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-26T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000167', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-26T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000167', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-27T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_876331') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_736607') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_737852') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_192896') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_207777') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_251570') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_703972') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_782240') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_403318') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_168436') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_339282') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_249308') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000167', 'hash_658028') ON CONFLICT DO NOTHING;
-- Laporan 168
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000168',
  'RPG-SIM00168',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.819021, -7.536444), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-10-18T12:00:00.000Z',
  '2026-10-18T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000168', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-18T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000168', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-18T12:30:00.000Z');
-- Laporan 169
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000169',
  'RPG-SIM00169',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Pasar Kliwon, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1006'),
  ST_SetSRID(ST_MakePoint(110.826865, -7.574713), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-11-09T12:00:00.000Z',
  '2026-11-09T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000169', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-09T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000169', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-09T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000169', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-11-09T13:00:00.000Z');
-- Laporan 170
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000170',
  'RPG-SIM00170',
  'Endapan lumpur tebal di saluran drainase pemukiman',
  'Laporan simulasi terkalibrasi untuk Endapan lumpur tebal di saluran drainase pemukiman di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.808308, -7.566536), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1584467735871-8e85353a8413?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-08-26T12:00:00.000Z',
  '2026-08-26T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000170', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-26T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000170', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-26T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000170', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-27T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000170', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-29T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000170', 'hash_951497') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000170', 'hash_475523') ON CONFLICT DO NOTHING;
-- Laporan 171
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000171',
  'RPG-SIM00171',
  'Papan petunjuk rute di halte lepas bautnya',
  'Laporan simulasi terkalibrasi untuk Papan petunjuk rute di halte lepas bautnya di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.809653, -7.553907), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-08-31T12:00:00.000Z',
  '2026-08-31T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000171', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-31T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000171', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-31T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000171', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-08-31T13:00:00.000Z');
-- Laporan 172
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000172',
  'RPG-SIM00172',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.813524, -7.559844), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-03T12:00:00.000Z',
  '2026-09-03T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000172', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-03T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000172', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-03T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000172', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-04T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000172', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-06T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000172', 'kurang_puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-06T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_837561') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_371359') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_430439') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_772675') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_334690') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_513852') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_305205') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_191910') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_432092') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_320935') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_206097') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_504367') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_543964') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000172', 'hash_112505') ON CONFLICT DO NOTHING;
-- Laporan 173
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000173',
  'RPG-SIM00173',
  'Tutup bak kontrol drainase amblas dan pecah',
  'Laporan simulasi terkalibrasi untuk Tutup bak kontrol drainase amblas dan pecah di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.851933, -7.577960), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1584467735871-8e85353a8413?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-30T12:00:00.000Z',
  '2026-10-30T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000173', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-30T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000173', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-30T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000173', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-31T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000173', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-02T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000173', 'biasa', 5, 'Terima kasih atas respons dan penanganannya', '2026-11-02T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000173', 'hash_779081') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000173', 'hash_405452') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000173', 'hash_561060') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000173', 'hash_849899') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000173', 'hash_290276') ON CONFLICT DO NOTHING;
-- Laporan 174
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000174',
  'RPG-SIM00174',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Semanggi, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'),
  ST_SetSRID(ST_MakePoint(110.850840, -7.576957), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-14T12:00:00.000Z',
  '2026-10-14T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000174', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-14T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000174', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-14T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000174', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-15T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000174', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-17T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000174', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-17T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000174', 'hash_664161') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000174', 'hash_363991') ON CONFLICT DO NOTHING;
-- Laporan 175
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000175',
  'RPG-SIM00175',
  'Ramp kursi roda terlalu curam dan licin',
  'Laporan simulasi terkalibrasi untuk Ramp kursi roda terlalu curam dan licin di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.819441, -7.527204), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-09-20T12:00:00.000Z',
  '2026-09-20T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000175', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-20T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000175', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-20T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000175', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-09-20T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000175', 'hash_629029') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000175', 'hash_718708') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000175', 'hash_982743') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000175', 'hash_622314') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000175', 'hash_380483') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000175', 'hash_100695') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000175', 'hash_752197') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000175', 'hash_882141') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000175', 'hash_547459') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000175', 'hash_423798') ON CONFLICT DO NOTHING;
-- Laporan 176
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000176',
  'RPG-SIM00176',
  'Saluran air meluap ke badan jalan saat hujan deras',
  'Laporan simulasi terkalibrasi untuk Saluran air meluap ke badan jalan saat hujan deras di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.802659, -7.564735), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-09-14T12:00:00.000Z',
  '2026-09-14T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000176', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-14T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000176', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-14T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000176', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-15T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000176', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-17T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000176', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-17T23:20:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000176', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-09-18T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000176', 'hash_125410') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000176', 'hash_949516') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000176', 'hash_402689') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000176', 'hash_810288') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000176', 'hash_154177') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000176', 'hash_345607') ON CONFLICT DO NOTHING;
-- Laporan 177
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000177',
  'RPG-SIM00177',
  'Ceceran ranting dan sampah dedaunan kering',
  'Laporan simulasi terkalibrasi untuk Ceceran ranting dan sampah dedaunan kering di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.802712, -7.543890), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-08-27T12:00:00.000Z',
  '2026-08-27T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000177', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-27T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000177', 'hash_974026') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000177', 'hash_865077') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000177', 'hash_596971') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000177', 'hash_432026') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000177', 'hash_914499') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000177', 'hash_878354') ON CONFLICT DO NOTHING;
-- Laporan 178
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000178',
  'RPG-SIM00178',
  'Ubin pemandu (guiding block) tuna netra terputus',
  'Laporan simulasi terkalibrasi untuk Ubin pemandu (guiding block) tuna netra terputus di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.824136, -7.538328), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-03T12:00:00.000Z',
  '2026-09-03T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000178', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-03T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000178', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-03T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000178', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-04T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000178', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-06T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000178', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-06T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_567139') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_844612') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_234236') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_339715') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_622101') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_176564') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_234461') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_767053') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_604166') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_977595') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_666318') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_982259') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_786180') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000178', 'hash_296336') ON CONFLICT DO NOTHING;
-- Laporan 179
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000179',
  'RPG-SIM00179',
  'Ramp kursi roda terlalu curam dan licin',
  'Laporan simulasi terkalibrasi untuk Ramp kursi roda terlalu curam dan licin di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.801438, -7.569955), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-08-21T12:00:00.000Z',
  '2026-08-21T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000179', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-21T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000179', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-21T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_204377') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_884801') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_795256') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_350590') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_112308') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_278161') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_517626') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_338376') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_294569') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_701676') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_721689') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_896926') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_425327') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000179', 'hash_927209') ON CONFLICT DO NOTHING;
-- Laporan 180
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000180',
  'RPG-SIM00180',
  'Lampu penerangan jalan padam sudah 4 malam',
  'Laporan simulasi terkalibrasi untuk Lampu penerangan jalan padam sudah 4 malam di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.828423, -7.533799), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-09-08T12:00:00.000Z',
  '2026-09-08T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000180', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-08T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000180', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-08T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000180', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-09-08T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000180', 'hash_863090') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000180', 'hash_498534') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000180', 'hash_203419') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000180', 'hash_515537') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000180', 'hash_998687') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000180', 'hash_993090') ON CONFLICT DO NOTHING;
-- Laporan 181
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000181',
  'RPG-SIM00181',
  'Guiding block terhalang tiang utilitas',
  'Laporan simulasi terkalibrasi untuk Guiding block terhalang tiang utilitas di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.804760, -7.541533), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-08-17T12:00:00.000Z',
  '2026-08-17T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000181', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-17T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000181', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-17T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000181', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-18T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000181', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-20T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000181', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-08-20T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_591349') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_550874') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_595354') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_622314') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_242661') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_982577') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_115808') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_508380') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_111130') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_289406') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_913729') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_971673') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000181', 'hash_549906') ON CONFLICT DO NOTHING;
-- Laporan 182
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000182',
  'RPG-SIM00182',
  'Atap halte bus kota berlubang dan bocor',
  'Laporan simulasi terkalibrasi untuk Atap halte bus kota berlubang dan bocor di wilayah Kelurahan Pajang, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'),
  ST_SetSRID(ST_MakePoint(110.792577, -7.562872), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-10-19T12:00:00.000Z',
  '2026-10-19T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000182', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-19T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000182', 'hash_979715') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000182', 'hash_137554') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000182', 'hash_839355') ON CONFLICT DO NOTHING;
-- Laporan 183
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000183',
  'RPG-SIM00183',
  'Ceceran ranting dan sampah dedaunan kering',
  'Laporan simulasi terkalibrasi untuk Ceceran ranting dan sampah dedaunan kering di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.811182, -7.576870), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-08-17T12:00:00.000Z',
  '2026-08-17T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000183', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-17T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000183', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-17T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000183', 'hash_980435') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000183', 'hash_883255') ON CONFLICT DO NOTHING;
-- Laporan 184
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000184',
  'RPG-SIM00184',
  'Pohon peneduh condong ke jalan rawan tumbang',
  'Laporan simulasi terkalibrasi untuk Pohon peneduh condong ke jalan rawan tumbang di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.801741, -7.555083), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-09-12T12:00:00.000Z',
  '2026-09-12T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000184', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-12T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000184', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-12T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000184', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-13T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000184', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-15T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000184', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-15T23:20:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000184', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-09-16T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_855289') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_696610') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_923276') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_574385') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_373719') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_615379') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_790515') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_117414') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_758004') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_168164') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_944554') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_733333') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_167227') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000184', 'hash_757984') ON CONFLICT DO NOTHING;
-- Laporan 185
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000185',
  'RPG-SIM00185',
  'Tutup bak kontrol drainase amblas dan pecah',
  'Laporan simulasi terkalibrasi untuk Tutup bak kontrol drainase amblas dan pecah di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.824965, -7.572981), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'dibuka_ulang',
  true,
  'simulasi_terkalibrasi',
  '2026-09-10T12:00:00.000Z',
  '2026-09-10T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000185', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-10T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000185', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-10T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000185', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-11T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000185', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-13T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000185', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-09-13T23:20:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000185', 'selesai', 'dibuka_ulang', 'Warga pelapor menyatakan hasil pengerjaan belum tuntas', '2026-09-14T13:13:20.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000185', 'hash_762956') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000185', 'hash_420829') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000185', 'hash_334017') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000185', 'hash_636177') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000185', 'hash_994417') ON CONFLICT DO NOTHING;
-- Laporan 186
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000186',
  'RPG-SIM00186',
  'Aspal amblas di dekat persimpangan jalan',
  'Laporan simulasi terkalibrasi untuk Aspal amblas di dekat persimpangan jalan di wilayah Kelurahan Serengan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'),
  ST_SetSRID(ST_MakePoint(110.821037, -7.572841), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1541888946425-d0fbb1861593?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-09-15T12:00:00.000Z',
  '2026-09-15T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000186', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-15T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000186', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-15T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000186', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-16T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000186', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-09-18T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000186', 'hash_602898') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000186', 'hash_468521') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000186', 'hash_884068') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000186', 'hash_298252') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000186', 'hash_267263') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000186', 'hash_564113') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000186', 'hash_730192') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000186', 'hash_128899') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000186', 'hash_509788') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000186', 'hash_766422') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000186', 'hash_223887') ON CONFLICT DO NOTHING;
-- Laporan 187
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000187',
  'RPG-SIM00187',
  'Pohon peneduh condong ke jalan rawan tumbang',
  'Laporan simulasi terkalibrasi untuk Pohon peneduh condong ke jalan rawan tumbang di wilayah Kelurahan Purwosari, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'),
  ST_SetSRID(ST_MakePoint(110.804464, -7.559532), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-10-29T12:00:00.000Z',
  '2026-10-29T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000187', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-29T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000187', 'hash_378680') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000187', 'hash_703301') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000187', 'hash_984331') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000187', 'hash_983145') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000187', 'hash_957023') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000187', 'hash_632066') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000187', 'hash_380159') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000187', 'hash_553796') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000187', 'hash_703235') ON CONFLICT DO NOTHING;
-- Laporan 188
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000188',
  'RPG-SIM00188',
  'Rambu penyeberangan zebra cross miring ditabrak',
  'Laporan simulasi terkalibrasi untuk Rambu penyeberangan zebra cross miring ditabrak di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'rambu-halte'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.796740, -7.544719), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1508873696983-2df570464756?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-10-12T12:00:00.000Z',
  '2026-10-12T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000188', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-12T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000188', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-12T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000188', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-10-12T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_887790') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_553392') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_159270') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_159295') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_980835') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_802723') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_493298') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_959777') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_552374') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_793911') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_988803') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_351076') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_443069') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000188', 'hash_698705') ON CONFLICT DO NOTHING;
-- Laporan 189
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000189',
  'RPG-SIM00189',
  'Lampu penerangan jalan padam sudah 4 malam',
  'Laporan simulasi terkalibrasi untuk Lampu penerangan jalan padam sudah 4 malam di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.811430, -7.559234), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-10-01T12:00:00.000Z',
  '2026-10-01T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000189', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-01T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000189', 'hash_770797') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000189', 'hash_669154') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000189', 'hash_802348') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000189', 'hash_583706') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000189', 'hash_115983') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000189', 'hash_725249') ON CONFLICT DO NOTHING;
-- Laporan 190
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000190',
  'RPG-SIM00190',
  'Pohon peneduh condong ke jalan rawan tumbang',
  'Laporan simulasi terkalibrasi untuk Pohon peneduh condong ke jalan rawan tumbang di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.816123, -7.584922), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-30T12:00:00.000Z',
  '2026-10-30T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000190', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-30T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000190', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-30T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000190', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-31T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000190', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-02T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000190', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-11-02T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000190', 'hash_984544') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000190', 'hash_774801') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000190', 'hash_415139') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000190', 'hash_356791') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000190', 'hash_319826') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000190', 'hash_717052') ON CONFLICT DO NOTHING;
-- Laporan 191
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000191',
  'RPG-SIM00191',
  'Saluran air tersumbat material sampah dan ranting',
  'Laporan simulasi terkalibrasi untuk Saluran air tersumbat material sampah dan ranting di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.800459, -7.539700), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-08-13T12:00:00.000Z',
  '2026-08-13T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000191', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-13T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000191', 'hash_641243') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000191', 'hash_180767') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000191', 'hash_362346') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000191', 'hash_543210') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000191', 'hash_286734') ON CONFLICT DO NOTHING;
-- Laporan 192
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000192',
  'RPG-SIM00192',
  'Pohon peneduh condong ke jalan rawan tumbang',
  'Laporan simulasi terkalibrasi untuk Pohon peneduh condong ke jalan rawan tumbang di wilayah Kelurahan Joyotakan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'),
  ST_SetSRID(ST_MakePoint(110.816440, -7.589131), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditolak',
  true,
  'simulasi_terkalibrasi',
  '2026-11-02T12:00:00.000Z',
  '2026-11-02T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000192', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-02T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000192', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-02T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000192', 'masuk', 'ditolak', 'Lokasi berada di ruas jalan tol / kewenangan pemerintah pusat', '2026-11-02T13:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000192', 'hash_454769') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000192', 'hash_586601') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000192', 'hash_342535') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000192', 'hash_687041') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000192', 'hash_614356') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000192', 'hash_509533') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000192', 'hash_436157') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000192', 'hash_106495') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000192', 'hash_755332') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000192', 'hash_140483') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000192', 'hash_751770') ON CONFLICT DO NOTHING;
-- Laporan 193
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000193',
  'RPG-SIM00193',
  'Ramp kursi roda terlalu curam dan licin',
  'Laporan simulasi terkalibrasi untuk Ramp kursi roda terlalu curam dan licin di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'fasilitas-difabel'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.847764, -7.553655), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1519817650390-64a93db51149?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-10-12T12:00:00.000Z',
  '2026-10-12T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000193', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-12T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000193', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-12T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000193', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-10-13T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000193', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-10-15T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000193', 'biasa', 5, 'Terima kasih atas respons dan penanganannya', '2026-10-15T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000193', 'hash_187139') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000193', 'hash_231354') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000193', 'hash_625594') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000193', 'hash_525425') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000193', 'hash_969566') ON CONFLICT DO NOTHING;
-- Laporan 194
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000194',
  'RPG-SIM00194',
  'Timbulan sampah liar di lahan kosong pinggir jalan',
  'Laporan simulasi terkalibrasi untuk Timbulan sampah liar di lahan kosong pinggir jalan di wilayah Kelurahan Laweyan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'),
  ST_SetSRID(ST_MakePoint(110.799600, -7.568747), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-11-03T12:00:00.000Z',
  '2026-11-03T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000194', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-11-03T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000194', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-11-03T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000194', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-11-04T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000194', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-11-06T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_457003') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_553279') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_952345') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_209683') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_944646') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_679307') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_934106') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_796515') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_136029') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_541474') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_768530') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_225030') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_173187') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000194', 'hash_104243') ON CONFLICT DO NOTHING;
-- Laporan 195
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000195',
  'RPG-SIM00195',
  'Timbulan sampah liar di lahan kosong pinggir jalan',
  'Laporan simulasi terkalibrasi untuk Timbulan sampah liar di lahan kosong pinggir jalan di wilayah Kelurahan Kadipiro, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'),
  ST_SetSRID(ST_MakePoint(110.822046, -7.525773), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'sedang_ditangani',
  true,
  'simulasi_terkalibrasi',
  '2026-09-16T12:00:00.000Z',
  '2026-09-16T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000195', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-16T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000195', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-09-16T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000195', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-09-17T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000195', 'hash_959416') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000195', 'hash_715129') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000195', 'hash_630844') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000195', 'hash_839330') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000195', 'hash_203288') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000195', 'hash_741421') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000195', 'hash_759855') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000195', 'hash_488024') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000195', 'hash_125397') ON CONFLICT DO NOTHING;
-- Laporan 196
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000196',
  'RPG-SIM00196',
  'Ceceran ranting dan sampah dedaunan kering',
  'Laporan simulasi terkalibrasi untuk Ceceran ranting dan sampah dedaunan kering di wilayah Kelurahan Sumber, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'sampah-lingkungan'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'),
  ST_SetSRID(ST_MakePoint(110.801954, -7.538949), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DLH'),
  ARRAY['https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800&auto=format&fit=crop'],
  ARRAY['https://images.unsplash.com/photo-1498084393753-b411b2d26b34?w=800&auto=format&fit=crop'],
  'selesai',
  true,
  'simulasi_terkalibrasi',
  '2026-08-22T12:00:00.000Z',
  '2026-08-22T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000196', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-22T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000196', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-22T12:30:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000196', 'ditinjau', 'sedang_ditangani', 'Petugas lapangan sedang melakukan pekerjaan perbaikan', '2026-08-23T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000196', 'sedang_ditangani', 'selesai', 'Pekerjaan perbaikan selesai dikerjakan dan foto sesudah diunggah', '2026-08-25T12:00:00.000Z');
INSERT INTO public.konfirmasi_pelapor (laporan_id, jawaban, rating, komentar, created_at)
VALUES ('s0000000-0000-0000-0000-000000000196', 'puas', 5, 'Terima kasih atas respons dan penanganannya', '2026-08-25T23:20:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000196', 'hash_782467') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000196', 'hash_320944') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000196', 'hash_288721') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000196', 'hash_792019') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000196', 'hash_746119') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000196', 'hash_165314') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000196', 'hash_315563') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000196', 'hash_321635') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000196', 'hash_515330') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000196', 'hash_744051') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000196', 'hash_665360') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000196', 'hash_799602') ON CONFLICT DO NOTHING;
-- Laporan 197
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000197',
  'RPG-SIM00197',
  'Saluran air tersumbat material sampah dan ranting',
  'Laporan simulasi terkalibrasi untuk Saluran air tersumbat material sampah dan ranting di wilayah Kelurahan Mojosongo, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'drainase'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'),
  ST_SetSRID(ST_MakePoint(110.836523, -7.544143), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1544816155-12df9643f363?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-09-27T12:00:00.000Z',
  '2026-09-27T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000197', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-27T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000197', 'hash_296884') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000197', 'hash_166139') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000197', 'hash_804900') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000197', 'hash_725995') ON CONFLICT DO NOTHING;
-- Laporan 198
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000198',
  'RPG-SIM00198',
  'Permukaan jalan bergelombang dan retak buaya',
  'Laporan simulasi terkalibrasi untuk Permukaan jalan bergelombang dan retak buaya di wilayah Kelurahan Nusukan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'penambalan-aspal'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'),
  ST_SetSRID(ST_MakePoint(110.821328, -7.543703), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'DPUPR'),
  ARRAY['https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-08-14T12:00:00.000Z',
  '2026-08-14T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000198', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-08-14T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000198', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-08-14T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000198', 'hash_727426') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000198', 'hash_120825') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000198', 'hash_755170') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000198', 'hash_237293') ON CONFLICT DO NOTHING;
-- Laporan 199
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000199',
  'RPG-SIM00199',
  'Lampu penerangan jalan padam sudah 4 malam',
  'Laporan simulasi terkalibrasi untuk Lampu penerangan jalan padam sudah 4 malam di wilayah Kelurahan Manahan, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'),
  ST_SetSRID(ST_MakePoint(110.813423, -7.548146), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'masuk',
  true,
  'simulasi_terkalibrasi',
  '2026-09-11T12:00:00.000Z',
  '2026-09-11T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000199', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-09-11T12:00:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000199', 'hash_457197') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000199', 'hash_215988') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000199', 'hash_671259') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000199', 'hash_884768') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000199', 'hash_589999') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000199', 'hash_913098') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000199', 'hash_889530') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000199', 'hash_755705') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000199', 'hash_589398') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000199', 'hash_669937') ON CONFLICT DO NOTHING;
-- Laporan 200
INSERT INTO public.laporan (
  id, kode_lacak, judul, deskripsi, kategori_id, kelurahan_id, koordinat, dinas_id,
  foto_sebelum_paths, foto_sesudah_paths, status, is_simulasi, provenance, created_at, updated_at
) VALUES (
  's0000000-0000-0000-0000-000000000200',
  'RPG-SIM00200',
  'Lampu penerangan jalan padam sudah 4 malam',
  'Laporan simulasi terkalibrasi untuk Lampu penerangan jalan padam sudah 4 malam di wilayah Kelurahan Jebres, Surakarta. Kondisi memerlukan tindak lanjut perbaikan cepat dari dinas terkait.',
  (SELECT id FROM public.kategori WHERE slug = 'lampu-pju'),
  (SELECT id FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'),
  ST_SetSRID(ST_MakePoint(110.864213, -7.561410), 4326),
  (SELECT id FROM public.dinas WHERE singkatan = 'Dishub'),
  ARRAY['https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=800&auto=format&fit=crop'],
  ARRAY[]::TEXT[],
  'ditinjau',
  true,
  'simulasi_terkalibrasi',
  '2026-10-23T12:00:00.000Z',
  '2026-10-23T12:00:00.000Z'
) ON CONFLICT (kode_lacak) DO NOTHING;

INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000200', NULL, 'masuk', 'Laporan baru diterima oleh sistem RAMPUNG', '2026-10-23T12:00:00.000Z');
INSERT INTO public.status_history (laporan_id, status_dari, status_ke, catatan, created_at)
VALUES ('s0000000-0000-0000-0000-000000000200', 'masuk', 'ditinjau', 'Laporan telah diverifikasi oleh tim dinas', '2026-10-23T12:30:00.000Z');
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000200', 'hash_636539') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000200', 'hash_894341') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000200', 'hash_543024') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000200', 'hash_693822') ON CONFLICT DO NOTHING;
INSERT INTO public.dukungan_laporan (laporan_id, ip_hash) VALUES ('s0000000-0000-0000-0000-000000000200', 'hash_745930') ON CONFLICT DO NOTHING;

COMMIT;
