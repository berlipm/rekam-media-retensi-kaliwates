# Sistem Retensi & Alih Media Rekam Medis (RSU Kaliwates)

Sistem informasi manajemen rekam medis terpadu untuk digitalisasi berkas, ekstraksi OCR berbasis kecerdasan buatan, penentuan status retensi berkas, serta tata kelola pemusnahan arsip rekam medis secara elektronik sesuai regulasi rumah sakit.

---

## 🚀 Fitur Utama

- **Digitalisasi & Alih Media (OCR)**: Ekstraksi otomatis data resume/dokumen rekam medis (PDF & Gambar) menggunakan Multi-Engine AI (Google Gemini, LiteLLM Proxy, dan YuuLabs Vision).
- **Validasi Data Medis**: Verifikasi data pasien, nomor rekam medis, riwayat kunjungan, dan kategori kasus medis sebelum data tersimpan ke basis data utama.
- **Perhitungan Retensi Otomatis**: Klasifikasi berkas aktif dan inaktif serta masa simpan berdasarkan jenis kasus (Umum, Jiwa, Kusta, Ketergantungan Obat, Anak, dll).
- **Pengajuan SK & Pemusnahan Arsip**: Alur pengajuan pemusnahan berkas inaktif, persetujuan direktur, dan pencetakan otomatis Berita Acara Pemusnahan (PDF).
- **Chat AI Assistant**: Asisten virtual terintegrasi untuk konsultasi dan tanya-jawab seputar regulasi rekam medis.
- **Log Aktivitas & Audit Trail**: Pencatatan riwayat setiap aksi pengguna untuk akuntabilitas sistem.

---

## 🛠️ Tech Stack

- **Backend**: Laravel 12 (PHP 8.2+) dengan arsitektur Service Layer & Eloquent ORM.
- **Frontend**: Vue 3 (Composition API) + Vite + Tailwind CSS + Element Plus.
- **AI & OCR Service**:
  - Python / FastAPI Microservice (`document-ai-service/`).
  - Google Gemini Direct API & LiteLLM Proxy.
  - YuuLabs Vision API.
- **Database**: MySQL / MariaDB.
- **Reporting**: DomPDF untuk pencetakan Berita Acara & Laporan.

---

## 📁 Struktur Direktori

```text
rekam-media-retensi/
├── app/                      # Backend Logic
│   ├── Http/Controllers/     # API & Web Controllers
│   ├── Http/Middleware/      # Role & Auth Middleware
│   ├── Models/               # Eloquent Models
│   └── Services/             # Business & AI Services (OCR, Retensi, Gemini)
├── bootstrap/                # Laravel bootstrap files
├── config/                   # File konfigurasi aplikasi Laravel
├── database/                 # Database
│   ├── migrations/           # Skema tabel database
│   ├── seeders/              # Seeder data awal
│   └── sql/                  # Backup dump database (db_rsuk_retensi.sql)
├── docs/                     # Dokumentasi Teknis & Panduan
│   ├── DEV_RULES.md          # Standar dan aturan pengembangan sistem
│   ├── PROJECT_CONTEXT.md    # Domain & konteks rekam medis
│   ├── KASUS_RETENSI_ANALYSIS.md # Analisis klasifikasi & masa retensi kasus
│   └── TABLE_PATTERN_ANALYSIS.md # Desain relasi & pola tabel database
├── document-ai-service/      # Layanan FastAPI Python Google Document AI
├── public/                   # Asset publik web (Favicon, Logo, Images)
├── resources/                # Source frontend Vue 3
│   ├── css/                  # Styling & Tailwind
│   ├── js/
│   │   ├── components/       # Reusable Vue components
│   │   ├── pages/            # View halaman aplikasi
│   │   ├── router.js         # Vue Router SPA
│   │   └── utils/            # Helper utilitas (notifikasi, dll)
│   └── views/                # Blade template utama & layout PDF
├── routes/                   # Routing aplikasi (web.php & console.php)
├── scripts/                  # Skrip bantuan & tools pengembang
│   ├── check_litellm.py      # Pengujian konektivitas LiteLLM
│   ├── start_litellm.bat     # Server LiteLLM Proxy (port 4000)
│   ├── start_ngrok.bat       # Tunneling Ngrok lokal (port 8000)
│   ├── tes_ocr.py            # Skrip uji coba ekstraksi OCR gambar
│   └── testing/              # Skrip pengujian API langsung (Gemini & YuuLabs)
├── storage/                  # Log dan storage berkas aplikasi
├── tests/                    # Pengujian otomatis Feature & Unit (PHPUnit)
├── start_litellm.bat         # Shortcut LiteLLM Proxy di root
└── start_ngrok.bat           # Shortcut Ngrok di root
```

---

## ⚙️ Cara Menjalankan

### 1. Prasyarat
- PHP 8.2 atau lebih baru
- Composer
- Node.js (v18+) & NPM
- MySQL / MariaDB

### 2. Instalasi & Menjalankan

```bash
# 1. Install dependensi PHP
composer install

# 2. Install dependensi Node.js
npm install

# 3. Konfigurasi Environment
cp .env.example .env
php artisan key:generate

# 4. Migrasi Database & Seeder
php artisan migrate --seed

# 5. Jalankan Server Pengembangan (Terminal 1)
php artisan serve

# 6. Jalankan Vite Dev Server (Terminal 2)
npm run dev
```

---

## 📖 Dokumentasi Terkait

Silakan baca berkas di direktori [`docs/`](docs/) untuk rincian teknis lengkap:
- [Aturan Pengembangan (DEV_RULES.md)](docs/DEV_RULES.md)
- [Konteks Proyek (PROJECT_CONTEXT.md)](docs/PROJECT_CONTEXT.md)
- [Analisis Kasus & Retensi (KASUS_RETENSI_ANALYSIS.md)](docs/KASUS_RETENSI_ANALYSIS.md)
- [Pola Tabel & Skema Basis Data (TABLE_PATTERN_ANALYSIS.md)](docs/TABLE_PATTERN_ANALYSIS.md)
- [Panduan Skrip Bantuan (scripts/README.md)](scripts/README.md)
