@echo off
rem Wrapper to run the Ngrok startup script located in scripts/
call "%~dp0scripts\start_ngrok.bat" %*
