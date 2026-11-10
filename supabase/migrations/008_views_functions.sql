-- =============================================================================
-- 008_views_functions.sql
-- Migrasi: View publik dan fungsi RPC/Database Logic
-- Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
-- =============================================================================
-- File ini idempoten: menggunakan CREATE OR REPLACE.
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. VIEW: laporan_publik
--    View publik tanpa PII (tanpa user_id, kontak, EXIF, dan koordinat asli).
--    Koordinat telah dibulatkan ke grid ~100m untuk privasi warga.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE VIEW public.laporan_publik AS
SELECT 
  l.id,
  l.kode_lacak,
  l.judul,
  l.deskripsi,
  k.id AS kategori_id,
  k.nama AS kategori,
  k.slug AS kategori_slug,
  k.ikon AS kategori_ikon,
  kel.id AS kelurahan_id,
  kel.nama AS kelurahan,
  kel.kode_wilayah AS kelurahan_kode,
  kec.id AS kecamatan_id,
  kec.nama AS kecamatan,
  kec.kode_wilayah AS kecamatan_kode,
  ST_X(l.koordinat_publik) AS longitude,
  ST_Y(l.koordinat_publik) AS latitude,
  l.koordinat_publik AS geometri,
  l.status,
  l.penanda,
  l.foto_sebelum_paths,
  l.foto_sesudah_paths,
  l.is_anonim,
  l.is_simulasi,
  l.provenance,
  d.id AS dinas_id,
  d.nama AS dinas,
  d.singkatan AS dinas_singkatan,
  l.created_at,
  l.updated_at,
  (SELECT COUNT(*)::INTEGER FROM public.dukungan_laporan dl WHERE dl.laporan_id = l.id) AS jumlah_dukungan,
  (SELECT sh.created_at FROM public.status_history sh WHERE sh.laporan_id = l.id ORDER BY sh.created_at DESC LIMIT 1) AS status_diperbarui_at,
  (SELECT kp.jawaban FROM public.konfirmasi_pelapor kp WHERE kp.laporan_id = l.id LIMIT 1) AS konfirmasi_jawaban
FROM public.laporan l
JOIN public.kategori k ON l.kategori_id = k.id
LEFT JOIN public.kelurahan kel ON l.kelurahan_id = kel.id
LEFT JOIN public.kecamatan kec ON kel.kecamatan_id = kec.id
JOIN public.dinas d ON l.dinas_id = d.id;

GRANT SELECT ON public.laporan_publik TO anon, authenticated;

-- ---------------------------------------------------------------------------
-- 2. FUNCTION: fn_buat_kode_lacak
--    Menghasilkan kode unik acak kriptografis sesuai format UI RAMPUNG (RMP-YYYY-XXXX)
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fn_buat_kode_lacak()
RETURNS VARCHAR(16) AS $$
DECLARE
  v_kode VARCHAR(16);
  v_chars TEXT := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  v_len INTEGER := length(v_chars);
  v_result TEXT := '';
  v_bytes BYTEA;
  v_exists BOOLEAN;
  v_tahun TEXT := to_char(CURRENT_DATE, 'YYYY');
BEGIN
  LOOP
    v_result := '';
    v_bytes := gen_random_bytes(4);
    
    FOR i IN 0..3 LOOP
      v_result := v_result || substr(v_chars, (get_byte(v_bytes, i) % v_len) + 1, 1);
    END LOOP;
    
    v_kode := 'RMP-' || v_tahun || '-' || v_result;
    
    SELECT EXISTS (SELECT 1 FROM public.laporan WHERE kode_lacak = v_kode) INTO v_exists;
    EXIT WHEN NOT v_exists;
  END LOOP;
  
  RETURN v_kode;
END;
$$ LANGUAGE plpgsql VOLATILE;

-- ---------------------------------------------------------------------------
-- 3. FUNCTION: fn_laporan_serupa
--    Pencarian laporan serupa berdasarkan kategori dan radius PostGIS
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fn_laporan_serupa(
  p_kategori_id UUID,
  p_latitude DOUBLE PRECISION,
  p_longitude DOUBLE PRECISION,
  p_radius_meter INTEGER DEFAULT 500,
  p_maks INTEGER DEFAULT 5
)
RETURNS TABLE (
  id UUID,
  kode_lacak VARCHAR,
  judul VARCHAR,
  kategori VARCHAR,
  kelurahan VARCHAR,
  status status_laporan,
  jarak_meter DOUBLE PRECISION,
  jumlah_dukungan BIGINT,
  created_at TIMESTAMPTZ
) AS $$
BEGIN
  IF p_radius_meter > 2000 THEN
    p_radius_meter := 2000;
  END IF;
  IF p_radius_meter < 50 THEN
    p_radius_meter := 50;
  END IF;
  IF p_maks > 20 THEN
    p_maks := 20;
  END IF;

  RETURN QUERY
  SELECT
    l.id,
    l.kode_lacak,
    l.judul,
    k.nama AS kategori,
    COALESCE(kel.nama, 'Luar Wilayah') AS kelurahan,
    l.status,
    ST_Distance(
      l.koordinat::geography,
      ST_SetSRID(ST_MakePoint(p_longitude, p_latitude), 4326)::geography
    ) AS jarak_meter,
    (SELECT COUNT(*) FROM public.dukungan_laporan dl WHERE dl.laporan_id = l.id) AS jumlah_dukungan,
    l.created_at
  FROM public.laporan l
  JOIN public.kategori k ON l.kategori_id = k.id
  LEFT JOIN public.kelurahan kel ON l.kelurahan_id = kel.id
  WHERE l.kategori_id = p_kategori_id
    AND l.status NOT IN ('ditolak')
    AND ST_DWithin(
      l.koordinat::geography,
      ST_SetSRID(ST_MakePoint(p_longitude, p_latitude), 4326)::geography,
      p_radius_meter
    )
  ORDER BY jarak_meter ASC
  LIMIT p_maks;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- ---------------------------------------------------------------------------
-- 4. FUNCTION: fn_validasi_transisi_status
--    Validasi state machine alur status laporan di level database
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fn_validasi_transisi_status(
  p_status_dari status_laporan,
  p_status_ke status_laporan,
  p_user_role role_type,
  p_catatan TEXT DEFAULT NULL
)
RETURNS TABLE (valid BOOLEAN, pesan TEXT) AS $$
DECLARE
  v_valid BOOLEAN := FALSE;
  v_pesan TEXT := 'Transisi status tidak valid';
BEGIN
  CASE
    WHEN p_status_dari = 'masuk' AND p_status_ke = 'ditinjau' AND p_user_role IN ('petugas', 'admin') THEN
      v_valid := TRUE; v_pesan := 'OK';

    WHEN p_status_dari = 'masuk' AND p_status_ke = 'ditolak' AND p_user_role IN ('petugas', 'admin') THEN
      IF p_catatan IS NULL OR char_length(trim(p_catatan)) < 10 THEN
        v_valid := FALSE; v_pesan := 'Penolakan wajib disertai alasan minimal 10 karakter';
      ELSE
        v_valid := TRUE; v_pesan := 'OK';
      END IF;

    WHEN p_status_dari = 'ditinjau' AND p_status_ke = 'sedang_ditangani' AND p_user_role IN ('petugas', 'admin') THEN
      v_valid := TRUE; v_pesan := 'OK';

    WHEN p_status_dari = 'ditinjau' AND p_status_ke = 'ditolak' AND p_user_role IN ('petugas', 'admin') THEN
      IF p_catatan IS NULL OR char_length(trim(p_catatan)) < 10 THEN
        v_valid := FALSE; v_pesan := 'Penolakan wajib disertai alasan minimal 10 karakter';
      ELSE
        v_valid := TRUE; v_pesan := 'OK';
      END IF;

    WHEN p_status_dari = 'ditinjau' AND p_status_ke = 'masuk' AND p_user_role IN ('petugas', 'admin') THEN
      v_valid := TRUE; v_pesan := 'OK';

    WHEN p_status_dari = 'sedang_ditangani' AND p_status_ke = 'selesai' AND p_user_role IN ('petugas', 'admin') THEN
      v_valid := TRUE; v_pesan := 'OK';

    WHEN p_status_dari = 'selesai' AND p_status_ke = 'dibuka_ulang' AND p_user_role IN ('warga', 'admin') THEN
      v_valid := TRUE; v_pesan := 'OK';

    WHEN p_status_dari = 'dibuka_ulang' AND p_status_ke = 'sedang_ditangani' AND p_user_role IN ('petugas', 'admin') THEN
      v_valid := TRUE; v_pesan := 'OK';

    WHEN p_status_dari = 'dibuka_ulang' AND p_status_ke = 'ditolak' AND p_user_role IN ('petugas', 'admin') THEN
      IF p_catatan IS NULL OR char_length(trim(p_catatan)) < 10 THEN
        v_valid := FALSE; v_pesan := 'Penolakan wajib disertai alasan minimal 10 karakter';
      ELSE
        v_valid := TRUE; v_pesan := 'OK';
      END IF;

    ELSE
      v_valid := FALSE;
      v_pesan := format('Transisi status dari "%s" ke "%s" tidak diizinkan untuk peran "%s"', p_status_dari, p_status_ke, p_user_role);
  END CASE;

  RETURN QUERY SELECT v_valid, v_pesan;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- ---------------------------------------------------------------------------
-- 5. FUNCTION: fn_hitung_sla
--    Menghitung pemenuhan SLA dan status keterlambatan
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fn_hitung_sla(p_laporan_id UUID)
RETURNS TABLE (
  sla_target_hari INTEGER,
  hari_berlalu INTEGER,
  is_terlambat BOOLEAN,
  status_saat_ini status_laporan
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    k.sla_hari AS sla_target_hari,
    EXTRACT(DAY FROM (NOW() - l.created_at))::INTEGER AS hari_berlalu,
    (EXTRACT(DAY FROM (NOW() - l.created_at))::INTEGER > k.sla_hari) AS is_terlambat,
    l.status AS status_saat_ini
  FROM public.laporan l
  JOIN public.kategori k ON l.kategori_id = k.id
  WHERE l.id = p_laporan_id
    AND l.status NOT IN ('selesai', 'ditolak');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- ---------------------------------------------------------------------------
-- 6. RPC DASHBOARD: fn_dashboard_tren
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fn_dashboard_tren(
  p_periode_mulai DATE DEFAULT (CURRENT_DATE - INTERVAL '12 months')::DATE,
  p_periode_akhir DATE DEFAULT CURRENT_DATE,
  p_kategori_slug TEXT DEFAULT NULL,
  p_kecamatan_kode TEXT DEFAULT NULL,
  p_kelurahan_kode TEXT DEFAULT NULL,
  p_sumber TEXT DEFAULT 'semua'
)
RETURNS TABLE (
  bulan DATE,
  jumlah_masuk BIGINT,
  jumlah_selesai BIGINT,
  jumlah_ditolak BIGINT,
  jumlah_aktif BIGINT,
  provenance_campuran BOOLEAN
) AS $$
BEGIN
  RETURN QUERY
  WITH bulan_series AS (
    SELECT generate_series(
      date_trunc('month', p_periode_mulai::TIMESTAMP),
      date_trunc('month', p_periode_akhir::TIMESTAMP),
      '1 month'::INTERVAL
    )::DATE AS bulan
  ),
  filtered AS (
    SELECT l.*
    FROM public.laporan l
    LEFT JOIN public.kategori k ON l.kategori_id = k.id
    LEFT JOIN public.kelurahan kel ON l.kelurahan_id = kel.id
    LEFT JOIN public.kecamatan kec ON kel.kecamatan_id = kec.id
    WHERE (p_kategori_slug IS NULL OR k.slug = p_kategori_slug)
      AND (p_kecamatan_kode IS NULL OR kec.kode_wilayah = p_kecamatan_kode)
      AND (p_kelurahan_kode IS NULL OR kel.kode_wilayah = p_kelurahan_kode)
      AND (p_sumber = 'semua' 
           OR (p_sumber = 'asli' AND l.is_simulasi = FALSE)
           OR (p_sumber = 'simulasi' AND l.is_simulasi = TRUE))
  )
  SELECT
    bs.bulan,
    COUNT(*) FILTER (WHERE date_trunc('month', f.created_at) = bs.bulan) AS jumlah_masuk,
    COUNT(*) FILTER (
      WHERE date_trunc('month', (
        SELECT sh.created_at FROM public.status_history sh 
        WHERE sh.laporan_id = f.id AND sh.status_ke = 'selesai' 
        ORDER BY sh.created_at DESC LIMIT 1
      )) = bs.bulan
    ) AS jumlah_selesai,
    COUNT(*) FILTER (
      WHERE date_trunc('month', (
        SELECT sh.created_at FROM public.status_history sh 
        WHERE sh.laporan_id = f.id AND sh.status_ke = 'ditolak' 
        ORDER BY sh.created_at DESC LIMIT 1
      )) = bs.bulan
    ) AS jumlah_ditolak,
    COUNT(*) FILTER (
      WHERE date_trunc('month', f.created_at) <= bs.bulan
      AND f.status NOT IN ('selesai', 'ditolak')
    ) AS jumlah_aktif,
    (COUNT(DISTINCT f.is_simulasi) FILTER (WHERE date_trunc('month', f.created_at) = bs.bulan) > 1) AS provenance_campuran
  FROM bulan_series bs
  LEFT JOIN filtered f ON TRUE
  GROUP BY bs.bulan
  ORDER BY bs.bulan;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- ---------------------------------------------------------------------------
-- 7. RPC DASHBOARD: fn_dashboard_waktu_penanganan
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fn_dashboard_waktu_penanganan(
  p_periode_mulai DATE DEFAULT (CURRENT_DATE - INTERVAL '12 months')::DATE,
  p_periode_akhir DATE DEFAULT CURRENT_DATE,
  p_kategori_slug TEXT DEFAULT NULL,
  p_kecamatan_kode TEXT DEFAULT NULL,
  p_sumber TEXT DEFAULT 'semua'
)
RETURNS TABLE (
  kategori TEXT,
  kategori_slug TEXT,
  dinas TEXT,
  dinas_singkatan TEXT,
  median_hari DOUBLE PRECISION,
  rata_rata_hari DOUBLE PRECISION,
  jumlah_selesai BIGINT,
  jumlah_terlambat BIGINT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    k.nama::TEXT AS kategori,
    k.slug::TEXT AS kategori_slug,
    d.nama::TEXT AS dinas,
    d.singkatan::TEXT AS dinas_singkatan,
    COALESCE(PERCENTILE_CONT(0.5) WITHIN GROUP (
      ORDER BY EXTRACT(EPOCH FROM (sh_selesai.created_at - l.created_at)) / 86400.0
    ), 0.0) AS median_hari,
    COALESCE(AVG(EXTRACT(EPOCH FROM (sh_selesai.created_at - l.created_at)) / 86400.0), 0.0) AS rata_rata_hari,
    COUNT(*)::BIGINT AS jumlah_selesai,
    COUNT(*) FILTER (
      WHERE EXTRACT(EPOCH FROM (sh_selesai.created_at - l.created_at)) / 86400.0 > k.sla_hari
    )::BIGINT AS jumlah_terlambat
  FROM public.laporan l
  JOIN public.kategori k ON l.kategori_id = k.id
  JOIN public.dinas d ON l.dinas_id = d.id
  LEFT JOIN public.kelurahan kel ON l.kelurahan_id = kel.id
  LEFT JOIN public.kecamatan kec ON kel.kecamatan_id = kec.id
  JOIN LATERAL (
    SELECT sh.created_at
    FROM public.status_history sh
    WHERE sh.laporan_id = l.id AND sh.status_ke = 'selesai'
    ORDER BY sh.created_at DESC
    LIMIT 1
  ) sh_selesai ON TRUE
  WHERE l.status = 'selesai'
    AND l.created_at BETWEEN p_periode_mulai AND (p_periode_akhir + INTERVAL '1 day')
    AND (p_kategori_slug IS NULL OR k.slug = p_kategori_slug)
    AND (p_kecamatan_kode IS NULL OR kec.kode_wilayah = p_kecamatan_kode)
    AND (p_sumber = 'semua' 
         OR (p_sumber = 'asli' AND l.is_simulasi = FALSE)
         OR (p_sumber = 'simulasi' AND l.is_simulasi = TRUE))
  GROUP BY k.nama, k.slug, d.nama, d.singkatan, k.sla_hari;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- ---------------------------------------------------------------------------
-- 8. RPC DASHBOARD: fn_dashboard_per_kapita
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fn_dashboard_per_kapita(
  p_periode_mulai DATE DEFAULT (CURRENT_DATE - INTERVAL '12 months')::DATE,
  p_periode_akhir DATE DEFAULT CURRENT_DATE,
  p_kategori_slug TEXT DEFAULT NULL,
  p_sumber TEXT DEFAULT 'semua'
)
RETURNS TABLE (
  kelurahan TEXT,
  kelurahan_kode TEXT,
  kecamatan TEXT,
  jumlah_penduduk INTEGER,
  jumlah_laporan BIGINT,
  laporan_per_10k DOUBLE PRECISION,
  provenance_penduduk provenance_type
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    kel.nama::TEXT AS kelurahan,
    kel.kode_wilayah::TEXT AS kelurahan_kode,
    kec.nama::TEXT AS kecamatan,
    kel.jumlah_penduduk,
    COUNT(l.id) AS jumlah_laporan,
    CASE 
      WHEN kel.jumlah_penduduk > 0 THEN 
        (COUNT(l.id)::DOUBLE PRECISION / kel.jumlah_penduduk * 10000)
      ELSE 0.0
    END AS laporan_per_10k,
    kel.provenance AS provenance_penduduk
  FROM public.kelurahan kel
  JOIN public.kecamatan kec ON kel.kecamatan_id = kec.id
  LEFT JOIN public.laporan l ON l.kelurahan_id = kel.id
    AND l.created_at BETWEEN p_periode_mulai AND (p_periode_akhir + INTERVAL '1 day')
    AND (p_kategori_slug IS NULL OR l.kategori_id IN (SELECT id FROM public.kategori WHERE slug = p_kategori_slug))
    AND (p_sumber = 'semua' 
         OR (p_sumber = 'asli' AND l.is_simulasi = FALSE)
         OR (p_sumber = 'simulasi' AND l.is_simulasi = TRUE))
  GROUP BY kel.id, kel.nama, kel.kode_wilayah, kec.nama, kel.jumlah_penduduk, kel.provenance
  ORDER BY laporan_per_10k DESC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- ---------------------------------------------------------------------------
-- 9. RPC DASHBOARD: fn_dashboard_konfirmasi
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fn_dashboard_konfirmasi(
  p_periode_mulai DATE DEFAULT (CURRENT_DATE - INTERVAL '12 months')::DATE,
  p_periode_akhir DATE DEFAULT CURRENT_DATE,
  p_kategori_slug TEXT DEFAULT NULL,
  p_kecamatan_kode TEXT DEFAULT NULL,
  p_sumber TEXT DEFAULT 'semua'
)
RETURNS TABLE (
  total_selesai BIGINT,
  total_dikonfirmasi BIGINT,
  persen_dikonfirmasi DOUBLE PRECISION,
  persen_puas DOUBLE PRECISION,
  persen_biasa DOUBLE PRECISION,
  persen_kurang_puas DOUBLE PRECISION,
  total_dibuka_ulang BIGINT,
  persen_dibuka_ulang DOUBLE PRECISION
) AS $$
BEGIN
  RETURN QUERY
  WITH filtered AS (
    SELECT l.id, l.status
    FROM public.laporan l
    JOIN public.kategori k ON l.kategori_id = k.id
    LEFT JOIN public.kelurahan kel ON l.kelurahan_id = kel.id
    LEFT JOIN public.kecamatan kec ON kel.kecamatan_id = kec.id
    WHERE l.created_at BETWEEN p_periode_mulai AND (p_periode_akhir + INTERVAL '1 day')
      AND (p_kategori_slug IS NULL OR k.slug = p_kategori_slug)
      AND (p_kecamatan_kode IS NULL OR kec.kode_wilayah = p_kecamatan_kode)
      AND (p_sumber = 'semua' 
           OR (p_sumber = 'asli' AND l.is_simulasi = FALSE)
           OR (p_sumber = 'simulasi' AND l.is_simulasi = TRUE))
  ),
  stats AS (
    SELECT
      COUNT(*) FILTER (WHERE f.status = 'selesai') AS t_selesai,
      COUNT(kp.id) AS t_konfirmasi,
      COUNT(*) FILTER (WHERE kp.jawaban = 'puas') AS t_puas,
      COUNT(*) FILTER (WHERE kp.jawaban = 'biasa') AS t_biasa,
      COUNT(*) FILTER (WHERE kp.jawaban = 'kurang_puas') AS t_kurang_puas,
      (SELECT COUNT(DISTINCT sh.laporan_id) FROM public.status_history sh JOIN filtered f2 ON sh.laporan_id = f2.id WHERE sh.status_ke = 'dibuka_ulang') AS t_dibuka_ulang
    FROM filtered f
    LEFT JOIN public.konfirmasi_pelapor kp ON kp.laporan_id = f.id
  )
  SELECT
    s.t_selesai,
    s.t_konfirmasi,
    CASE WHEN s.t_selesai > 0 THEN (s.t_konfirmasi::DOUBLE PRECISION / s.t_selesai * 100) ELSE 0.0 END,
    CASE WHEN s.t_konfirmasi > 0 THEN (s.t_puas::DOUBLE PRECISION / s.t_konfirmasi * 100) ELSE 0.0 END,
    CASE WHEN s.t_konfirmasi > 0 THEN (s.t_biasa::DOUBLE PRECISION / s.t_konfirmasi * 100) ELSE 0.0 END,
    CASE WHEN s.t_konfirmasi > 0 THEN (s.t_kurang_puas::DOUBLE PRECISION / s.t_konfirmasi * 100) ELSE 0.0 END,
    s.t_dibuka_ulang,
    CASE WHEN s.t_selesai > 0 THEN (s.t_dibuka_ulang::DOUBLE PRECISION / s.t_selesai * 100) ELSE 0.0 END
  FROM stats s;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- ---------------------------------------------------------------------------
-- 10. RPC DASHBOARD: fn_dashboard_umur_laporan
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.fn_dashboard_umur_laporan(
  p_kategori_slug TEXT DEFAULT NULL,
  p_kecamatan_kode TEXT DEFAULT NULL,
  p_sumber TEXT DEFAULT 'semua'
)
RETURNS TABLE (
  rentang_hari TEXT,
  jumlah BIGINT,
  jumlah_terlambat BIGINT
) AS $$
BEGIN
  RETURN QUERY
  WITH laporan_aktif AS (
    SELECT 
      l.id,
      EXTRACT(DAY FROM (NOW() - l.created_at))::INTEGER AS hari,
      k.sla_hari
    FROM public.laporan l
    JOIN public.kategori k ON l.kategori_id = k.id
    LEFT JOIN public.kelurahan kel ON l.kelurahan_id = kel.id
    LEFT JOIN public.kecamatan kec ON kel.kecamatan_id = kec.id
    WHERE l.status NOT IN ('selesai', 'ditolak')
      AND (p_kategori_slug IS NULL OR k.slug = p_kategori_slug)
      AND (p_kecamatan_kode IS NULL OR kec.kode_wilayah = p_kecamatan_kode)
      AND (p_sumber = 'semua' 
           OR (p_sumber = 'asli' AND l.is_simulasi = FALSE)
           OR (p_sumber = 'simulasi' AND l.is_simulasi = TRUE))
  )
  SELECT
    CASE
      WHEN la.hari <= 3 THEN '0-3 hari'
      WHEN la.hari <= 7 THEN '4-7 hari'
      WHEN la.hari <= 14 THEN '8-14 hari'
      WHEN la.hari <= 30 THEN '15-30 hari'
      ELSE '> 30 hari'
    END AS rentang_hari,
    COUNT(*) AS jumlah,
    COUNT(*) FILTER (WHERE la.hari > la.sla_hari) AS jumlah_terlambat
  FROM laporan_aktif la
  GROUP BY
    CASE
      WHEN la.hari <= 3 THEN '0-3 hari'
      WHEN la.hari <= 7 THEN '4-7 hari'
      WHEN la.hari <= 14 THEN '8-14 hari'
      WHEN la.hari <= 30 THEN '15-30 hari'
      ELSE '> 30 hari'
    END
  ORDER BY MIN(la.hari);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- Hak eksekusi untuk pengguna publik (anon) dan terautentikasi (authenticated)
GRANT EXECUTE ON FUNCTION public.fn_laporan_serupa TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.fn_validasi_transisi_status TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.fn_hitung_sla TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.fn_dashboard_tren TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.fn_dashboard_waktu_penanganan TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.fn_dashboard_per_kapita TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.fn_dashboard_konfirmasi TO anon, authenticated;
GRANT EXECUTE ON FUNCTION public.fn_dashboard_umur_laporan TO anon, authenticated;

