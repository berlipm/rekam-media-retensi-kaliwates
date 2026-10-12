# Helper Scripts & Developer Tools

Folder ini berisi skrip utilitas untuk pengembangan lokal, pengujian AI/OCR, dan integrasi layanan.

## Daftar Skrip

| Skrip / File | Deskripsi |
| :--- | :--- |
| `start_litellm.bat` | Menjalankan server LiteLLM Proxy lokal di port `4000`. |
| `start_ngrok.bat` | Membuka tunnel publik Ngrok mengarah ke backend lokal (port `8000`). |
| `check_litellm.py` | Memeriksa konektivitas ke Gemini API dan LiteLLM Proxy. |
| `tes_ocr.py` | Skrip pengujian ekstraksi teks/OCR berbasis Python. |
| `dokumen_rs.jpg` | Gambar contoh rekam medis untuk pengujian `tes_ocr.py`. |
| `config.yaml` | Konfigurasi model dan parameter untuk LiteLLM proxy. |

## Subfolder `testing/`

Folder `testing/` memuat skrip pengujian API langsung dan generator model:
- `test_gemini.php`: Benchmark langsung ke berbagai model Gemini Google API (v1 & v1beta).
- `test_gemini_ocr.php`: Pengujian pemrosesan OCR gambar melalui model Gemini.
- `test_yuulabs_ocr.php`: Pengujian integrasi endpoint OCR YuuLabs.
- `make_models.php`: Skrip generator awal Eloquent Model.
