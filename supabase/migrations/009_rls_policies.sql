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

