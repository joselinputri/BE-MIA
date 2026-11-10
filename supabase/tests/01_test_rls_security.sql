-- =============================================================================
-- tests/01_test_rls_security.sql
-- Uji Otomatis Kebijakan Row Level Security (RLS) & Isolasi Hak Akses
-- Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
-- =============================================================================
-- Cara menjalankan di Supabase SQL Editor atau psql:
-- \i supabase/tests/01_test_rls_security.sql
-- =============================================================================

DO $$
DECLARE
  v_warga_1_id UUID := '11111111-aaaa-bbbb-cccc-111111111111';
  v_warga_2_id UUID := '22222222-aaaa-bbbb-cccc-222222222222';
  v_petugas_dpupr_id UUID := '33333333-aaaa-bbbb-cccc-333333333333';
  v_petugas_dishub_id UUID := '44444444-aaaa-bbbb-cccc-444444444444';
  v_dpupr_id UUID := 'd1111111-0000-0000-0000-000000000001';
  v_dishub_id UUID := 'd2222222-0000-0000-0000-000000000002';
  v_kat_aspal UUID := 'k1111111-0000-0000-0000-000000000001';
  v_laporan_id UUID;
  v_test_count INT := 0;
  v_count INT;
BEGIN
  RAISE NOTICE '>>> MEMULAI PENGUJIAN KEAMANAN RLS RAMPUNG <<<';

  -- 1. Setup Mock Profiles
  INSERT INTO public.profiles (id, role, nama) 
  VALUES (v_warga_1_id, 'warga', 'Warga A')
  ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (id, role, nama) 
  VALUES (v_warga_2_id, 'warga', 'Warga B')
  ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (id, role, nama, dinas_id) 
  VALUES (v_petugas_dpupr_id, 'petugas', 'Petugas DPUPR', v_dpupr_id)
  ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (id, role, nama, dinas_id) 
  VALUES (v_petugas_dishub_id, 'petugas', 'Petugas Dishub', v_dishub_id)
  ON CONFLICT (id) DO NOTHING;

  -- 2. Warga 1 membuat laporan jalan berlubang (DPUPR)
  INSERT INTO public.laporan (
    kode_lacak, judul, deskripsi, kategori_id, koordinat, dinas_id, pelapor_id, is_anonim
  ) VALUES (
    'RPG-TEST001',
    'Jalan Berlubang Depan Pasar',
    'Lubang aspal berdiameter 50cm membahayakan pengguna motor di malam hari',
    v_kat_aspal,
    ST_SetSRID(ST_MakePoint(110.825, -7.565), 4326),
    v_dpupr_id,
    v_warga_1_id,
    false
  ) RETURNING id INTO v_laporan_id;

  INSERT INTO public.kontak_pelapor (laporan_id, user_id, email, telepon)
  VALUES (v_laporan_id, v_warga_1_id, 'warga1@example.com', '081234567890');

  -- ---------------------------------------------------------------------------
  -- TEST 1: Warga B TIDAK BOLEH membaca kontak Warga A
  -- ---------------------------------------------------------------------------
  EXECUTE 'SET LOCAL ROLE authenticated';
  PERFORM set_config('request.jwt.claims', format('{"sub": "%s", "role": "authenticated"}', v_warga_2_id), true);

  SELECT COUNT(*) INTO v_count FROM public.kontak_pelapor WHERE laporan_id = v_laporan_id;
  IF v_count <> 0 THEN
    RAISE EXCEPTION 'TEST 1 GAGAL: Warga 2 dapat membaca kontak Warga 1!';
  END IF;
  RAISE NOTICE '✅ TEST 1 BERHASIL: Isolasi kontak pelapor terbukti aman antar warga.';

  -- ---------------------------------------------------------------------------
  -- TEST 2: Petugas Dishub TIDAK BOLEH memperbarui laporan DPUPR
  -- ---------------------------------------------------------------------------
  PERFORM set_config('request.jwt.claims', format('{"sub": "%s", "role": "authenticated"}', v_petugas_dishub_id), true);

  UPDATE public.laporan SET status = 'sedang_ditangani' WHERE id = v_laporan_id;
  GET DIAGNOSTICS v_count = ROW_COUNT;
  IF v_count <> 0 THEN
    RAISE EXCEPTION 'TEST 2 GAGAL: Petugas Dishub berhasil mengubah laporan DPUPR!';
  END IF;
  RAISE NOTICE '✅ TEST 2 BERHASIL: Petugas tidak bisa memodifikasi laporan di luar dinasnya.';

  -- ---------------------------------------------------------------------------
  -- TEST 3: Publik (Anon) hanya bisa membaca melalui VIEW dan TIDAK boleh akses PII
  -- ---------------------------------------------------------------------------
  EXECUTE 'SET LOCAL ROLE anon';
  PERFORM set_config('request.jwt.claims', '{"role": "anon"}', true);

  -- Coba akses tabel master langsung
  SELECT COUNT(*) INTO v_count FROM public.kontak_pelapor;
  IF v_count <> 0 THEN
    RAISE EXCEPTION 'TEST 3A GAGAL: Publik dapat membaca tabel kontak!';
  END IF;

  -- Akses view publik
  SELECT COUNT(*) INTO v_count FROM public.laporan_publik WHERE kode_lacak = 'RPG-TEST001';
  IF v_count = 0 THEN
    RAISE EXCEPTION 'TEST 3B GAGAL: Publik tidak dapat membaca view laporan_publik!';
  END IF;
  RAISE NOTICE '✅ TEST 3 BERHASIL: Publik hanya bisa mengakses view laporan_publik tanpa PII.';

  -- Reset role
  EXECUTE 'RESET ROLE';
  
  -- Cleanup test data
  DELETE FROM public.laporan WHERE id = v_laporan_id;
  DELETE FROM public.profiles WHERE id IN (v_warga_1_id, v_warga_2_id, v_petugas_dpupr_id, v_petugas_dishub_id);

  RAISE NOTICE '>>> SEMUA PENGUJIAN RLS BERHASIL 100% <<<';
END $$;

