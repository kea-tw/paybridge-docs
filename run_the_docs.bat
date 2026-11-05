@echo off
rem Локальный просмотр всего сайта: http://127.0.0.1:8000
rem Сначала подпроекты рендерят свои диаграммы PlantUML, затем запускается общий сайт.
cd /d "%~dp0"
for %%p in (admin integration) do (
  pushd %%p
  mkdocs build -q -d "%TEMP%\paybridge-%%p" || (popd & exit /b 1)
  popd
)
mkdocs serve
