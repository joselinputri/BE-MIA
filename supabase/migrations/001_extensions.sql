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
