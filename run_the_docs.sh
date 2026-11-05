#!/bin/sh
# Локальный просмотр всего сайта: http://127.0.0.1:8000
# Сначала подпроекты рендерят свои диаграммы PlantUML, затем запускается общий сайт.
set -e
cd "$(dirname "$0")"
for p in admin integration; do
  (cd "$p" && mkdocs build -q -d /tmp/paybridge-$p)
done
mkdocs serve
