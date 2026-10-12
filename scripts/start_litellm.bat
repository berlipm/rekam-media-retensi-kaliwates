@echo off
echo MENGINSTALL DAN MENJALANKAN LITELLM PROXY
echo =========================================
echo.
echo Sedang menginstall/memastikan LiteLLM (dengan proxy) tersedia...
python -m pip install "litellm[proxy]"

echo.
echo =========================================
echo PERHATIAN: Masukkan API Key Gemini Anda di bawah ini
echo =========================================
echo.
if "%GEMINI_API_KEY%"=="" set GEMINI_API_KEY=YOUR_GEMINI_API_KEY
if "%GOOGLE_API_KEY%"=="" set GOOGLE_API_KEY=%GEMINI_API_KEY%
set GEMINI_API_VERSION=v1

echo.
echo Memulai LiteLLM Proxy di http://localhost:4000 ...
echo Konfigurasi model gemini/gemini-1.5-flash dengan API Version: v1
"%USERPROFILE%\AppData\Local\Python\pythoncore-3.14-64\Scripts\litellm.exe" --model gemini/gemini-1.5-flash-latest --model_alias "gemini-1.5-flash:gemini/gemini-1.5-flash-latest" --detailed_debug
pause
