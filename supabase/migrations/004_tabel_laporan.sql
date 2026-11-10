-- ============================================================================
-- 004_tabel_laporan.sql
-- Membuat tabel-tabel terkait laporan warga untuk platform RAMPUNG.
-- Termasuk trigger otomatis untuk:
--   - Pembulatan koordinat publik (~100m) demi privasi
--   - Pencatatan updated_at
--   - Penentuan kelurahan otomatis dari koordinat
--   - Penentuan dinas otomatis dari kategori
--   - Pencatatan riwayat status awal
-- File ini idempoten: aman dijalankan berulang kali.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Tabel: laporan
-- Tabel utama yang menyimpan setiap laporan aduan warga.
-- Setiap laporan memiliki kode lacak unik, koordinat geospasial,
-- dan mengikuti siklus hidup status tertentu.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS laporan (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kode_lacak          VARCHAR(12) UNIQUE NOT NULL,        -- kode lacak unik untuk warga melacak laporan
  judul               VARCHAR(200) NOT NULL               -- judul singkat laporan
                        CHECK (char_length(judul) >= 5),
  deskripsi           TEXT NOT NULL                        -- deskripsi lengkap permasalahan
                        CHECK (char_length(deskripsi) >= 20),
  kategori_id         UUID NOT NULL                        -- kategori permasalahan
                        REFERENCES kategori(id) ON DELETE RESTRICT,
  kelurahan_id        UUID                                 -- kelurahan lokasi laporan (auto-set dari koordinat)
                        REFERENCES kelurahan(id) ON DELETE SET NULL,
  koordinat           GEOMETRY(Point, 4326) NOT NULL,      -- titik lokasi tepat (rahasia, hanya untuk petugas)
  koordinat_publik    GEOMETRY(Point, 4326),                -- titik lokasi dibulatkan ~100m (untuk peta publik)
  foto_sebelum_paths  TEXT[] NOT NULL DEFAULT '{}',         -- path foto kondisi sebelum penanganan
  foto_sesudah_paths  TEXT[] DEFAULT '{}',                  -- path foto kondisi sesudah penanganan
  is_anonim           BOOLEAN NOT NULL DEFAULT FALSE,       -- apakah pelapor ingin melapor secara anonim
  pelapor_id          UUID                                  -- ID user pelapor (NULL jika anonim)
                        REFERENCES auth.users(id) ON DELETE SET NULL,
  status              status_laporan NOT NULL DEFAULT 'masuk', -- status siklus hidup laporan
  penanda             penanda_laporan[] DEFAULT '{}',       -- penanda/flag tambahan pada laporan
  dinas_id            UUID NOT NULL                         -- dinas penanggung jawab (auto-set dari kategori)
                        REFERENCES dinas(id) ON DELETE RESTRICT,
  is_simulasi         BOOLEAN NOT NULL DEFAULT FALSE,       -- apakah data ini hasil simulasi
  provenance          provenance_type NOT NULL DEFAULT 'asli', -- asal-usul data
  sumber_data_id      UUID                                  -- referensi sumber data (untuk data impor)
                        REFERENCES sumber_data(id),
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Koordinat harus berada dalam bounding box Kota Surakarta
  CONSTRAINT koordinat_dalam_surakarta CHECK (
    ST_X(koordinat) BETWEEN 110.77 AND 110.87
    AND ST_Y(koordinat) BETWEEN -7.60 AND -7.52
  )
);


-- ===== TRIGGER 1: Auto-set koordinat_publik =================================
-- Membulatkan koordinat ke grid ~100m (0.001 derajat) untuk melindungi
-- privasi lokasi tepat pelapor di peta publik.
-- =============================================================================
CREATE OR REPLACE FUNCTION fn_set_koordinat_publik()
RETURNS TRIGGER AS $$
BEGIN
  NEW.koordinat_publik := ST_SnapToGrid(NEW.koordinat, 0.001);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Hapus trigger lama jika ada, lalu buat ulang (idempoten)
DROP TRIGGER IF EXISTS trg_set_koordinat_publik ON laporan;
CREATE TRIGGER trg_set_koordinat_publik
  BEFORE INSERT OR UPDATE OF koordinat ON laporan
  FOR EACH ROW
  EXECUTE FUNCTION fn_set_koordinat_publik();


-- ===== TRIGGER 2: Auto-set updated_at ========================================
-- Memperbarui kolom updated_at setiap kali baris laporan di-update.
-- =============================================================================
CREATE OR REPLACE FUNCTION fn_set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at := NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_set_updated_at ON laporan;
CREATE TRIGGER trg_set_updated_at
  BEFORE UPDATE ON laporan
  FOR EACH ROW
  EXECUTE FUNCTION fn_set_updated_at();


-- ===== TRIGGER 3: Auto-tentukan kelurahan_id dari koordinat ==================
-- Jika kelurahan_id tidak diisi saat INSERT atau UPDATE koordinat,
-- sistem akan mencari kelurahan yang geometrinya mengandung titik koordinat.
-- =============================================================================
CREATE OR REPLACE FUNCTION fn_set_kelurahan_dari_koordinat()
RETURNS TRIGGER AS $$
BEGIN
  -- Hanya auto-set jika kelurahan_id belum diisi
  IF NEW.kelurahan_id IS NULL THEN
    SELECT id INTO NEW.kelurahan_id
    FROM kelurahan
    WHERE ST_Contains(geometri, NEW.koordinat)
    LIMIT 1;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_set_kelurahan ON laporan;
CREATE TRIGGER trg_set_kelurahan
  BEFORE INSERT OR UPDATE OF koordinat ON laporan
  FOR EACH ROW
  EXECUTE FUNCTION fn_set_kelurahan_dari_koordinat();


-- ===== TRIGGER 4: Auto-tentukan dinas_id dari kategori_id ====================
-- Jika dinas_id tidak diisi atau berubah kategori, sistem mengambil
-- dinas_id dari tabel kategori yang dipilih.
-- =============================================================================
CREATE OR REPLACE FUNCTION fn_set_dinas_dari_kategori()
RETURNS TRIGGER AS $$
BEGIN
  -- Auto-set dinas_id dari kategori saat INSERT, atau saat kategori berubah pada UPDATE
  IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE' AND OLD.kategori_id IS DISTINCT FROM NEW.kategori_id) THEN
    SELECT dinas_id INTO NEW.dinas_id
    FROM kategori
    WHERE id = NEW.kategori_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_set_dinas ON laporan;
CREATE TRIGGER trg_set_dinas
  BEFORE INSERT OR UPDATE OF kategori_id ON laporan
  FOR EACH ROW
  EXECUTE FUNCTION fn_set_dinas_dari_kategori();


-- ---------------------------------------------------------------------------
-- Tabel: status_history
-- Mencatat setiap perubahan status pada laporan untuk audit trail.
-- Baris pertama (status_dari = NULL) dibuat otomatis saat laporan masuk.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS status_history (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  laporan_id    UUID NOT NULL                            -- laporan terkait
                  REFERENCES laporan(id) ON DELETE CASCADE,
  status_dari   status_laporan,                           -- status sebelumnya (NULL untuk status awal)
  status_ke     status_laporan NOT NULL,                  -- status tujuan
  catatan       TEXT                                      -- catatan opsional dari petugas
                  CHECK (catatan IS NULL OR char_length(catatan) <= 1000),
  diubah_oleh   UUID                                     -- petugas yang mengubah status
                  REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


-- ===== TRIGGER: Auto-catat status awal pada status_history ===================
-- Saat laporan baru di-INSERT, otomatis buat baris riwayat pertama
-- dengan status_dari = NULL dan status_ke = 'masuk'.
-- =============================================================================
CREATE OR REPLACE FUNCTION fn_catat_status_awal()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO status_history (laporan_id, status_dari, status_ke)
  VALUES (NEW.id, NULL, 'masuk');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_catat_status_awal ON laporan;
CREATE TRIGGER trg_catat_status_awal
  AFTER INSERT ON laporan
  FOR EACH ROW
  EXECUTE FUNCTION fn_catat_status_awal();


-- ---------------------------------------------------------------------------
-- Tabel: dukungan_laporan
-- Menyimpan upvote/dukungan warga terhadap laporan yang ada.
-- Satu user hanya bisa mendukung satu kali per laporan.
-- User anonim diidentifikasi via hash IP.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dukungan_laporan (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  laporan_id    UUID NOT NULL                            -- laporan yang didukung
                  REFERENCES laporan(id) ON DELETE CASCADE,
  user_id       UUID                                     -- user yang mendukung (NULL jika anonim)
                  REFERENCES auth.users(id) ON DELETE CASCADE,
  ip_hash       VARCHAR(64),                              -- SHA-256 hash IP untuk pendukung anonim
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Constraint unik: satu user hanya bisa dukung 1x per laporan (user login)
-- Menggunakan partial unique index karena UNIQUE constraint biasa tidak bisa pakai WHERE
DROP INDEX IF EXISTS uq_dukungan_user;
CREATE UNIQUE INDEX uq_dukungan_user
  ON dukungan_laporan (laporan_id, user_id)
  WHERE user_id IS NOT NULL;

-- Constraint unik: satu IP hanya bisa dukung 1x per laporan (user anonim)
DROP INDEX IF EXISTS uq_dukungan_ip;
CREATE UNIQUE INDEX uq_dukungan_ip
  ON dukungan_laporan (laporan_id, ip_hash)
  WHERE ip_hash IS NOT NULL;


-- ---------------------------------------------------------------------------
-- Tabel: konfirmasi_pelapor
-- Menyimpan konfirmasi kepuasan pelapor setelah laporan ditandai selesai.
-- Setiap laporan hanya bisa dikonfirmasi satu kali.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS konfirmasi_pelapor (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  laporan_id    UUID NOT NULL                            -- laporan yang dikonfirmasi
                  REFERENCES laporan(id) ON DELETE CASCADE,
  jawaban       jawaban_konfirmasi NOT NULL,              -- jawaban kepuasan (puas/biasa/kurang_puas)
  komentar      TEXT                                      -- komentar opsional dari pelapor
                  CHECK (komentar IS NULL OR char_length(komentar) <= 500),
  rating        SMALLINT                                  -- rating 1-5 bintang
                  CHECK (rating BETWEEN 1 AND 5),
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Setiap laporan hanya bisa dikonfirmasi satu kali
  UNIQUE (laporan_id)
);
