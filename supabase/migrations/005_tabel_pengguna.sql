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
