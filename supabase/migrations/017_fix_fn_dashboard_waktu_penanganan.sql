-- ============================================================
-- 017_fix_fn_dashboard_waktu_penanganan.sql
-- Perbaikan tipe data kolom rata_rata_hari (numeric -> double precision)
-- ============================================================

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
      ORDER BY (EXTRACT(EPOCH FROM (sh_selesai.created_at - l.created_at)) / 86400.0)
    ), 0.0)::DOUBLE PRECISION AS median_hari,
    COALESCE(AVG(EXTRACT(EPOCH FROM (sh_selesai.created_at - l.created_at)) / 86400.0)::DOUBLE PRECISION, 0.0::DOUBLE PRECISION) AS rata_rata_hari,
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
    WHERE sh.laporan_id = l.id
      AND sh.status_ke = 'selesai'
    ORDER BY sh.created_at ASC
    LIMIT 1
  ) sh_selesai ON true
  WHERE (l.created_at::DATE BETWEEN p_periode_mulai AND p_periode_akhir)
    AND (p_kategori_slug IS NULL OR k.slug = p_kategori_slug)
    AND (p_kecamatan_kode IS NULL OR kec.kode = p_kecamatan_kode)
    AND (
      p_sumber = 'semua'
      OR (p_sumber = 'asli' AND l.is_simulasi = false)
      OR (p_sumber = 'simulasi' AND l.is_simulasi = true)
    )
  GROUP BY k.id, k.nama, k.slug, d.id, d.nama, d.singkatan;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;
