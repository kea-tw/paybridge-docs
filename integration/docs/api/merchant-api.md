# Merchant API

Merchant API позволяет ТСП создавать платёжные ссылки и QR-коды, получать статусы платежей и выполнять возвраты.

- **Базовый адрес:** `https://api.paybridge.example` (тестовый контур `https://sandbox.paybridge.example`).
- **Аутентификация:** OAuth 2.0 Client Credentials, токен передаётся в заголовке `Authorization: Bearer <token>`.
- **Идемпотентность:** все методы `POST` принимают заголовок `Idempotency-Key` (UUID). Повтор с тем же ключом в течение 24 часов возвращает исходный ответ.

!!swagger merchant-api.yaml!!
