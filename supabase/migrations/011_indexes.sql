-- =============================================================================
-- 011_indexes.sql
-- Indeks Database: GIST Spasial, B-Tree Komposit, dan GIN Full-Text Search
-- Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
-- =============================================================================
-- File ini idempoten: menggunakan CREATE INDEX IF NOT EXISTS.
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. INDEKS SPASIAL (GIST)
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_laporan_koordinat_gist
  ON public.laporan USING GIST (koordinat);

CREATE INDEX IF NOT EXISTS idx_laporan_koordinat_publik_gist
  ON public.laporan USING GIST (koordinat_publik);

CREATE INDEX IF NOT EXISTS idx_kelurahan_geometri_gist
  ON public.kelurahan USING GIST (geometri);

CREATE INDEX IF NOT EXISTS idx_kecamatan_geometri_gist
  ON public.kecamatan USING GIST (geometri);

-- ---------------------------------------------------------------------------
-- 2. INDEKS PENCARIAN & FILTER LAPORAN
-- ---------------------------------------------------------------------------
-- Antrean dan daftar publik berurutan waktu (cursor pagination)
CREATE INDEX IF NOT EXISTS idx_laporan_status_created_at
  ON public.laporan (status, created_at DESC);

-- Filter laporan berdasarkan kategori
CREATE INDEX IF NOT EXISTS idx_laporan_kategori_created_at
  ON public.laporan (kategori_id, created_at DESC);

-- Filter laporan berdasarkan kelurahan
CREATE INDEX IF NOT EXISTS idx_laporan_kelurahan_created_at
  ON public.laporan (kelurahan_id, created_at DESC);

-- Antrean tugas petugas per dinas
CREATE INDEX IF NOT EXISTS idx_laporan_dinas_status_created
  ON public.laporan (dinas_id, status, created_at DESC);

-- Daftar riwayat laporan milik pengguna
CREATE INDEX IF NOT EXISTS idx_laporan_pelapor_created_at
  ON public.laporan (pelapor_id, created_at DESC)
  WHERE pelapor_id IS NOT NULL;

-- Filter agregasi data dashboard (asli vs simulasi)
CREATE INDEX IF NOT EXISTS idx_laporan_simulasi_created_at
  ON public.laporan (is_simulasi, created_at DESC);

-- Lookup kode lacak (B-tree)
CREATE INDEX IF NOT EXISTS idx_laporan_kode_lacak
  ON public.laporan (kode_lacak);

-- ---------------------------------------------------------------------------
-- 3. INDEKS PENCARIAN TEKS FUZZY (GIN trgm)
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_laporan_judul_trgm
  ON public.laporan USING GIN (judul gin_trgm_ops);

CREATE INDEX IF NOT EXISTS idx_laporan_deskripsi_trgm
  ON public.laporan USING GIN (deskripsi gin_trgm_ops);

-- ---------------------------------------------------------------------------
-- 4. INDEKS RIWAYAT STATUS & DUKUNGAN
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_status_history_laporan_created
  ON public.status_history (laporan_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_dukungan_laporan_laporan_id
  ON public.dukungan_laporan (laporan_id);

CREATE INDEX IF NOT EXISTS idx_konfirmasi_laporan_id
  ON public.konfirmasi_pelapor (laporan_id);

-- ---------------------------------------------------------------------------
-- 5. INDEKS NOTIFIKASI & ANTREAN EMAIL
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_notifikasi_user_dibaca
  ON public.notifikasi (user_id, is_dibaca, created_at DESC)
  WHERE user_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_notifikasi_kode_lacak
  ON public.notifikasi (kode_lacak)
  WHERE kode_lacak IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_antrean_email_status
  ON public.antrean_email (status, percobaan)
  WHERE status = 'pending';

-- ---------------------------------------------------------------------------
-- 6. INDEKS AUDIT LOG & DATA AGREGAT
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_audit_log_record_target
  ON public.audit_log (tabel_target, record_id);

CREATE INDEX IF NOT EXISTS idx_audit_log_user_created
  ON public.audit_log (user_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_penduduk_kelurahan_periode
  ON public.data_penduduk_resmi (kelurahan_id, tahun, semester);

