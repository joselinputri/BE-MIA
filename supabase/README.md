# Panduan Migrasi Database Supabase — RAMPUNG

Seluruh berkas SQL di folder `supabase/migrations/` disusun secara terurut dan bersifat **idempoten** (aman dijalankan berulang kali).

---

## Urutan Eksekusi Migrasi

1. `001_extensions.sql` — Mengaktifkan ekstensi `postgis`, `pgcrypto`, `uuid-ossp`, dan `pg_trgm`.
2. `002_enums_types.sql` — Membuat tipe data kustom (`role_type`, `status_laporan`, `provenance_type`, dll).
3. `003_tabel_referensi.sql` — Tabel `sumber_data`, `dinas`, `kategori`, `kecamatan`, dan `kelurahan`.
4. `004_tabel_laporan.sql` — Tabel `laporan`, `status_history`, `dukungan_laporan`, dan `konfirmasi_pelapor`.
5. `005_tabel_pengguna.sql` — Tabel `profiles`, `kontak_pelapor`, dan fungsi helper hak akses RLS.
6. `006_tabel_notifikasi.sql` — Tabel `notifikasi` in-app dan `antrean_email`.
7. `007_tabel_audit_data.sql` — Tabel `audit_log`, `data_penduduk_resmi`, dan `rekap_ulas`.
8. `008_views_functions.sql` — View publik `laporan_publik` (bebas PII) dan fungsi RPC dashboard.
9. `009_rls_policies.sql` — Row Level Security aktif pada **100% tabel** dengan kebijakan *default deny*.
10. `010_seed_referensi.sql` — Data awal resmi: 4 dinas (DPUPR, Dishub, DLH, Satpol PP), 6 kategori aduan, 5 kecamatan, dan 54 kelurahan lengkap.
11. `011_indexes.sql` — Indeks spasial GIST, B-tree komposit (status, waktu), dan GIN full-text search.
12. `013_update_data_penduduk.sql` — Sinkronisasi jumlah penduduk Dispendukcapil Surakarta (Semester 2 2023).
13. `014_storage_buckets.sql` — Konfigurasi Supabase Storage bucket 'laporan-foto' dan kebijakan RLS storage.
14. `015_insert_rekap_ulas.sql` — Rekapitulasi agregat resmi aduan ULAS 2023 dari Portal Data Jateng.
15. `016_seed_laporan_simulasi.sql` — 200 data laporan simulasi terkalibrasi (`is_simulasi = true`). **PERINGATAN: HANYA untuk staging/demo lomba, JANGAN jalankan di produksi!**

---

## Cara Menjalankan

### Opsi A: Lewat Supabase SQL Editor Web
Buka project Supabase Anda -> menu **SQL Editor** -> jalankan file 001 s/d 016 secara berurutan.

### Opsi B: Lewat psql / Terminal
```bash
psql "postgresql://postgres:[PASSWORD]@[HOST]:[PORT]/postgres" -f supabase/migrations/001_extensions.sql
# ... ulangi sampai 016
```

### Opsi C: Menjalankan Pengujian Hak Akses RLS
```bash
psql "postgresql://postgres:[PASSWORD]@[HOST]:[PORT]/postgres" -f supabase/tests/01_test_rls_security.sql
```

