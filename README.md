# Документация PayBridge B2B (портфолио)

Демонстрационный проект технического писателя **Екатерины Качаловой**: документация вымышленного шлюза B2B-платежей в формате docs-as-code.

**Сайт:** https://kea-tw.github.io/paybridge-docs/

> Продукт, компания и платёжная сеть вымышлены. Структура и инструменты повторяют реальную рабочую документацию, всё содержание написано заново.

## Об авторе

Екатерина Качалова, технический писатель: 20 лет в профессии, из них 14 в финтехе (СБП, Цифровой рубль, эквайринг, ATM). Документация API и интеграций, docs-as-code (MkDocs, Git, PlantUML).

## Что показывает проект

- **Руководство администратора:** архитектура, порядок установки, параметры, проверка работоспособности и логи сервисов.
- **Руководство пользователя кабинета ТСП:** задачи пользователя по шагам, макеты экранов с выносками, типовые проблемы.
- **Документация для интеграторов:** быстрый старт, сценарии платежей, статусная модель, webhooks, коды ошибок.
- **Справочник REST API** из спецификации OpenAPI (`integration/docs/api/merchant-api.yaml`).
- **Диаграммы как код:** архитектура, взаимодействия компонентов, последовательности и статусы в PlantUML.
- **Monorepo:** подпроекты `admin`, `integration` и `user` со своими `mkdocs.yml` собираются в общий сайт.
- **Публикация:** GitHub Actions → GitHub Pages; Docker-образ с nginx для размещения у себя.

## Инструменты

MkDocs · Material for MkDocs · mkdocs-monorepo-plugin · PlantUML · OpenAPI / Swagger UI · Git · GitHub Actions · Docker · nginx

## Структура

```
.
├── mkdocs.yml               # общий сайт (monorepo)
├── docs/                    # главная и история изменений
├── admin/                   # подпроект «Администрирование»
│   ├── mkdocs.yml
│   ├── run_the_docs.sh|.bat
│   └── docs/
│       ├── architecture.md, structure.md, components/
│       └── diagrams/src/*.puml
├── integration/             # подпроект «Интеграция»
│   ├── mkdocs.yml
│   ├── run_the_docs.sh|.bat
│   └── docs/
│       ├── outgoing.md, incoming.md, api/ (OpenAPI)
│       └── diagrams/src/*.puml
├── user/                    # подпроект «Кабинет ТСП» (руководство пользователя)
│   ├── mkdocs.yml
│   └── docs/
│       ├── login.md, payment-link.md, refund.md
│       └── images/              # макеты экранов
├── run_the_docs.sh|.bat     # локальный просмотр всего сайта
├── Dockerfile, nginx.conf   # образ с готовым сайтом
└── .github/workflows/publish.yml
```

## Локальный просмотр

```bash
python -m venv .venv
. .venv/bin/activate          # Windows: .venv\Scripts\activate
pip install -r requirements.txt
./run_the_docs.sh             # Windows: run_the_docs.bat
```

Общий сайт открывается по адресу http://127.0.0.1:8000. Отдельный подпроект запускается скриптом `admin/run_the_docs.sh` или `integration/run_the_docs.sh` и открывается по адресу http://127.0.0.1:8001.

Готовые SVG-диаграммы лежат в репозитории (`*/docs/diagrams/out/`), поэтому сайт собирается полностью и обычной командой `mkdocs serve`. После правки исходника `.puml` запустите `run_the_docs.sh` / `run_the_docs.bat`: скрипт перерисует диаграммы, затем закоммитьте обновлённые SVG. Опубликованный сайт перерисовывает диаграммы из исходников при каждой сборке.

Диаграммы рендерятся через сервер PlantUML (по умолчанию plantuml.com). Внутренний сервер задаётся переменной окружения `PLANTUML_SERVER`.


## Docker

```bash
docker build -t paybridge-docs .
docker run -d -p 8080:80 paybridge-docs      # http://localhost:8080
```
