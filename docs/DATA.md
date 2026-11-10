# Metodologi & Sumber Data RAMPUNG (Kota Surakarta)

Dokumen ini menjelaskan strategi integrasi data resmi Kota Surakarta, kalibrasi simulasi, skema provenance, dan petunjuk pengelolaan data untuk platform **RAMPUNG**.

---

## 1. Prinsip & Kebijakan Data

1. **Keaslian & Legalitas**: Data publik resmi Kota Surakarta digunakan secara prioritas. Tidak ada scraping massal ke situs pemerintah (seperti ULAS). Hanya file resmi berlisensi terbuka atau portal Satu Data yang digunakan.
2. **Provenance Transparan**: Setiap baris dan metrik analitik wajib memiliki label provenance:
   - `'asli'`: Data primer resmi definitif (mis. batas wilayah dan kode Kemendagri).
   - `'agregat_resmi'`: Data rekapitulasi statistik resmi dari instansi pemerintah (Dispendukcapil / Satu Data Jateng / BPS).
   - `'simulasi_terkalibrasi'`: Data mikro laporan individual yang dihasilkan dari model statistik berbasis rekap resmi ULAS 2023.
   - `'simulasi'`: Data sintetis murni untuk keperluan pengujian teknis.
3. **Pemisahan Angka**: Angka simulasi tidak pernah digabungkan secara terselubung ke dalam angka resmi dalam visualisasi dashboard.
4. **Privasi & Zero PII**: Tidak ada data identitas warga asli, foto berwajah orang, atau nomor telepon pribadi yang disimpan dalam dataset publik.

---

## 2. Inventaris Sumber Data Resmi

| Nama Dataset | Penerbit | Tahun | Format | Lisensi | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Data Agregat Kependudukan** | Dispendukcapil Kota Surakarta | Smt 2 2023 | Agregat Resmi (PDF/XLS) | Hak Cipta Pemkot Surakarta / Publik | Terverifikasi (587.646 jiwa, 54 kelurahan) |
| **Rekapitulasi Aduan ULAS** | Dinas Kominfo & Statistik Pemprov Jateng | 2023 | Agregat XLSX | Open Data Jateng | Terverifikasi (Distribusi OPD: DPUPR 52%, Dishub 30%, DLH 18%) |
| **Batas Administrasi Kelurahan** | OCHA / HDX / OpenStreetMap | 2023 | GeoJSON / SHP | ODbL / Open Humanitarian | Terpetakan 54 Kelurahan |
| **Indikator Kesejahteraan Rakyat** | BPS Kota Surakarta | 2023-2024 | Publikasi Statistik | Publik BPS | Rujukan Metrik |

---

## 3. Metode Kalibrasi Data Simulasi (Tier C)

Karena data pelaporan individual (koordinat presisi titik lubang jalan, foto kondisi lapangan, linimasa menit penanganan) bersifat sensitif dan tidak dipublikasikan mentah oleh pemerintah, RAMPUNG menggunakan **Simulasi Terkalibrasi**:
- **Distribusi Kategori**: Proporsi kategori laporan disesuaikan dengan persentase rekap resmi aduan masyarakat di Portal Data Jawa Tengah:
  - 50-52% Pekerjaan Umum (Aspal jalan, genangan drainase)
  - 28-30% Perhubungan (Lampu PJU mati, rambu lalu lintas)
  - 18-20% Lingkungan Hidup (Tumpukan sampah, kebersihan saluran)
- **Distribusi Geografis**: Kepadatan laporan per kelurahan dibuat proporsional dengan jumlah penduduk resmi kelurahan (mis. Jebres dan Banjarsari memiliki volume aduan lebih tinggi dibanding Serengan).
- **Generator Deterministik**: Dihasilkan melalui algoritma pseudo-random ter-seed (`seed: 2026`) sehingga hasil pengujian selalu konsisten dan dapat direproduksi ulang (*reproducible*).

---

## 4. Panduan Menjalankan ETL

```bash
# 1. Jalankan generator seed laporan simulasi terkalibrasi
npm run etl:seed-simulasi

# 2. Update data agregat kependudukan
npm run etl:penduduk

# 3. Impor rekap benchmark ULAS
npm run etl:ulas

# 4. Validasi integritas & zero PII
npm run etl:validasi
```

---

## 5. Paragraf Siap-Tempel untuk Halaman "Tentang & Sumber Data"

> *"Data kependudukan dan batas wilayah pada platform RAMPUNG bersumber dari Data Agregat Kependudukan Semester II Tahun 2023 Dinas Kependudukan dan Pencatatan Sipil Kota Surakarta, Badan Pusat Statistik (BPS) Kota Surakarta, serta batas administratif OpenStreetMap. Indikator dan distribusi topik aduan dikalibrasi menggunakan data agregat resmi Unit Layanan Aduan Surakarta (ULAS) yang dipublikasikan pada Portal Data Terbuka Provinsi Jawa Tengah. Untuk melindungi privasi warga dan menyimulasikan pengalaman penanganan waktu-nyata, titik koordinat laporan individual pada versi demonstrasi ini menggunakan data simulasi terkalibrasi berlabel khusus yang tidak mengubah integritas data resmi pemerintah."*

