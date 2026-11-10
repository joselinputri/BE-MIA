-- =============================================================================
-- 007_tabel_audit_data.sql
-- Migrasi: Tabel audit_log, data_penduduk_resmi, dan rekap_ulas
-- Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
-- =============================================================================
-- File ini idempoten: aman dijalankan berulang kali.
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. TABEL audit_log
--    Tabel append-only untuk merekam aksi sensitif (ubah status, tolak laporan,
--    akses kontak pelapor, perubahan role pengguna, dsb).
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.audit_log (
  id            UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID           REFERENCES auth.users(id) ON DELETE SET NULL,
  aksi          VARCHAR(100)   NOT NULL, -- 'ubah_status', 'tolak_laporan', 'akses_kontak', 'ubah_role', 'hapus_data'
  tabel_target  VARCHAR(100),
  record_id     UUID,
  detail        JSONB,
  ip_address    INET,
  user_agent    TEXT,
  created_at    TIMESTAMPTZ    NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.audit_log IS 'Log audit aksi administratif dan sensitif (append-only)';
COMMENT ON COLUMN public.audit_log.aksi IS 'Jenis aksi sensitif yang dilakukan pengguna';
COMMENT ON COLUMN public.audit_log.detail IS 'Snapshot metadata / nilai lama dan baru dalam format JSONB';

-- ---------------------------------------------------------------------------
-- 2. TABEL data_penduduk_resmi
--    Penyimpanan historis data agregat kependudukan per kelurahan dari sumber resmi
--    (Dispendukcapil / SoloData / BPS).
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.data_penduduk_resmi (
  id               UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  kelurahan_id     UUID              REFERENCES public.kelurahan(id) ON DELETE CASCADE,
  tahun            INTEGER           NOT NULL CHECK (tahun BETWEEN 2000 AND 2100),
  semester         SMALLINT          CHECK (semester IN (1, 2)),
  jumlah_penduduk  INTEGER           NOT NULL CHECK (jumlah_penduduk >= 0),
  jumlah_kk        INTEGER           CHECK (jumlah_kk >= 0),
  sumber_data_id   UUID              REFERENCES public.sumber_data(id),
  provenance       provenance_type   NOT NULL DEFAULT 'agregat_resmi',
  created_at       TIMESTAMPTZ       NOT NULL DEFAULT NOW(),

  CONSTRAINT uq_penduduk_kelurahan_periode UNIQUE (kelurahan_id, tahun, semester)
);

COMMENT ON TABLE public.data_penduduk_resmi IS 'Data agregat resmi jumlah penduduk per kelurahan per semester/tahun';

-- ---------------------------------------------------------------------------
-- 3. TABEL rekap_ulas
--    Rekap data aduan agregat resmi ULAS (Unit Layanan Aduan Surakarta)
--    yang dipublikasikan di Portal Data Terbuka (Jawa Tengah / Surakarta).
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.rekap_ulas (
  id               UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  periode          VARCHAR(50)       NOT NULL, -- Misal '2023-01', '2023-Semester-2', '2024'
  dinas_nama       VARCHAR(200)      NOT NULL,
  jumlah_aduan     INTEGER           NOT NULL CHECK (jumlah_aduan >= 0),
  topik_terbanyak  TEXT[],
  sumber_data_id   UUID              REFERENCES public.sumber_data(id),
  provenance       provenance_type   NOT NULL DEFAULT 'agregat_resmi',
  created_at       TIMESTAMPTZ       NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.rekap_ulas IS 'Rekap agregat aduan ULAS dari portal data resmi';

