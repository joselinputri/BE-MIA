-- =============================================================================
-- 006_tabel_notifikasi.sql
-- Migrasi: Tabel notifikasi in-app dan antrean email
-- Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
-- =============================================================================
-- File ini idempoten: aman dijalankan berulang kali.
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. TABEL notifikasi
--    Notifikasi in-app untuk pengguna terdaftar maupun pelapor anonim
--    (dilacak via kode_lacak). Minimal salah satu dari user_id atau
--    kode_lacak harus terisi.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.notifikasi (
  id          UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID           REFERENCES auth.users(id) ON DELETE CASCADE,  -- NULL jika anonim
  kode_lacak  VARCHAR(12),   -- untuk tracking anonim, referensi ke laporan.kode_lacak
  laporan_id  UUID           REFERENCES public.laporan(id) ON DELETE CASCADE,
  judul       VARCHAR(200)   NOT NULL,
  pesan       TEXT           NOT NULL CHECK (char_length(pesan) <= 1000),
  tipe        VARCHAR(50)    NOT NULL,  -- 'status_berubah', 'verifikasi_diminta', 'konfirmasi_diminta', 'laporan_didukung', 'info'
  is_dibaca   BOOLEAN        NOT NULL DEFAULT FALSE,
  created_at  TIMESTAMPTZ    NOT NULL DEFAULT NOW(),

  -- Minimal salah satu target harus diisi
  CONSTRAINT notifikasi_punya_target CHECK (
    user_id IS NOT NULL OR kode_lacak IS NOT NULL
  )
);

COMMENT ON TABLE  public.notifikasi IS 'Notifikasi in-app — untuk pengguna terdaftar maupun pelapor anonim';
COMMENT ON COLUMN public.notifikasi.kode_lacak IS 'Kode lacak untuk pelapor anonim, merujuk ke laporan.kode_lacak';
COMMENT ON COLUMN public.notifikasi.tipe       IS 'Jenis notifikasi: status_berubah, verifikasi_diminta, konfirmasi_diminta, laporan_didukung, info';
COMMENT ON COLUMN public.notifikasi.is_dibaca  IS 'Tandai apakah notifikasi sudah dibaca oleh penerima';

-- ---------------------------------------------------------------------------
-- 2. TABEL antrean_email
--    Antrean (queue) sederhana untuk pengiriman notifikasi via email.
--    Mendukung retry sampai 5 kali percobaan.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.antrean_email (
  id              UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  notifikasi_id   UUID           REFERENCES public.notifikasi(id) ON DELETE CASCADE,
  email_tujuan    VARCHAR(254)   NOT NULL,
  subjek          VARCHAR(200)   NOT NULL,
  isi_html        TEXT,
  status          status_email   NOT NULL DEFAULT 'pending',
  percobaan       SMALLINT       NOT NULL DEFAULT 0 CHECK (percobaan >= 0 AND percobaan <= 5),
  error_terakhir  TEXT,
  created_at      TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
  sent_at         TIMESTAMPTZ
);

COMMENT ON TABLE  public.antrean_email IS 'Antrean email — queue sederhana untuk notifikasi email dengan mekanisme retry';
COMMENT ON COLUMN public.antrean_email.percobaan      IS 'Jumlah percobaan pengiriman (maksimal 5)';
COMMENT ON COLUMN public.antrean_email.error_terakhir  IS 'Pesan error dari percobaan pengiriman terakhir';
COMMENT ON COLUMN public.antrean_email.sent_at         IS 'Waktu email berhasil terkirim';

-- ---------------------------------------------------------------------------
-- 3. INDEKS
-- ---------------------------------------------------------------------------
-- Notifikasi: pencarian cepat berdasarkan user dan status baca
CREATE INDEX IF NOT EXISTS idx_notifikasi_user_id    ON public.notifikasi(user_id);
CREATE INDEX IF NOT EXISTS idx_notifikasi_kode_lacak ON public.notifikasi(kode_lacak);
CREATE INDEX IF NOT EXISTS idx_notifikasi_laporan_id ON public.notifikasi(laporan_id);
CREATE INDEX IF NOT EXISTS idx_notifikasi_belum_baca ON public.notifikasi(user_id, is_dibaca)
  WHERE is_dibaca = FALSE;

-- Antrean email: pencarian cepat email yang masih pending
CREATE INDEX IF NOT EXISTS idx_antrean_email_status  ON public.antrean_email(status)
  WHERE status = 'pending';
CREATE INDEX IF NOT EXISTS idx_antrean_email_notif   ON public.antrean_email(notifikasi_id);
