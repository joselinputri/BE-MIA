-- Di-generate otomatis oleh scripts/data/03_impor_ulas.ts
BEGIN;

INSERT INTO public.rekap_ulas (periode, dinas_nama, jumlah_aduan, topik_terbanyak, provenance, sumber_data_id)
VALUES ('2023-Semester-1', 'Dinas Pekerjaan Umum dan Penataan Ruang', 482, ARRAY['Jalan Berlubang / Aspal Amblas', 'Saluran Drainase Tersumbat', 'Trotoar Rusak'], 'agregat_resmi', 'b2222222-2222-2222-2222-222222222222');
INSERT INTO public.rekap_ulas (periode, dinas_nama, jumlah_aduan, topik_terbanyak, provenance, sumber_data_id)
VALUES ('2023-Semester-1', 'Dinas Perhubungan', 315, ARRAY['Lampu PJU Mati / Padam', 'Rambu Lalu Lintas Rusak', 'Halte BST'], 'agregat_resmi', 'b2222222-2222-2222-2222-222222222222');
INSERT INTO public.rekap_ulas (periode, dinas_nama, jumlah_aduan, topik_terbanyak, provenance, sumber_data_id)
VALUES ('2023-Semester-1', 'Dinas Lingkungan Hidup', 228, ARRAY['Tumpukan Sampah Liar', 'Pohon Rawan Tumbang', 'Bau Limbah'], 'agregat_resmi', 'b2222222-2222-2222-2222-222222222222');
INSERT INTO public.rekap_ulas (periode, dinas_nama, jumlah_aduan, topik_terbanyak, provenance, sumber_data_id)
VALUES ('2023-Semester-2', 'Dinas Pekerjaan Umum dan Penataan Ruang', 541, ARRAY['Penanganan Genangan / Drainase', 'Kerusakan Jalan Protokol', 'Tutup Selokan Hilang'], 'agregat_resmi', 'b2222222-2222-2222-2222-222222222222');
INSERT INTO public.rekap_ulas (periode, dinas_nama, jumlah_aduan, topik_terbanyak, provenance, sumber_data_id)
VALUES ('2023-Semester-2', 'Dinas Perhubungan', 389, ARRAY['Perbaikan Lampu PJU Perkampungan', 'Marka Jalan Pudar', 'Rambu Pengatur'], 'agregat_resmi', 'b2222222-2222-2222-2222-222222222222');
INSERT INTO public.rekap_ulas (periode, dinas_nama, jumlah_aduan, topik_terbanyak, provenance, sumber_data_id)
VALUES ('2023-Semester-2', 'Dinas Lingkungan Hidup', 274, ARRAY['Pembersihan Saluran Sampah', 'Jadwal Gerobak Sampah', 'Perantingan Dahan'], 'agregat_resmi', 'b2222222-2222-2222-2222-222222222222');

COMMIT;
