# Структура решения

Компоненты PayBridge B2B устанавливаются в два этапа: сначала общая инфраструктура, затем сервисы обработки платежей. Каждый сервис поставляется отдельным Docker-образом.

## Этап 1. Общая инфраструктура

1. PostgreSQL 15 или новее с базой данных `paybridge`.
2. NATS 2.10 или новее с включённым JetStream.
3. Crypto Service: устанавливается на хост, где работает СКЗИ банка.
4. NPS Connector: нужен сертификат участника НПС.

## Этап 2. Сервисы обработки платежей

1. [Payment Service](components/payment-service.md)
2. [Incoming Gateway](components/incoming-gateway.md)
3. Merchant API

### Требования к каждому сервису

Требования указаны для одного экземпляра Payment Service, Incoming Gateway или Merchant API.

| Ресурс | Минимум | Рекомендуется |
| --- | --- | --- |
| CPU | 2 vCPU | 4 vCPU |
| Оперативная память | 1 ГБ | 2 ГБ |
| Реплик | 1 | 2 и более |

!!! warning "Порядок обновления"
    Начиная с версии 2.0 Payment Service выполняет миграцию базы данных при первом запуске. После миграции откат Payment Service на версию 1.x невозможен. Перед обновлением сделайте резервную копию базы `paybridge`.

## Сетевые доступы

| Откуда | Куда | Порт | Протокол | Назначение |
| --- | --- | --- | --- | --- |
| Интернет-банк | Payment Service | 8443 | HTTPS | Исходящие платежи |
| Payment Service | Интернет-банк | 443 | HTTPS | Webhooks о статусе платежа |
| ТСП (интернет) | Merchant API | 443 | HTTPS | Платёжные ссылки, статусы, возвраты |
| Merchant API | ТСП (интернет) | 443 | HTTPS | Webhooks об оплате |
| Payment Service, Incoming Gateway | АБС | 443 | HTTPS | Резервирование средств, проверка счёта |
| Сервисы PayBridge, модуль приёма проводок АБС | NATS | 4222 | TCP / TLS | События и проводки |
| Payment Service, Merchant API | PostgreSQL | 5432 | TCP / TLS | Хранение данных |
| NPS Connector | Crypto Service | 8090 | HTTPS | Подпись и проверка подписи |
| NPS Connector | НПС | 443 | HTTPS, mTLS | Обмен сообщениями ISO 20022 |
