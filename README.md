# Sistem Retensi & Alih Media Rekam Medis (RSU Kaliwates)

Sistem informasi manajemen rekam medis terpadu untuk digitalisasi berkas, ekstraksi OCR berbasis kecerdasan buatan, penentuan status retensi berkas, serta tata kelola pemusnahan arsip rekam medis secara elektronik sesuai regulasi rumah sakit.

---

## 🚀 Fitur Utama

- **Digitalisasi & Alih Media (OCR)**: Ekstraksi otomatis data resume/dokumen rekam medis (PDF & Gambar) menggunakan Multi-Engine AI (Google Gemini Direct, LiteLLM Proxy, dan YuuLabs Vision).
- **Validasi Data Medis**: Verifikasi data pasien, nomor rekam medis, riwayat kunjungan, dan kategori kasus medis sebelum data tersimpan ke basis data utama.
- **Perhitungan Retensi Otomatis**: Klasifikasi berkas aktif dan inaktif serta masa simpan berdasarkan jenis kasus (Umum, Jiwa, Kusta, Ketergantungan Obat, Anak, dll) sesuai masa retensi RJ & RI.
- **Pengajuan SK & Pemusnahan Arsip**: Alur pengajuan pemusnahan berkas inaktif, verifikasi kepala rekam medis, persetujuan direktur, dan pencetakan otomatis Berita Acara Pemusnahan (PDF).
- **Chat AI Assistant**: Asisten virtual terintegrasi untuk konsultasi dan tanya-jawab seputar regulasi rekam medis.
- **Log Aktivitas & Audit Trail**: Pencatatan riwayat setiap aksi pengguna untuk akuntabilitas sistem.

---

## 🛠️ Tech Stack

- **Backend**: Laravel 12 (PHP 8.2+) dengan arsitektur Service Layer & Eloquent ORM.
- **Frontend**: Vue 3 (Composition API) + Vite + Tailwind CSS + Element Plus.
- **Database**: MySQL / MariaDB (Port default `3306`).
- **Pelaporan**: DomPDF (`barryvdh/laravel-dompdf`) untuk cetak berkas Berita Acara & Laporan.
- **AI & OCR Service**:
  - Google Gemini API (`gemini-1.5-flash` / model terbaru).
  - LiteLLM Proxy lokal (`scripts/start_litellm.bat`).
  - YuuLabs Vision API.
  - Python / FastAPI Microservice (`document-ai-service/`).

---

## 📋 Prasyarat Sistem (Prerequisites)

Sebelum melakukan instalasi, pastikan lingkungan komputer Anda sudah terpasang:

1. **PHP**: Versi `^8.2` atau lebih baru.
   - Ekstensi PHP yang wajib aktif di `php.ini`: `pdo_mysql`, `mbstring`, `openssl`, `fileinfo`, `gd`, `curl`, `xml`.
2. **Composer**: Versi `2.x`.
3. **Node.js**: Versi `18.x` atau `20.x+` dan **NPM**.
4. **Database Server**: MySQL atau MariaDB (misalnya melalui **XAMPP**, **Laragon**, atau MySQL Service native).
5. **Git**: Untuk clone repository dan version control.
6. **Python 3.10+** *(Opsional)*: Hanya jika ingin menjalankan LiteLLM Proxy atau FastAPI service OCR lokal.

---

## ⚙️ Panduan Instalasi & Setup Lengkap

Ikuti langkah-langkah berikut untuk mengatur dan menjalankan proyek dari awal:

### 1. Clone Repository

Buka terminal (Git Bash, Command Prompt, atau PowerShell) dan unduh repository:

```bash
git clone https://github.com/berlipm/retensi-alih-media.git
cd retensi-alih-media
```

---

### 2. Install Dependensi Backend (PHP / Composer)

Jalankan perintah berikut untuk mengunduh seluruh dependensi framework Laravel:

```bash
composer install
```

---

### 3. Install Dependensi Frontend (Node.js / NPM)

Unduh paket pustaka frontend (Vue 3, Vite, Element Plus, Tailwind):

```bash
npm install
```

---

### 4. Konfigurasi File Lingkungan (`.env`)

1. Salin file template `.env.example` menjadi `.env`:
   - **Windows (PowerShell / CMD)**:
     ```powershell
     copy .env.example .env
     ```
   - **Linux / Git Bash / macOS**:
     ```bash
     cp .env.example .env
     ```

2. Buat Application Encryption Key:
   ```bash
   php artisan key:generate
   ```

3. Buka file `.env` menggunakan teks editor (misalnya VS Code) dan sesuaikan konfigurasi basis data:
   ```dotenv
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=db_rsuk_retensi
   DB_USERNAME=root
   DB_PASSWORD=
   ```
   *(Sesuaikan `DB_USERNAME` dan `DB_PASSWORD` dengan konfigurasi MySQL/XAMPP Anda, biasanya default username `root` dengan password kosong).*

4. *(Opsional)* Konfigurasi API OCR & AI:
   Jika ingin menggunakan fitur ekstraksi OCR Google Gemini atau layanan AI lainnya, masukkan API Key Anda pada file `.env`:
   ```dotenv
   AI_ENGINE=direct
   OCR_ENGINE=gemini
   GEMINI_API_KEY=AIzaSyxxxxxxxxxxxxxxxxxxxxxxx
   GEMINI_MODEL=gemini-1.5-flash
   ```

---

### 5. Hubungkan Symlink Storage

Aplikasi memerlukan tautan symlink dari folder `public/storage` ke folder penyimpanan berkas `storage/app/public` agar dokumen rekam medis (PDF / gambar) yang diunggah dapat diakses di antarmuka web:

```bash
php artisan storage:link
```

---

### 6. Setup Database

Pastikan layanan MySQL di XAMPP / Laragon sudah dalam status **Running**. Anda dapat memilih salah satu dari dua metode di bawah ini:

#### Opsi A: Import Dump SQL (Direkomendasikan - Sudah Berisi Data Lengkap)
File dump database siap pakai telah disediakan di direktori [`database/sql/db_rsuk_retensi.sql`](database/sql/db_rsuk_retensi.sql).

1. Buka **phpMyAdmin** (`http://localhost/phpmyadmin`).
2. Buat database baru bernama `db_rsuk_retensi` (dengan collation `utf8mb4_general_ci`).
3. Pilih database `db_rsuk_retensi`, buka tab **Import**.
4. Pilih file `database/sql/db_rsuk_retensi.sql` dari folder proyek, lalu klik tombol **Import** (atau **Kirim**).

*Atau melalui terminal MySQL:*
```bash
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS db_rsuk_retensi;"
mysql -u root -p db_rsuk_retensi < database/sql/db_rsuk_retensi.sql
```

#### Opsi B: Jalankan Migration & Seeder Laravel
Jika Anda ingin membangun struktur tabel dari awal menggunakan migrasi bawaan framework:

```bash
php artisan migrate --seed
```

---

## 👥 Akun Login Bawaan (Default Credentials)

Jika menggunakan database dari dump SQL atau seeder, akun berikut siap digunakan untuk pengujian:

| Role | Username | Password | Hak Akses & Deskripsi |
| :--- | :--- | :--- | :--- |
| **Administrator** | `admin` | `password123` | Akses penuh: Manajemen User, Audit Logs, Pengaturan Sistem, Konfigurasi Retensi. |
| **Staff Rekam Medis** | `staff` / `berlian` / `petugasrm1` | `password123` | Upload berkas Alih Media, ekstraksi OCR, verifikasi/validasi berkas, pengajuan pemusnahan. |
| **Direktur** | `direktur` | `password123` | Verifikasi akhir & persetujuan Surat Keputusan (SK) Pemusnahan berkas inaktif. |

---

## ▶️ Cara Menjalankan Aplikasi

Jalankan server backend dan frontend di terminal terpisah:

### 1. Jalankan Backend Laravel (Terminal 1)
```bash
php artisan serve
```
Aplikasi backend akan aktif di: **`http://127.0.0.1:8000`**

### 2. Jalankan Frontend Vite Dev Server (Terminal 2)
```bash
npm run dev
```
Vite akan mengompilasi asset Vue 3 dan mengaktifkan hot-module replacement (HMR).

Buka peramban (browser) dan akses alamat:
👉 **`http://127.0.0.1:8000`** atau **`http://localhost:8000`**

---

### Alternatif: Menjalankan Sekaligus (All-in-One)
Proyek ini menyediakan skrip `composer run dev` yang dapat menjalankan server backend, worker antrean, dan frontend Vite secara bersamaan dalam satu terminal:

```bash
composer run dev
```

---

## 🛠️ Layanan Tambahan (Tools & Scripts)

Direktori [`scripts/`](scripts/) memuat berkas pendukung untuk pengujian dan tunneling:

- **LiteLLM Proxy Server**:
  Jalankan file batch berikut untuk mengaktifkan proxy model AI lokal di port `4000`:
  ```cmd
  scripts\start_litellm.bat
  # atau shortcut di root:
  start_litellm.bat
  ```
- **Ngrok Tunneling**:
  Jika Anda memerlukan URL publik sementara (misalnya untuk pengujian webhook atau demo online):
  ```cmd
  scripts\start_ngrok.bat
  ```
- **Build Mode Produksi**:
  Jika ingin mengompilasi frontend menjadi berkas statis siap rilis (tanpa perlu menyalakan `npm run dev`):
  ```bash
  npm run build
  ```

---

## 📁 Struktur Direktori Proyek

```text
rekam-media-retensi/
├── app/                      # Logika Backend Laravel
│   ├── Http/Controllers/     # API & Web Controllers (Auth, AlihMedia, Retensi, Pemusnahan)
│   ├── Http/Middleware/      # Middleware Hak Akses (RoleMiddleware)
│   ├── Models/               # Model Eloquent (Pasien, Retensi, Kunjungan, dll)
│   └── Services/             # Service Layer (OCR Service, AI Service, Retensi Engine)
├── bootstrap/                # Bootstrap & konfigurasi container Laravel
├── config/                   # Berkas konfigurasi aplikasi (app, database, auth, dll)
├── database/                 # Basis Data
│   ├── migrations/           # Skrip skema tabel database
│   ├── seeders/              # Seeder data pengguna, master kasus, dan pasien uji coba
│   └── sql/                  # Dump SQL lengkap (db_rsuk_retensi.sql)
├── docs/                     # Dokumentasi Teknis & Panduan Lanjutan
│   ├── DEV_RULES.md          # Aturan dan konvensi pengembangan
│   ├── PROJECT_CONTEXT.md    # Domain dan alur bisnis rekam medis
│   ├── KASUS_RETENSI_ANALYSIS.md # Analisis klasifikasi & masa retensi kasus medis
│   └── TABLE_PATTERN_ANALYSIS.md # Dokumentasi relasi antar tabel database
├── document-ai-service/      # Layanan FastAPI Python Google Document AI (Opsional)
├── public/                   # Asset statis publik web (Favicon, logo, file kompilasi)
├── resources/                # Source Code Frontend Vue 3
│   ├── css/                  # Styling kustom & konfigurasi Tailwind
│   ├── js/
│   │   ├── components/       # Komponen UI Vue (Header, Sidebar, Modal, Table)
│   │   ├── pages/            # Halaman Vue (Dashboard, Alih Media, Validasi, Retensi, Pemusnahan)
│   │   ├── router.js         # Pengalamatan rute SPA Vue Router
│   │   └── utils/            # Helper utilitas (notifikasi Swal, pemformat data)
│   └── views/                # Blade template utama (app.blade.php) & template cetak PDF
├── routes/                   # Routing aplikasi (web.php untuk Web & API endpoints)
├── scripts/                  # Skrip utilitas, pengujian API, dan shortcut batch
├── storage/                  # Penyimpanan log sistem dan berkas dokumen rekam medis
└── tests/                    # Pengujian otomatis Feature & Unit (PHPUnit)
```

---

## ❓ Pemecahan Masalah (Troubleshooting)

### 1. Gambar atau Berkas PDF Dokumen Tidak Tampil di Browser
- **Penyebab**: Symlink storage belum terpasang atau terputus.
- **Solusi**: Jalankan perintah:
  ```bash
  php artisan storage:link
  ```

### 2. Error `No application encryption key has been specified`
- **Penyebab**: File `.env` belum memiliki key enkripsi.
- **Solusi**: Jalankan perintah:
  ```bash
  php artisan key:generate
  ```

### 3. Error Koneksi Database `SQLSTATE[HY000] [2002]`
- **Penyebab**: Layanan MySQL / MariaDB belum aktif di XAMPP / Laragon, atau port salah.
- **Solusi**:
  1. Buka XAMPP Control Panel dan pastikan modul **MySQL** sudah berstatus hijau (**Start**).
  2. Periksa kembali `DB_PORT=3306` dan `DB_DATABASE=db_rsuk_retensi` pada berkas `.env`.

### 4. Perubahan Kode Frontend Tidak Muncul
- **Penyebab**: Vite server belum dijalankan.
- **Solusi**: Pastikan `npm run dev` sedang berjalan di terminal Anda. Jika untuk mode produksi, jalankan `npm run build`.

---

## 📖 Dokumentasi Teknis Tambahan

Untuk mempelajari arsitektur teknis lebih mendalam, silakan baca dokumentasi pendukung berikut:
- [Aturan Pengembangan (docs/DEV_RULES.md)](docs/DEV_RULES.md)
- [Konteks Bisnis & Alur Medis (docs/PROJECT_CONTEXT.md)](docs/PROJECT_CONTEXT.md)
- [Analisis Perhitungan Retensi Kasus (docs/KASUS_RETENSI_ANALYSIS.md)](docs/KASUS_RETENSI_ANALYSIS.md)
- [Pola dan Relasi Database (docs/TABLE_PATTERN_ANALYSIS.md)](docs/TABLE_PATTERN_ANALYSIS.md)
- [Panduan Skrip Bantuan (scripts/README.md)](scripts/README.md)
