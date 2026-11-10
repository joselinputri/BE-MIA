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
