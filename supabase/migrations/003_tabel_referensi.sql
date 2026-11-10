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
