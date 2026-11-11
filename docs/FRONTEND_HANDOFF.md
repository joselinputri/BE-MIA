# Panduan Integrasi dan Handoff — RAMPUNG

Halo Syifa (Frontend Engineer)! Dokumen ini adalah panduan lengkap kontrak API, skema data, dan integrasi backend untuk membangun antarmuka web platform **RAMPUNG** tanpa perlu menebak-nebak.

---

## 1. Environment Variables untuk Frontend

Buat berkas `.env.local` di root proyek. **Hanya gunakan variabel berawalan `NEXT_PUBLIC_` di komponen FE**:

```env
NEXT_PUBLIC_APP_URL=http://localhost:3000
NEXT_PUBLIC_USE_MOCK=false

# Supabase Client SDK (Aman di Client-Side)
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here

# Supabase server API (jangan pernah diekspos ke browser)
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-here

# Cloudflare Turnstile (Opsional, untuk form anonim)
NEXT_PUBLIC_TURNSTILE_SITE_KEY=your-site-key
```

> [!CAUTION]
> **JANGAN PERNAH** memanggil atau mengimpor `SUPABASE_SERVICE_ROLE_KEY` di file antarmuka (komponen `'use client'`). Kunci tersebut khusus sisi server.

Untuk kerja antarmuka tanpa project Supabase, gunakan `NEXT_PUBLIC_USE_MOCK=true`. Aplikasi memakai data JSON lokal dan menyimpan laporan baru di browser; tidak ada banner mode khusus. Untuk memakai database, lengkapi semua kunci Supabase, ubah flag menjadi `false`, lalu restart server. Jangan kirim service role key lewat chat atau commit ke Git.

---

## 2. Format Standar Respons API

Semua endpoint backend RAMPUNG mengembalikan format respons seragam:

### Respons Sukses:
```json
{
  "data": { ... },
  "meta": {
    "cursor_berikutnya": "2026-10-15T08:30:00.000Z",
    "sumber": [
      {
        "provenance": "asli",
        "nama_sumber": "Data Terbuka Pemkot Surakarta",
        "waktu_pembaruan": "2026-11-10T12:00:00Z"
      }
    ],
    "waktu_query": "2026-11-10T15:00:00Z"
  }
}
```

### Respons Error:
```json
{
  "error": {
    "kode": "VALIDATION_ERROR",
    "pesan": "Judul laporan minimal 5 karakter",
    "detail": { ... }
  }
}
```

---

## 3. Peta Kode Error ke Pesan Tampilan Antarmuka (UI)

Gunakan mapping berikut untuk menampilkan toast/alert di sisi pengguna:

| Kode Error | HTTP Status | Rekomendasi Pesan UI (Toast / Banner) |
| :--- | :--- | :--- |
| `VALIDATION_ERROR` | 422 | Tampilkan pesan spesifik dari `error.pesan` di bawah input form terkait. |
| `UNAUTHORIZED` | 401 | *"Sesi Anda telah berakhir. Silakan masuk kembali."* |
| `FORBIDDEN` | 403 | *"Anda tidak memiliki hak akses untuk melakukan tindakan ini."* |
| `NOT_FOUND` | 404 | *"Data atau laporan yang dicari tidak ditemukan."* |
| `RATE_LIMITED` | 429 | *"Terlalu banyak permintaan. Mohon tunggu beberapa saat sebelum mencoba kembali."* |
| `INVALID_STATUS_TRANSITION` | 400 | Tampilkan pesan dari `error.pesan` (mis. penolakan wajib sertakan alasan). |
| `CONFLICT` | 409 | *"Anda sudah pernah memberikan dukungan pada laporan ini."* |
| `SERVICE_UNAVAILABLE` | 503 | *"Layanan database belum dikonfigurasi. Coba lagi setelah koneksi Supabase tersedia."* |
| `INTERNAL_ERROR` | 500 | *"Terjadi gangguan koneksi pada server. Silakan coba sesaat lagi."* |

---

## 4. Provenance Data

Kolom `provenance` (`'asli'` \| `'agregat_resmi'` \| `'simulasi_terkalibrasi'` \| `'simulasi'`) adalah metadata internal. Jangan menyatakan data berasal dari database atau sumber resmi jika belum terhubung. Jangan beri label "Resmi" pada laporan warga; status laporan tidak berarti data telah diverifikasi oleh pemerintah.

| Nilai Provenance | Makna Internal |
| :--- | :--- |
| `asli` | Laporan yang tersimpan di database; bukan pengesahan pemerintah |
| `agregat_resmi` | Agregat dari sumber resmi yang dicantumkan |
| `simulasi_terkalibrasi`, `simulasi` | Data pengembangan/pengujian; jangan kirim sebagai data live |

---

## 5. Cara Berlangganan Pembaruan Real-Time (Supabase Realtime)

Gunakan helper Supabase bawaan pada halaman *Lacak Laporan* untuk memperbarui linimasa status tiket secara otomatis:

```typescript
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);

// Dengarkan perubahan status laporan spesifik
export function subscribeStatusLaporan(laporanId: string, onUpdate: (data: any) => void) {
  const channel = supabase
    .channel(`laporan-${laporanId}`)
    .on(
      'postgres_changes',
      {
        event: 'UPDATE',
        schema: 'public',
        table: 'laporan',
        filter: `id=eq.${laporanId}`,
      },
      (payload) => {
        onUpdate(payload.new);
      }
    )
    .subscribe();

  return () => {
    supabase.removeChannel(channel);
  };
}
```

---

## 6. Daftar Endpoint Utama

| Method | Path | Auth | Keterangan |
| :--- | :--- | :--- | :--- |
| `POST` | `/api/laporan` | Publik | Buat laporan aduan baru |
| `POST` | `/api/laporan/upload-foto` | Publik, rate-limited | Membuat signed upload URL; respons memuat `upload_url`, `file_path`, dan `token` |
| `GET` | `/api/laporan/publik` | Publik | Daftar laporan publik (cursor pagination: `?limit=20&cursor=...`) |
| `GET` | `/api/laporan/lacak/:kode` | Publik | Lacak status tiket via kode lacak (kode `RMP-2025-088` tersedia pada data offline) |
| `GET` | `/api/laporan/serupa` | Publik | Cek laporan terdekat: `?kategori_id=...&latitude=...&longitude=...` |
| `POST` | `/api/laporan/:id/dukungan` | Publik | Upvote laporan serupa |
| `POST` | `/api/laporan/:id/konfirmasi` | Publik / Warga | Audit gotong-royong pelapor (puas, biasa, kurang_puas) |
| `GET` | `/api/petugas/antrean` | Petugas / Admin | Antrean verifikasi tugas per dinas |
| `PATCH` | `/api/petugas/laporan/:id/status`| Petugas / Admin | Pembaruan status (state machine) + upload foto sesudah |
| `GET` | `/api/dashboard/ringkasan` | Publik | KPI kartu angka beranda (Papan Tanggap) |
| `GET` | `/api/dashboard/tren` | Publik | Grafik tren masuk vs selesai bulanan |
| `GET` | `/api/dashboard/waktu-penanganan`| Publik | Median durasi penanganan per dinas & kategori |
| `GET` | `/api/dashboard/per-kapita` | Publik | Rasio laporan per 10.000 penduduk per kelurahan |
| `GET` | `/api/dashboard/konfirmasi` | Publik | Persentase kepuasan audit pelapor |
| `GET` | `/api/peta/laporan` | Publik | GeoJSON sebaran laporan untuk Leaflet |
| `GET` | `/api/referensi/kategori` | Publik | Master kategori, ikon, dan target SLA hari |
| `GET` | `/api/referensi/wilayah` | Publik | Master 5 kecamatan dan 54 kelurahan |
| `GET` | `/api/referensi/sumber-data` | Publik | Metadata "Dari Mana Data Ini?" |

---

## 7. Status Integrasi yang Perlu Diketahui

- Halaman masuk/daftar memakai Supabase Auth dan mengirim access token ke API. Pendaftaran publik selalu membuat role `warga`; role admin/petugas harus diberikan oleh administrator.
- Form laporan menggunakan `/api/laporan/upload-foto`, mengunggah berkas dengan signed token Supabase Storage, lalu mengirim storage path ke API laporan. Alur ini perlu diuji di project Supabase tim.
- Kode lacak laporan baru memakai format `RMP-YY-XXXX` agar panjangnya 11 karakter dan sesuai batas `VARCHAR(12)` database. Kode fixture lama seperti `RMP-2025-088` tetap diterima untuk data offline/legacy.
- Backend terbaru mengatur bucket `laporan-foto` publik lewat migrasi `014_storage_buckets.sql` dan mengubah storage path menjadi URL gambar. FE telah menyamakan batas unggah menjadi 5 MB.
- Data offline tetap tersedia untuk styling dan alur UI. Kiriman offline tidak masuk ke database dan hanya terlihat di browser yang membuatnya; aplikasi tidak menampilkan banner mode.
- Untuk live, jalankan hanya migrasi yang sudah dikonfirmasi backend; `016_seed_laporan_simulasi.sql` jangan diterapkan pada project produksi.

---

## 8. Checklist yang Perlu FE Lakukan

- [x] Form login/daftar memakai Supabase Auth; pendaftaran publik mendapat role `warga`.
- [x] Dashboard dan peta mempunyai filter serta state memuat/error/kosong.
- [ ] Verifikasi form laporan, validasi koordinat, serta transisi dan marker status bersama kontrak API terbaru.
- [x] Hubungkan pemilih foto dengan signed upload URL dan kirim storage path pada pembuatan laporan.
- [ ] Sediakan signed read URL atau mekanisme terproteksi untuk menampilkan foto dari bucket privat.
- [ ] Jangan menampilkan data offline seolah-olah data live; UI tidak perlu menampilkan badge mode, tetapi tim harus mengetahui sumber data saat pengujian.

---

## 9. Catatan Handoff untuk Backend

- Cocokkan kontrak endpoint dan bentuk respons/error di atas dengan implementasi API yang benar-benar dideploy. Pastikan kategori memakai UUID, bukan nama/slug, dan koordinat divalidasi terhadap wilayah Surakarta.
- **Perbaikan ID kategori sudah tersedia di ZIP BE terbaru (11 Nov 2026):** `BuatLaporanInputSchema`, `LaporanSerupaQuerySchema`, dan ID laporan memakai validasi format UUID PostgreSQL 8-4-4-4-12, sehingga ID seed tanpa bit versi/varian RFC diterima. FE telah disamakan. ZIP terbaru juga mengganti enam ID kategori seed menjadi `c...`; migrasi `010_seed_referensi.sql` lokal sudah disamakan. Pada database yang sudah pernah menjalankan seed lama, `ON CONFLICT (slug)` tidak mengganti nilai primary key `id`; jangan menjalankan query rekey manual tanpa migrasi relasi yang ditinjau. API FE mengambil ID kategori dari referensi aktif, bukan mengasumsikan ID seed tertentu.
- ZIP BE terbaru mengubah format kode laporan baru menjadi `RMP-YY-XXXX`, konsisten dengan kolom `kode_lacak VARCHAR(12)`. FE live dan generator data lokal sudah disamakan; kode fixture lama tetap didukung.
- Pastikan semua endpoint privat memverifikasi access token Supabase dan role di server. Registrasi publik hanya boleh membuat `warga`; pemberian role `petugas`/`admin` harus lewat jalur administrator yang terproteksi.
- Tinjau kebijakan bucket/RLS `laporan-foto` dan uji signed upload endpoint. Frontend telah meminta signed URL, mengunggah file yang didukung, dan menyimpan storage path pada laporan.
- Tambahkan/konfirmasi mekanisme signed read URL untuk menampilkan foto dari bucket privat; jangan menganggap storage path sebagai URL publik.
- Diagnostik lokal: publishable key dapat membaca view `laporan_publik`, tetapi query dengan server secret ditolak Supabase sebagai `Invalid API key`. Endpoint GET publik, referensi, peta, dan dashboard kini memakai publishable key dengan hak minimum; data laporan publik hanya mengambil laporan `sumber=asli`/non-simulasi. Operasi tulis, upload, serta operasi admin/server yang memerlukan hak istimewa tetap membutuhkan server secret yang valid dari project yang sama.
- Data offline masih dapat ditampilkan jika `NEXT_PUBLIC_USE_MOCK=true`; laporan offline hanya tersimpan di browser dan tidak masuk database. Untuk pengujian API live, nonaktifkan mock dan pastikan error konfigurasi tidak disamarkan menjadi data kosong.
- File migrasi `014_storage_buckets.sql` telah disinkronkan; ZIP terbaru juga menyediakan `017_fix_fn_dashboard_waktu_penanganan.sql` dan sudah disalin ke repo. Nomor `012` masih tidak tersedia; konfirmasi ke BE apakah memang tidak diperlukan. Jangan jalankan `016_seed_laporan_simulasi.sql` pada project produksi.
- `laporan_rows.csv` berisi 200 baris dan seluruhnya `is_simulasi=true` dengan provenance simulasi. Jangan impor sebagai laporan live atau tampilkan pada halaman publik.
- ZIP BE terbaru menyediakan migrasi 017 yang meng-cast hasil median/rata-rata `fn_dashboard_waktu_penanganan` sesuai `RETURNS TABLE` untuk memperbaiki SQLSTATE `42804`. File migrasi sudah tersedia di repo, tetapi belum diterapkan atau diverifikasi pada project Supabase; terapkan di staging lalu ulangi GET `/api/dashboard/waktu-penanganan` sebelum deploy. Daftar laporan publik, peta, dan laporan serupa sebelumnya kosong karena database tidak memiliki laporan nyata; CSV yang diperiksa seluruhnya data simulasi.
- Server secret yang tersedia di environment ditolak Supabase sebagai `Invalid API key`. Ganti dengan secret aktif dari project yang sama sebelum menguji pembuatan laporan, upload, autentikasi/operasi server, dan admin. Endpoint terlindungi menolak permintaan tanpa sesi (profil/antrean/laporan pribadi 401, admin 403).

## 10. Checklist Handoff untuk Deploy

- Isi environment variable di secret manager hosting, bukan di repository. Untuk production set `NEXT_PUBLIC_USE_MOCK=false`, `NEXT_PUBLIC_APP_URL` ke domain HTTPS final, `NEXT_PUBLIC_SUPABASE_URL`, dan `NEXT_PUBLIC_SUPABASE_ANON_KEY`.
- Tambahkan `SUPABASE_SERVICE_ROLE_KEY` hanya sebagai secret server-side. Jangan memberi awalan `NEXT_PUBLIC_`, jangan masukkan ke bundle browser, dan jangan kirim melalui chat/log.
- Atur Site URL serta allowed redirect URLs di Supabase Auth ke domain deployment yang benar. Terapkan migrasi database yang sudah dikonfirmasi backend; jangan seed data simulasi ke database live.
- Jika memakai Turnstile, konfigurasi site key dan secret key pada environment yang sesuai. Gemini, Redis, serta email bersifat opsional; uji fallback ketika tidak dikonfigurasi.
- Sebelum rilis, jalankan build, uji daftar/masuk/profil dengan akun warga dan admin terpisah, kirim laporan, cek hak akses endpoint, peta, serta upload foto di staging. Pastikan environment production tidak menggunakan data mock dan seluruh akses memakai HTTPS.
