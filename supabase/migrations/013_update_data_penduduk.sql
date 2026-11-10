-- Di-generate otomatis oleh scripts/data/01_impor_penduduk.ts
BEGIN;

UPDATE public.kelurahan SET jumlah_penduduk = 5214, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.01.1001';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 5214, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1001'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 5480, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.01.1002';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 5480, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1002'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 11320, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.01.1003';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 11320, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1003'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 10185, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.01.1004';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 10185, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1004'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 12450, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.01.1005';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 12450, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1005'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 11840, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.01.1006';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 11840, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1006'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 13920, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.01.1007';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 13920, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1007'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 11750, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.01.1008';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 11750, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1008'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 3240, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.01.1009';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 3240, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1009'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 7894, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.01.1010';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 7894, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1010'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 11230, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.01.1011';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 11230, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.01.1011'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 3940, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.02.1001';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 3940, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1001'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 5120, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.02.1002';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 5120, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1002'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 5860, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.02.1003';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 5860, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1003'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 11450, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.02.1004';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 11450, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1004'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 9850, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.02.1005';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 9850, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1005'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 7480, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.02.1006';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 7480, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1006'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 8610, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.02.1007';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 8610, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.02.1007'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 3820, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.03.1001';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 3820, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1001'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 4180, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.03.1002';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 4180, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1002'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 5920, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.03.1003';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 5920, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1003'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 7540, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.03.1004';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 7540, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1004'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 5630, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.03.1005';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 5630, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1005'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 6890, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.03.1006';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 6890, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1006'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 10450, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.03.1007';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 10450, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1007'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 19820, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.03.1008';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 19820, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1008'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 13410, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.03.1009';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 13410, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1009'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 10810, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.03.1010';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 10810, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.03.1010'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 4210, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.04.1001';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 4210, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1001'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 9250, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.04.1002';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 9250, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1002'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 7890, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.04.1003';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 7890, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1003'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 12100, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.04.1004';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 12100, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1004'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 14250, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.04.1005';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 14250, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1005'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 36580, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.04.1006';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 36580, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1006'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 54220, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.04.1007';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 54220, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1007'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 4520, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.04.1008';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 4520, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1008'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 4310, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.04.1009';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 4310, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1009'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 2110, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.04.1010';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 2110, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1010'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 1800, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.04.1011';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 1800, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.04.1011'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 3150, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1001';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 3150, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1001'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 3240, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1002';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 3240, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1002'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 4380, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1003';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 4380, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1003'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 4620, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1004';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 4620, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1004'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 3890, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1005';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 3890, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1005'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 4720, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1006';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 4720, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1006'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 18450, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1007';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 18450, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1007'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 35680, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1008';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 35680, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1008'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 21340, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1009';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 21340, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1009'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 16820, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1010';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 16820, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1010'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 20110, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1011';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 20110, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1011'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 13140, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1012';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 13140, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1012'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 9870, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1013';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 9870, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1013'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 12390, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1014';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 12390, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1014'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

UPDATE public.kelurahan SET jumlah_penduduk = 12793, provenance = 'agregat_resmi' WHERE kode_wilayah = '33.72.05.1015';
INSERT INTO public.data_penduduk_resmi (kelurahan_id, tahun, semester, jumlah_penduduk, provenance)
SELECT id, 2023, 2, 12793, 'agregat_resmi' FROM public.kelurahan WHERE kode_wilayah = '33.72.05.1015'
ON CONFLICT (kelurahan_id, tahun, semester) DO UPDATE SET jumlah_penduduk = EXCLUDED.jumlah_penduduk;

COMMIT;
