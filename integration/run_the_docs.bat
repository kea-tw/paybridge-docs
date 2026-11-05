@echo off
rem Локальный просмотр подпроекта: http://127.0.0.1:8001
cd /d "%~dp0"
mkdocs serve -a 127.0.0.1:8001
