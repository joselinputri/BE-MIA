# Dokumentasi Keamanan & Kebijakan Privasi — RAMPUNG

Dokumen ini menguraikan arsitektur keamanan, mitigasi kerentanan, pemetaan ancaman (*threat modeling*), dan checklist implementasi pada platform **RAMPUNG** (Kota Surakarta).

---

## 1. Matriks Mitigasi Ancaman (OWASP Top 10 & STRIDE)

| Ancaman (Threat) | Kategori STRIDE | Titik Rentan | Strategi Mitigasi di RAMPUNG | Status |
| :--- | :--- | :--- | :--- | :--- |
| **Bypass Otorisasi / IDOR** | *Elevation of Privilege* | API Status & Antrean Petugas | Validasi ganda di Route Handler server dan Row Level Security (RLS) PostgreSQL. Petugas hanya berwenang pada laporan dinasnya. | ✅ Diterapkan |
| **Kebocoran Kunci Rahasia** | *Information Disclosure* | Kunci Service Role Supabase | Kunci `SUPABASE_SERVICE_ROLE_KEY` hanya diakses pada `src/lib/server/supabase-admin.ts` dan dilindungi exception jika dieksekusi di browser. | ✅ Diterapkan |
| **SQL Injection** | *Tampering* | Pencarian & Filter Dashboard | Seluruh kueri menggunakan PostgreSQL parameterized queries dan Stored Procedures (RPC). Tidak ada konkatenasi string SQL mentah. | ✅ Diterapkan |
| **Cross-Site Scripting (XSS)** | *Tampering* | Judul & Deskripsi Aduan Warga | Semua input difilter melalui Zod schema (`.trim()`, panjang teks dibatasi). Output teks di-escape otomatis oleh React & Next.js. | ✅ Diterapkan |
| **Brute Force Enumerasi Kode Lacak** | *Information Disclosure* | Endpoint `/api/laporan/lacak/:kode` | Kode lacak menggunakan random bytes kriptografis (entropi tinggi `RPG-XXXXXXXX`). Rate limit ketat 30 req/menit per IP. Respons "NOT_FOUND" dibuat seragam. | ✅ Diterapkan |
| **Pelacakan Lokasi Rumah Warga (Doxing / Privasi)** | *Information Disclosure* | Peta Publik & View Laporan | Koordinat presisi dibulatkan ke grid ~100 meter (`ST_SnapToGrid`) pada `laporan_publik`. Titik asli hanya dapat diakses oleh petugas dinas terkait. | ✅ Diterapkan |
| **Spam / Bot Otomatis** | *Denial of Service* | Form Pelaporan Anonim | Kombinasi token Cloudflare Turnstile, input perangkap bot (*honeypot*), dan sliding window rate limiter (5 laporan/jam/IP). | ✅ Diterapkan |
| **ReDoS (Regular Expression DoS)** | *Denial of Service* | Filter Kata Kunci Spam | Evaluasi kata kunci menggunakan linear search `String.prototype.includes` O(N), tanpa regex bersarang (*nested quantifier*). | ✅ Diterapkan |
| **File Upload Malicious (Web Shell / EXIF Leak)** | *Tampering / Info Disclosure* | Upload Foto Bukti | Validasi berkas berbasis *Magic Bytes* (JPEG, PNG, WebP), nama berkas diacak kriptografis, dan metadata EXIF (termasuk tag koordinat GPS kamera) dihapus sebelum disimpan. | ✅ Diterapkan |
| **Clickjacking / MIME Sniffing** | *Spoofing* | Header HTTP Response | Konfigurasi `next.config.js` menyertakan `Content-Security-Policy`, `X-Frame-Options: DENY`, `X-Content-Type-Options: nosniff`, dan `HSTS`. | ✅ Diterapkan |

---

## 2. Checklist Keamanan Teknis

### A. Autentikasi & Hak Akses
- [x] RLS aktif pada **100% tabel** (`ALTER TABLE ... ENABLE ROW LEVEL SECURITY`) dengan kebijakan *default deny*.
- [x] Publik dan anonim hanya dapat mengakses view `laporan_publik` (bebas PII: tanpa `pelapor_id`, email, nomor telepon).
- [x] Pendaftaran publik melalui Supabase Auth otomatis menetapkan role `'warga'`. Peran `'petugas'` dan `'admin'` hanya dapat diatur oleh Administrator melalui konsol basis data.
- [x] Petugas instansi (DPUPR, Dishub, DLH) dibatasi hanya dapat memperbarui laporan dengan `dinas_id` yang sesuai.

### B. Validasi Masukan & Proteksi Data
- [x] Seluruh payload masukan divalidasi ketat di sisi server menggunakan skema Zod.
- [x] Titik koordinat wajib berada dalam *bounding box* wilayah hukum Kota Surakarta (Lon: 110.77-110.87, Lat: -7.60 s/d -7.52).
- [x] Lapisan validasi otomatis bersifat *rule-based* (hanya menandai `'perlu_verifikasi_tambahan'`), **tidak pernah menghapus laporan secara otomatis**.

### C. Privasi Pelapor (Zero PII Exposure)
- [x] Kontak pelapor disimpan pada tabel terpisah `kontak_pelapor` dengan kebijakan RLS tersendiri.
- [x] Pelapor anonim menerima kode lacak acak kriptografis tanpa perlu memasukkan email atau nomor telepon.
- [x] Data simulasi terkalibrasi tidak menggunakan nama orang riil, kontak riil, maupun foto berwajah orang.

---

## 3. Hal yang Belum Tercakup & Rencana Pengembangan Masa Depan

1. **Penyimpanan Rate Limit Multi-Region**: Saat ini rate limit menggunakan memory bucket in-process. Untuk deployment multi-instance serverless yang terdistribusi penuh di masa depan, disarankan menghubungkan `UPSTASH_REDIS_REST_URL`.
2. **Koneksi SMTP Email**: Antrean email (`antrean_email`) telah siap secara skema basis data, namun pengiriman email aktual membutuhkan konfigurasi API Key penyedia (seperti Resend / Brevo).
3. **Penyensoran Wajah Otomatis (Face Blurring)**: Saat ini foto bebas dari EXIF. Penambahan modul computer vision untuk mengaburkan plat nomor kendaraan atau wajah orang secara otomatis dapat diintegrasikan pada tahap berikutnya.

