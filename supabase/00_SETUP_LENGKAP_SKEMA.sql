-- ============================================================================
-- 001_extensions.sql
-- Mengaktifkan extension PostgreSQL yang dibutuhkan platform RAMPUNG
-- File ini idempoten: aman dijalankan berulang kali.
-- ============================================================================

-- PostGIS: dukungan tipe data & fungsi geospasial (titik koordinat, polygon wilayah)
CREATE EXTENSION IF NOT EXISTS postgis;

-- pgcrypto: fungsi kriptografi, digunakan untuk generate kode lacak acak
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- uuid-ossp: fungsi pembuatan UUID (v4 dll), cadangan selain gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- pg_trgm: trigram-based text similarity, untuk pencarian fuzzy laporan serupa
CREATE EXTENSION IF NOT EXISTS pg_trgm;



-- ============================================================================
-- 002_enums_types.sql
-- Mendefinisikan semua custom ENUM types untuk platform RAMPUNG.
-- Menggunakan DO block karena CREATE TYPE tidak mendukung IF NOT EXISTS.
-- File ini idempoten: aman dijalankan berulang kali.
-- ============================================================================

-- Peran pengguna dalam sistem
-- warga   : pelapor / masyarakat umum
-- petugas : petugas dinas yang menangani laporan
-- admin   : administrator sistem
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'role_type') THEN
    CREATE TYPE role_type AS ENUM ('warga', 'petugas', 'admin');
  END IF;
END
$$;

-- Status utama siklus hidup laporan
-- masuk            : laporan baru masuk
-- ditinjau         : sedang ditinjau oleh petugas
-- sedang_ditangani : pekerjaan penanganan sedang berjalan
-- selesai          : laporan telah diselesaikan
-- ditolak          : laporan ditolak (tidak valid / di luar cakupan)
-- dibuka_ulang     : laporan dibuka ulang karena belum tuntas
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'status_laporan') THEN
    CREATE TYPE status_laporan AS ENUM (
      'masuk', 'ditinjau', 'sedang_ditangani', 'selesai', 'ditolak', 'dibuka_ulang'
    );
  END IF;
END
$$;

-- Penanda (flag) tambahan pada laporan, bisa lebih dari satu per laporan
-- perlu_verifikasi_tambahan : laporan butuh verifikasi lanjutan
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'penanda_laporan') THEN
    CREATE TYPE penanda_laporan AS ENUM ('perlu_verifikasi_tambahan');
  END IF;
END
$$;

-- Asal-usul / provenance data
-- asli                   : data asli hasil pengamatan langsung
-- agregat_resmi          : data agregat dari sumber resmi (BPS, dsb)
-- simulasi_terkalibrasi  : data hasil simulasi yang sudah dikalibrasi
-- simulasi               : data hasil simulasi murni (belum dikalibrasi)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'provenance_type') THEN
    CREATE TYPE provenance_type AS ENUM (
      'asli', 'agregat_resmi', 'simulasi_terkalibrasi', 'simulasi'
    );
  END IF;
END
$$;

-- Jawaban konfirmasi kepuasan pelapor setelah laporan diselesaikan
-- puas        : pelapor puas dengan penanganan
-- biasa       : pelapor merasa biasa saja
-- kurang_puas : pelapor kurang puas
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'jawaban_konfirmasi') THEN
    CREATE TYPE jawaban_konfirmasi AS ENUM ('puas', 'biasa', 'kurang_puas');
  END IF;
END
$$;

-- Status antrean pengiriman email notifikasi
-- pending  : menunggu dikirim
-- terkirim : berhasil terkirim
-- gagal    : pengiriman gagal
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'status_email') THEN
    CREATE TYPE status_email AS ENUM ('pending', 'terkirim', 'gagal');
  END IF;
END
$$;

-- Preferensi saluran notifikasi pengguna
-- in_app : notifikasi hanya di dalam aplikasi
-- email  : notifikasi hanya via email
-- semua  : notifikasi via semua saluran
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'preferensi_notif_type') THEN
    CREATE TYPE preferensi_notif_type AS ENUM ('in_app', 'email', 'semua');
  END IF;
END
$$;



-- ============================================================================
-- 003_tabel_referensi.sql
-- Membuat tabel-tabel referensi (master data) untuk platform RAMPUNG.
-- Semua tabel menggunakan UUID sebagai primary key.
-- File ini idempoten: aman dijalankan berulang kali.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Tabel: sumber_data
-- Mencatat asal-usul data yang diimpor ke dalam sistem, termasuk data
-- wilayah (kecamatan, kelurahan) dan data laporan hasil simulasi.
-- Berguna untuk pelacakan provenance & transparansi data.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS sumber_data (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nama                VARCHAR(200) NOT NULL,           -- nama sumber data (misal: "BPS Surakarta 2024")
  url                 TEXT,                             -- tautan ke sumber asli
  tahun_data          INTEGER,                          -- tahun data dikumpulkan
  tanggal_akses       DATE,                             -- kapan data diakses / diunduh
  lisensi             TEXT,                             -- jenis lisensi data (misal: "CC-BY-4.0")
  catatan_pengolahan  TEXT,                             -- catatan proses pengolahan data
  provenance          provenance_type NOT NULL,         -- asal-usul data (asli, simulasi, dsb)
  created_at          TIMESTAMPTZ DEFAULT NOW()
);

-- ---------------------------------------------------------------------------
-- Tabel: dinas
-- Daftar dinas/OPD (Organisasi Perangkat Daerah) Kota Surakarta yang
-- bertanggung jawab menangani laporan warga berdasarkan kategori.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dinas (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nama        VARCHAR(100) NOT NULL,                    -- nama lengkap dinas
  singkatan   VARCHAR(20) NOT NULL UNIQUE,              -- singkatan resmi (misal: "DPUPR")
  deskripsi   TEXT,                                     -- deskripsi tugas & fungsi dinas
  is_aktif    BOOLEAN DEFAULT TRUE,                     -- apakah dinas masih aktif
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ---------------------------------------------------------------------------
-- Tabel: kategori
-- Kategori permasalahan laporan. Setiap kategori dimiliki oleh satu dinas
-- dan memiliki SLA (Service Level Agreement) dalam hari kerja.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS kategori (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nama        VARCHAR(100) NOT NULL,                    -- nama kategori (misal: "Jalan Rusak")
  slug        VARCHAR(50) UNIQUE NOT NULL,              -- slug URL-friendly (misal: "jalan-rusak")
  ikon        VARCHAR(50),                              -- nama ikon untuk tampilan frontend
  dinas_id    UUID NOT NULL                             -- dinas penanggung jawab kategori ini
                REFERENCES dinas(id) ON DELETE RESTRICT,
  sla_hari    INTEGER NOT NULL DEFAULT 7                -- target penyelesaian dalam hari
                CHECK (sla_hari > 0 AND sla_hari <= 90),
  is_aktif    BOOLEAN DEFAULT TRUE,                     -- apakah kategori masih aktif
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ---------------------------------------------------------------------------
-- Tabel: kecamatan
-- Data wilayah kecamatan di Kota Surakarta.
-- Menyimpan geometri batas wilayah (MultiPolygon) dalam EPSG:4326.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS kecamatan (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nama              VARCHAR(100) NOT NULL,              -- nama kecamatan
  kode_wilayah      VARCHAR(20) UNIQUE NOT NULL,        -- kode wilayah BPS (misal: '33.72.01')
  jumlah_penduduk   INTEGER                             -- jumlah penduduk (opsional)
                      CHECK (jumlah_penduduk >= 0),
  geometri          GEOMETRY(MultiPolygon, 4326),       -- batas wilayah kecamatan
  provenance        provenance_type DEFAULT 'asli',     -- asal-usul data geometri
  sumber_data_id    UUID                                -- referensi ke sumber data
                      REFERENCES sumber_data(id),
  created_at        TIMESTAMPTZ DEFAULT NOW()
);

-- ---------------------------------------------------------------------------
-- Tabel: kelurahan
-- Data wilayah kelurahan di Kota Surakarta.
-- Setiap kelurahan berada di bawah satu kecamatan.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS kelurahan (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nama              VARCHAR(100) NOT NULL,              -- nama kelurahan
  kode_wilayah      VARCHAR(20) UNIQUE NOT NULL,        -- kode wilayah BPS (misal: '33.72.01.1001')
  kecamatan_id      UUID NOT NULL                       -- kecamatan induk
                      REFERENCES kecamatan(id) ON DELETE RESTRICT,
  jumlah_penduduk   INTEGER                             -- jumlah penduduk (opsional)
                      CHECK (jumlah_penduduk >= 0),
  geometri          GEOMETRY(MultiPolygon, 4326),       -- batas wilayah kelurahan
  provenance        provenance_type DEFAULT 'asli',     -- asal-usul data geometri
  sumber_data_id    UUID                                -- referensi ke sumber data
                      REFERENCES sumber_data(id),
  created_at        TIMESTAMPTZ DEFAULT NOW()
);



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



-- =============================================================================
-- 005_tabel_pengguna.sql
-- Migrasi: Tabel profil pengguna, kontak pelapor, dan fungsi helper RLS
-- Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
-- =============================================================================
-- File ini idempoten: aman dijalankan berulang kali.
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. TABEL profiles
--    Memperluas data auth.users bawaan Supabase dengan informasi profil
--    seperti role, nama, dinas (untuk petugas), avatar, dan nomor telepon.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.profiles (
  id          UUID           PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  role        role_type      NOT NULL DEFAULT 'warga',
  nama        VARCHAR(100),
  dinas_id    UUID           REFERENCES public.dinas(id) ON DELETE SET NULL,  -- hanya untuk petugas
  avatar_url  TEXT,
  no_telepon  VARCHAR(20),   -- opsional, untuk profil
  created_at  TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ    NOT NULL DEFAULT NOW(),

  -- Petugas wajib memiliki dinas_id; role lain boleh NULL
  CONSTRAINT petugas_harus_punya_dinas CHECK (
    role != 'petugas' OR dinas_id IS NOT NULL
  )
);

COMMENT ON TABLE  public.profiles IS 'Profil pengguna — ekstensi dari auth.users Supabase';
COMMENT ON COLUMN public.profiles.role       IS 'Peran pengguna: warga, petugas, atau admin';
COMMENT ON COLUMN public.profiles.dinas_id   IS 'Dinas terkait (wajib diisi jika role = petugas)';
COMMENT ON COLUMN public.profiles.no_telepon IS 'Nomor telepon opsional untuk profil';

-- ---------------------------------------------------------------------------
-- 2. TRIGGER: Otomatis buat profil saat user baru terdaftar di auth.users
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, role, nama)
  VALUES (
    NEW.id,
    'warga',
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.raw_user_meta_data->>'name', '')
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

COMMENT ON FUNCTION public.handle_new_user()
  IS 'Trigger function: buat baris profiles otomatis saat user baru mendaftar';

-- Drop trigger lama jika ada, lalu buat ulang (idempoten)
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- ---------------------------------------------------------------------------
-- 3. TABEL kontak_pelapor
--    Data kontak pelapor terpisah dari tabel laporan agar bisa dijaga ketat
--    melalui RLS. Satu kontak per laporan.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.kontak_pelapor (
  id               UUID                    PRIMARY KEY DEFAULT gen_random_uuid(),
  laporan_id       UUID                    NOT NULL REFERENCES public.laporan(id) ON DELETE CASCADE,
  user_id          UUID                    REFERENCES auth.users(id) ON DELETE SET NULL,
  email            VARCHAR(254)            CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z]{2,}$'),
  telepon          VARCHAR(20),
  preferensi_notif preferensi_notif_type   DEFAULT 'in_app',
  created_at       TIMESTAMPTZ             NOT NULL DEFAULT NOW()
);

-- Satu kontak per laporan
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'kontak_pelapor_laporan_id_key'
  ) THEN
    ALTER TABLE public.kontak_pelapor ADD CONSTRAINT kontak_pelapor_laporan_id_key UNIQUE (laporan_id);
  END IF;
END $$;

COMMENT ON TABLE  public.kontak_pelapor IS 'Data kontak pelapor — terpisah dari laporan, dilindungi RLS ketat';
COMMENT ON COLUMN public.kontak_pelapor.preferensi_notif IS 'Preferensi notifikasi: in_app, email, atau semua';

-- ---------------------------------------------------------------------------
-- 4. FUNGSI HELPER untuk kebijakan RLS
--    Dipakai di policy-policy tabel lain untuk cek role/dinas user aktif.
-- ---------------------------------------------------------------------------

-- Mendapatkan role user yang sedang login
CREATE OR REPLACE FUNCTION public.get_user_role()
RETURNS role_type AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid()
$$ LANGUAGE sql SECURITY DEFINER STABLE;

COMMENT ON FUNCTION public.get_user_role()
  IS 'Mengembalikan role_type user yang sedang login';

-- Mendapatkan dinas_id user yang sedang login
CREATE OR REPLACE FUNCTION public.get_user_dinas_id()
RETURNS UUID AS $$
  SELECT dinas_id FROM public.profiles WHERE id = auth.uid()
$$ LANGUAGE sql SECURITY DEFINER STABLE;

COMMENT ON FUNCTION public.get_user_dinas_id()
  IS 'Mengembalikan dinas_id user yang sedang login (NULL jika bukan petugas)';

-- Cek apakah user adalah admin
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin'
  )
$$ LANGUAGE sql SECURITY DEFINER STABLE;

COMMENT ON FUNCTION public.is_admin()
  IS 'Mengembalikan TRUE jika user yang login memiliki role admin';

-- Cek apakah user adalah petugas atau admin
CREATE OR REPLACE FUNCTION public.is_petugas_atau_admin()
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('petugas', 'admin')
  )
$$ LANGUAGE sql SECURITY DEFINER STABLE;

COMMENT ON FUNCTION public.is_petugas_atau_admin()
  IS 'Mengembalikan TRUE jika user yang login memiliki role petugas atau admin';

-- ---------------------------------------------------------------------------
-- 5. INDEKS
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_profiles_role       ON public.profiles(role);
CREATE INDEX IF NOT EXISTS idx_profiles_dinas_id   ON public.profiles(dinas_id);
CREATE INDEX IF NOT EXISTS idx_kontak_pelapor_user ON public.kontak_pelapor(user_id);



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




-- =============================================================================
-- 009_rls_policies.sql
-- Migrasi: Row Level Security (RLS) pada SEMUA tabel dengan prinsip Default Deny
-- Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
-- =============================================================================
-- Prinsip Keamanan:
-- 1. Default Deny diaktifkan pada semua tabel publik.
-- 2. Warga hanya dapat melihat/mengubah data miliknya sendiri.
-- 3. Petugas dibatasi hanya pada laporan di bawah yurisdiksi dinasnya.
-- 4. Admin memiliki akses pengawasan penuh.
-- 5. Data kontak pelapor diisolasi secara ketat dan TIDAK PERNAH terekspos ke publik/anon.
-- =============================================================================

-- =============================================================================
-- A. AKTIFKAN RLS PADA SEMUA TABEL
-- =============================================================================
ALTER TABLE public.sumber_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dinas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.kategori ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.kecamatan ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.kelurahan ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.laporan ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.status_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dukungan_laporan ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.konfirmasi_pelapor ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.kontak_pelapor ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifikasi ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.antrean_email ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.data_penduduk_resmi ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.rekap_ulas ENABLE ROW LEVEL SECURITY;

-- =============================================================================
-- B. TABEL REFERENSI (Hanya Baca Publik, Tulis oleh Admin)
-- =============================================================================

-- 1. sumber_data
CREATE POLICY "Publik dapat membaca sumber data"
  ON public.sumber_data FOR SELECT
  USING (true);

CREATE POLICY "Admin dapat mengelola sumber data"
  ON public.sumber_data FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- 2. dinas
CREATE POLICY "Publik dapat membaca dinas yang aktif"
  ON public.dinas FOR SELECT
  USING (is_aktif = true OR public.is_petugas_atau_admin());

CREATE POLICY "Admin dapat mengelola dinas"
  ON public.dinas FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- 3. kategori
CREATE POLICY "Publik dapat membaca kategori aktif"
  ON public.kategori FOR SELECT
  USING (is_aktif = true OR public.is_petugas_atau_admin());

CREATE POLICY "Admin dapat mengelola kategori"
  ON public.kategori FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- 4. kecamatan
CREATE POLICY "Publik dapat membaca data kecamatan"
  ON public.kecamatan FOR SELECT
  USING (true);

CREATE POLICY "Admin dapat mengelola kecamatan"
  ON public.kecamatan FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- 5. kelurahan
CREATE POLICY "Publik dapat membaca data kelurahan"
  ON public.kelurahan FOR SELECT
  USING (true);

CREATE POLICY "Admin dapat mengelola kelurahan"
  ON public.kelurahan FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- 6. data_penduduk_resmi & rekap_ulas
CREATE POLICY "Publik dapat membaca data agregat resmi"
  ON public.data_penduduk_resmi FOR SELECT
  USING (true);

CREATE POLICY "Admin dapat mengelola data agregat kependudukan"
  ON public.data_penduduk_resmi FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

CREATE POLICY "Publik dapat membaca rekap ulas"
  ON public.rekap_ulas FOR SELECT
  USING (true);

CREATE POLICY "Admin dapat mengelola rekap ulas"
  ON public.rekap_ulas FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- =============================================================================
-- C. PROFIL PENGGUNA (profiles)
-- =============================================================================

CREATE POLICY "User dapat membaca profil diri sendiri"
  ON public.profiles FOR SELECT
  TO authenticated
  USING (id = auth.uid() OR public.is_petugas_atau_admin());

CREATE POLICY "User dapat memperbarui nama & profil sendiri"
  ON public.profiles FOR UPDATE
  TO authenticated
  USING (id = auth.uid())
  WITH CHECK (
    id = auth.uid() 
    AND role = (SELECT role FROM public.profiles WHERE id = auth.uid()) -- Mencegah self-escalation role
  );

CREATE POLICY "Admin dapat mengelola seluruh profil"
  ON public.profiles FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- =============================================================================
-- D. LAPORAN (laporan)
-- =============================================================================

-- Publik/anonim membaca laporan melalui VIEW `laporan_publik`.
-- Akses langsung tabel laporan dibatasi untuk:
-- 1) Pelapor membaca laporannya sendiri
-- 2) Petugas membaca laporan instansi/dinasnya
-- 3) Admin membaca seluruh laporan
CREATE POLICY "Pemilik atau petugas/admin dapat membaca tabel master laporan"
  ON public.laporan FOR SELECT
  TO authenticated
  USING (
    pelapor_id = auth.uid()
    OR (public.get_user_role() = 'petugas' AND dinas_id = public.get_user_dinas_id())
    OR public.is_admin()
  );

-- Warga atau Anonim dapat membuat laporan baru
CREATE POLICY "Siapapun dapat membuat laporan baru"
  ON public.laporan FOR INSERT
  WITH CHECK (
    (pelapor_id IS NULL AND is_anonim = true)
    OR (pelapor_id = auth.uid())
  );

-- Petugas dapat mengubah status laporan yang ditugaskan ke dinasnya
CREATE POLICY "Petugas memperbarui laporan dinasnya"
  ON public.laporan FOR UPDATE
  TO authenticated
  USING (
    (public.get_user_role() = 'petugas' AND dinas_id = public.get_user_dinas_id())
    OR public.is_admin()
  )
  WITH CHECK (
    (public.get_user_role() = 'petugas' AND dinas_id = public.get_user_dinas_id())
    OR public.is_admin()
  );

-- Warga dapat membuka ulang laporan miliknya jika sudah berstatus selesai
CREATE POLICY "Warga membuka ulang laporan selesai miliknya"
  ON public.laporan FOR UPDATE
  TO authenticated
  USING (
    pelapor_id = auth.uid() AND status = 'selesai'
  )
  WITH CHECK (
    pelapor_id = auth.uid() AND status = 'dibuka_ulang'
  );

-- =============================================================================
-- E. STATUS HISTORY (status_history)
-- =============================================================================

CREATE POLICY "Publik dapat membaca riwayat status laporan yang valid"
  ON public.status_history FOR SELECT
  USING (true);

CREATE POLICY "Petugas atau admin menambahkan riwayat status"
  ON public.status_history FOR INSERT
  TO authenticated
  WITH CHECK (
    public.is_petugas_atau_admin()
    OR (
      -- Pelapor warga diizinkan insert saat meminta dibuka_ulang
      diubah_oleh = auth.uid()
      AND status_ke = 'dibuka_ulang'
    )
  );

-- =============================================================================
-- F. KONTAK PELAPOR (kontak_pelapor) — ISOLASI KETAT PRIVASI
-- =============================================================================

CREATE POLICY "Hanya pemilik dan admin/petugas terkait yang dapat membaca kontak"
  ON public.kontak_pelapor FOR SELECT
  TO authenticated
  USING (
    user_id = auth.uid()
    OR public.is_admin()
    OR (
      public.get_user_role() = 'petugas'
      AND EXISTS (
        SELECT 1 FROM public.laporan l
        WHERE l.id = laporan_id AND l.dinas_id = public.get_user_dinas_id()
      )
    )
  );

CREATE POLICY "Pelapor dapat menyimpan kontak saat melapor"
  ON public.kontak_pelapor FOR INSERT
  WITH CHECK (
    (user_id IS NULL) -- Anonim tapi menitipkan email notif
    OR (user_id = auth.uid())
  );

-- =============================================================================
-- G. DUKUNGAN LAPORAN (dukungan_laporan)
-- =============================================================================

CREATE POLICY "Publik dapat membaca jumlah dukungan"
  ON public.dukungan_laporan FOR SELECT
  USING (true);

CREATE POLICY "Pengguna atau anonim dapat memberi dukungan"
  ON public.dukungan_laporan FOR INSERT
  WITH CHECK (
    (user_id = auth.uid())
    OR (user_id IS NULL AND ip_hash IS NOT NULL)
  );

-- =============================================================================
-- H. KONFIRMASI PELAPOR (konfirmasi_pelapor)
-- =============================================================================

CREATE POLICY "Publik dapat membaca hasil rekap konfirmasi"
  ON public.konfirmasi_pelapor FOR SELECT
  USING (true);

CREATE POLICY "Hanya pelapor yang berhak mengisi konfirmasi hasil laporan"
  ON public.konfirmasi_pelapor FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.laporan l
      WHERE l.id = laporan_id 
        AND (l.pelapor_id = auth.uid() OR l.is_anonim = true)
        AND l.status = 'selesai'
    )
  );

-- =============================================================================
-- I. NOTIFIKASI (notifikasi) & ANTREAN EMAIL
-- =============================================================================

CREATE POLICY "User dapat membaca notifikasi miliknya"
  ON public.notifikasi FOR SELECT
  USING (
    user_id = auth.uid()
    OR (user_id IS NULL AND kode_lacak IS NOT NULL)
  );

CREATE POLICY "User dapat menandai notifikasinya sudah dibaca"
  ON public.notifikasi FOR UPDATE
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Antrean email dikelola oleh proses sistem / service role"
  ON public.antrean_email FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- =============================================================================
-- J. AUDIT LOG (audit_log) — APPEND ONLY
-- =============================================================================

CREATE POLICY "Hanya Admin yang dapat membaca audit log"
  ON public.audit_log FOR SELECT
  TO authenticated
  USING (public.is_admin());

CREATE POLICY "Sistem atau Petugas/Admin dapat mencatat audit log"
  ON public.audit_log FOR INSERT
  TO authenticated
  WITH CHECK (true);




-- =============================================================================
-- 010_seed_referensi.sql
-- Seed Data Master: Dinas, Kategori, Kecamatan, dan 54 Kelurahan Kota Surakarta
-- Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
-- =============================================================================
-- File ini idempoten (menggunakan ON CONFLICT DO UPDATE / DO NOTHING).
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. SUMBER DATA REFERENSI
-- ---------------------------------------------------------------------------
INSERT INTO public.sumber_data (id, nama, url, tahun_data, tanggal_akses, lisensi, catatan_pengolahan, provenance)
VALUES 
  (
    'a1111111-1111-1111-1111-111111111111',
    'Dispendukcapil Kota Surakarta - Data Agregat Kependudukan',
    'https://dispendukcapil.surakarta.go.id',
    2023,
    '2026-11-10',
    'Data Terbuka Pemerintah Kota Surakarta',
    'Data agregat resmi jumlah penduduk Kota Surakarta Semester 2 Tahun 2023',
    'agregat_resmi'
  ),
  (
    'b2222222-2222-2222-2222-222222222222',
    'Portal Data Jawa Tengah - Rekap ULAS',
    'https://data.jatengprov.go.id',
    2023,
    '2026-11-10',
    'Open Data Pemerintah Provinsi Jawa Tengah',
    'Agregat volume dan distribusi aduan ULAS Surakarta per OPD',
    'agregat_resmi'
  ),
  (
    'c3333333-3333-3333-3333-333333333333',
    'Kemendagri / BPS - Kode dan Batas Administrasi Wilayah Surakarta',
    'https://surakartakota.bps.go.id',
    2023,
    '2026-11-10',
    'Publikasi Resmi BPS & Kemendagri',
    'Daftar 5 kecamatan dan 54 kelurahan definitif di Kota Surakarta',
    'asli'
  )
ON CONFLICT (id) DO UPDATE SET 
  nama = EXCLUDED.nama,
  url = EXCLUDED.url,
  catatan_pengolahan = EXCLUDED.catatan_pengolahan;

-- ---------------------------------------------------------------------------
-- 2. DINAS / ORGANISASI PERANGKAT DAERAH (OPD)
-- ---------------------------------------------------------------------------
INSERT INTO public.dinas (id, nama, singkatan, deskripsi, is_aktif)
VALUES
  (
    'd1111111-0000-0000-0000-000000000001',
    'Dinas Pekerjaan Umum dan Penataan Ruang',
    'DPUPR',
    'Menangani pemeliharaan jalan, jembatan, saluran drainase, serta fasilitas fisik kota',
    true
  ),
  (
    'd2222222-0000-0000-0000-000000000002',
    'Dinas Perhubungan',
    'Dishub',
    'Menangani penerangan jalan umum (PJU), marka jalan, rambu lalu lintas, dan halte',
    true
  ),
  (
    'd3333333-0000-0000-0000-000000000003',
    'Dinas Lingkungan Hidup',
    'DLH',
    'Menangani pengelolaan sampah liar, kebersihan ruang publik, dan pemangkasan pohon rawan',
    true
  ),
  (
    'd4444444-0000-0000-0000-000000000004',
    'Satuan Polisi Pamong Praja',
    'Satpol PP',
    'Menangani ketertiban umum, penertiban reklame liar, dan pemulihan fungsi trotoar dari okupasi pedagang',
    true
  )
ON CONFLICT (singkatan) DO UPDATE SET
  nama = EXCLUDED.nama,
  deskripsi = EXCLUDED.deskripsi,
  is_aktif = EXCLUDED.is_aktif;

-- ---------------------------------------------------------------------------
-- 3. KATEGORI ADUAN
-- ---------------------------------------------------------------------------
INSERT INTO public.kategori (id, nama, slug, ikon, dinas_id, sla_hari, is_aktif)
VALUES
  (
    'c1111111-0000-0000-0000-000000000001',
    'Penambalan Aspal',
    'penambalan-aspal',
    'hammer',
    'd1111111-0000-0000-0000-000000000001',
    7,
    true
  ),
  (
    'c2222222-0000-0000-0000-000000000002',
    'Lampu PJU',
    'lampu-pju',
    'lightbulb',
    'd2222222-0000-0000-0000-000000000002',
    5,
    true
  ),
  (
    'c3333333-0000-0000-0000-000000000003',
    'Drainase & Saluran Air',
    'drainase',
    'droplets',
    'd1111111-0000-0000-0000-000000000001',
    14,
    true
  ),
  (
    'c4444444-0000-0000-0000-000000000004',
    'Sampah & Lingkungan',
    'sampah-lingkungan',
    'trash-2',
    'd3333333-0000-0000-0000-000000000003',
    3,
    true
  ),
  (
    'c5555555-0000-0000-0000-000000000005',
    'Fasilitas Difabel',
    'fasilitas-difabel',
    'accessibility',
    'd1111111-0000-0000-0000-000000000001',
    14,
    true
  ),
  (
    'c6666666-0000-0000-0000-000000000006',
    'Rambu & Halte',
    'rambu-halte',
    'signpost',
    'd2222222-0000-0000-0000-000000000002',
    7,
    true
  )
ON CONFLICT (slug) DO UPDATE SET
  nama = EXCLUDED.nama,
  ikon = EXCLUDED.ikon,
  dinas_id = EXCLUDED.dinas_id,
  sla_hari = EXCLUDED.sla_hari;

-- ---------------------------------------------------------------------------
-- 4. KECAMATAN (5 Kecamatan Resmi Surakarta)
-- ---------------------------------------------------------------------------
INSERT INTO public.kecamatan (id, nama, kode_wilayah, jumlah_penduduk, provenance, sumber_data_id)
VALUES
  ('c1000000-0000-0000-0000-000000000001', 'Laweyan', '33.72.01', 104523, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('c2000000-0000-0000-0000-000000000002', 'Serengan', '33.72.02', 52310, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('c3000000-0000-0000-0000-000000000003', 'Pasar Kliwon', '33.72.03', 88470, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('c4000000-0000-0000-0000-000000000004', 'Jebres', '33.72.04', 151240, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('c5000000-0000-0000-0000-000000000005', 'Banjarsari', '33.72.05', 191103, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111')
ON CONFLICT (kode_wilayah) DO UPDATE SET
  nama = EXCLUDED.nama,
  jumlah_penduduk = EXCLUDED.jumlah_penduduk;

-- ---------------------------------------------------------------------------
-- 5. KELURAHAN (54 Kelurahan Lengkap di 5 Kecamatan)
-- ---------------------------------------------------------------------------

-- KECAMATAN LAWEYAN (11 Kelurahan)
INSERT INTO public.kelurahan (nama, kode_wilayah, kecamatan_id, jumlah_penduduk, provenance, sumber_data_id)
VALUES
  ('Penumping', '33.72.01.1001', 'c1000000-0000-0000-0000-000000000001', 5214, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Sriwedari', '33.72.01.1002', 'c1000000-0000-0000-0000-000000000001', 5480, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Purwosari', '33.72.01.1003', 'c1000000-0000-0000-0000-000000000001', 11320, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kerten', '33.72.01.1004', 'c1000000-0000-0000-0000-000000000001', 10185, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Jajar', '33.72.01.1005', 'c1000000-0000-0000-0000-000000000001', 12450, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Karangasem', '33.72.01.1006', 'c1000000-0000-0000-0000-000000000001', 11840, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Pajang', '33.72.01.1007', 'c1000000-0000-0000-0000-000000000001', 13920, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Sondakan', '33.72.01.1008', 'c1000000-0000-0000-0000-000000000001', 11750, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Laweyan', '33.72.01.1009', 'c1000000-0000-0000-0000-000000000001', 3240, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Bumi', '33.72.01.1010', 'c1000000-0000-0000-0000-000000000001', 7894, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Panularan', '33.72.01.1011', 'c1000000-0000-0000-0000-000000000001', 11230, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111')
ON CONFLICT (kode_wilayah) DO UPDATE SET
  nama = EXCLUDED.nama,
  jumlah_penduduk = EXCLUDED.jumlah_penduduk;

-- KECAMATAN SERENGAN (7 Kelurahan)
INSERT INTO public.kelurahan (nama, kode_wilayah, kecamatan_id, jumlah_penduduk, provenance, sumber_data_id)
VALUES
  ('Kemlayan', '33.72.02.1001', 'c2000000-0000-0000-0000-000000000002', 3940, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Jayengan', '33.72.02.1002', 'c2000000-0000-0000-0000-000000000002', 5120, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kratonan', '33.72.02.1003', 'c2000000-0000-0000-0000-000000000002', 5860, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Tipes', '33.72.02.1004', 'c2000000-0000-0000-0000-000000000002', 11450, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Serengan', '33.72.02.1005', 'c2000000-0000-0000-0000-000000000002', 9850, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Danukusuman', '33.72.02.1006', 'c2000000-0000-0000-0000-000000000002', 7480, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Joyotakan', '33.72.02.1007', 'c2000000-0000-0000-0000-000000000002', 8610, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111')
ON CONFLICT (kode_wilayah) DO UPDATE SET
  nama = EXCLUDED.nama,
  jumlah_penduduk = EXCLUDED.jumlah_penduduk;

-- KECAMATAN PASAR KLIWON (10 Kelurahan)
INSERT INTO public.kelurahan (nama, kode_wilayah, kecamatan_id, jumlah_penduduk, provenance, sumber_data_id)
VALUES
  ('Kauman', '33.72.03.1001', 'c3000000-0000-0000-0000-000000000003', 3820, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kampung Baru', '33.72.03.1002', 'c3000000-0000-0000-0000-000000000003', 4180, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kedung Lumbu', '33.72.03.1003', 'c3000000-0000-0000-0000-000000000003', 5920, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Baluwarti', '33.72.03.1004', 'c3000000-0000-0000-0000-000000000003', 7540, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Gajahan', '33.72.03.1005', 'c3000000-0000-0000-0000-000000000003', 5630, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Pasar Kliwon', '33.72.03.1006', 'c3000000-0000-0000-0000-000000000003', 6890, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Joyosuran', '33.72.03.1007', 'c3000000-0000-0000-0000-000000000003', 10450, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Semanggi', '33.72.03.1008', 'c3000000-0000-0000-0000-000000000003', 19820, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Mojo', '33.72.03.1009', 'c3000000-0000-0000-0000-000000000003', 13410, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Sangkrah', '33.72.03.1010', 'c3000000-0000-0000-0000-000000000003', 10810, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111')
ON CONFLICT (kode_wilayah) DO UPDATE SET
  nama = EXCLUDED.nama,
  jumlah_penduduk = EXCLUDED.jumlah_penduduk;

-- KECAMATAN JEBRES (11 Kelurahan)
INSERT INTO public.kelurahan (nama, kode_wilayah, kecamatan_id, jumlah_penduduk, provenance, sumber_data_id)
VALUES
  ('Sudiroprajan', '33.72.04.1001', 'c4000000-0000-0000-0000-000000000004', 4210, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Gandekan', '33.72.04.1002', 'c4000000-0000-0000-0000-000000000004', 9250, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Sewu', '33.72.04.1003', 'c4000000-0000-0000-0000-000000000004', 7890, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Jagalan', '33.72.04.1004', 'c4000000-0000-0000-0000-000000000004', 12100, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Pucangsawit', '33.72.04.1005', 'c4000000-0000-0000-0000-000000000004', 14250, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Jebres', '33.72.04.1006', 'c4000000-0000-0000-0000-000000000004', 36580, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Mojosongo', '33.72.04.1007', 'c4000000-0000-0000-0000-000000000004', 54220, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Tegalharjo', '33.72.04.1008', 'c4000000-0000-0000-0000-000000000004', 4520, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Purwodiningratan', '33.72.04.1009', 'c4000000-0000-0000-0000-000000000004', 4310, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kepatihan Kulon', '33.72.04.1010', 'c4000000-0000-0000-0000-000000000004', 2110, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kepatihan Wetan', '33.72.04.1011', 'c4000000-0000-0000-0000-000000000004', 1800, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111')
ON CONFLICT (kode_wilayah) DO UPDATE SET
  nama = EXCLUDED.nama,
  jumlah_penduduk = EXCLUDED.jumlah_penduduk;

-- KECAMATAN BANJARSARI (15 Kelurahan)
INSERT INTO public.kelurahan (nama, kode_wilayah, kecamatan_id, jumlah_penduduk, provenance, sumber_data_id)
VALUES
  ('Keprabon', '33.72.05.1001', 'c5000000-0000-0000-0000-000000000005', 3150, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Timuran', '33.72.05.1002', 'c5000000-0000-0000-0000-000000000005', 3240, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Ketelan', '33.72.05.1003', 'c5000000-0000-0000-0000-000000000005', 4380, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Punggawan', '33.72.05.1004', 'c5000000-0000-0000-0000-000000000005', 4620, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kestalan', '33.72.05.1005', 'c5000000-0000-0000-0000-000000000005', 3890, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Setabelan', '33.72.05.1006', 'c5000000-0000-0000-0000-000000000005', 4720, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Gilingan', '33.72.05.1007', 'c5000000-0000-0000-0000-000000000005', 18450, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Nusukan', '33.72.05.1008', 'c5000000-0000-0000-0000-000000000005', 35680, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Kadipiro', '33.72.05.1009', 'c5000000-0000-0000-0000-000000000005', 21340, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Banyuanyar', '33.72.05.1010', 'c5000000-0000-0000-0000-000000000005', 16820, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Sumber', '33.72.05.1011', 'c5000000-0000-0000-0000-000000000005', 20110, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Manahan', '33.72.05.1012', 'c5000000-0000-0000-0000-000000000005', 13140, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Mangkubumen', '33.72.05.1013', 'c5000000-0000-0000-0000-000000000005', 9870, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Joglo', '33.72.05.1014', 'c5000000-0000-0000-0000-000000000005', 12390, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111'),
  ('Banjarsari', '33.72.05.1015', 'c5000000-0000-0000-0000-000000000005', 12793, 'agregat_resmi', 'a1111111-1111-1111-1111-111111111111')
ON CONFLICT (kode_wilayah) DO UPDATE SET
  nama = EXCLUDED.nama,
  jumlah_penduduk = EXCLUDED.jumlah_penduduk;




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



-- =============================================================================
-- 014_storage_buckets.sql
-- Migrasi: Konfigurasi Supabase Storage Bucket & Storage RLS Policies
-- Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
-- =============================================================================
-- File ini idempoten: aman dijalankan berulang kali.
-- Mengonfigurasi bucket 'laporan-foto' untuk foto kondisi sebelum dan sesudah.
-- =============================================================================

-- 1. Buat bucket 'laporan-foto' jika belum ada
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'laporan-foto',
  'laporan-foto',
  true, -- Publik dapat membaca URL citra
  5242880, -- Batas maksimal 5 MB per berkas foto
  ARRAY['image/jpeg', 'image/png', 'image/webp']
)
ON CONFLICT (id) DO UPDATE SET
  public = EXCLUDED.public,
  file_size_limit = EXCLUDED.file_size_limit,
  allowed_mime_types = EXCLUDED.allowed_mime_types;

-- 2. Hapus kebijakan lama jika ada (idempoten)
DROP POLICY IF EXISTS "Publik dapat melihat foto laporan" ON storage.objects;
DROP POLICY IF EXISTS "Warga dapat mengunggah foto sebelum" ON storage.objects;
DROP POLICY IF EXISTS "Petugas dapat mengunggah foto sesudah" ON storage.objects;
DROP POLICY IF EXISTS "Hanya admin dapat menghapus foto" ON storage.objects;

-- 3. Kebijakan Hak Akses Storage (RLS pada storage.objects)

-- Kebijakan A: Siapa saja (publik/anonim/terautentikasi) dapat melihat dan mengunduh foto laporan
CREATE POLICY "Publik dapat melihat foto laporan"
ON storage.objects FOR SELECT
USING (bucket_id = 'laporan-foto');

-- Kebijakan B: Warga (anonim atau login) dapat mengunggah foto ke direktori 'sebelum/'
CREATE POLICY "Warga dapat mengunggah foto sebelum"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'laporan-foto'
  AND (storage.foldername(name))[1] = 'sebelum'
);

-- Kebijakan C: Hanya petugas dinas atau admin yang berhak mengunggah foto bukti ke 'sesudah/'
CREATE POLICY "Petugas dapat mengunggah foto sesudah"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'laporan-foto'
  AND (storage.foldername(name))[1] = 'sesudah'
  AND auth.role() = 'authenticated'
  AND EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid()
    AND role IN ('petugas', 'admin')
  )
);

-- Kebijakan D: Penghapusan foto hanya diizinkan untuk administrator
CREATE POLICY "Hanya admin dapat menghapus foto"
ON storage.objects FOR DELETE
USING (
  bucket_id = 'laporan-foto'
  AND auth.role() = 'authenticated'
  AND EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid()
    AND role = 'admin'
  )
);




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
