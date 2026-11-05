# Интеграция

Раздел для разработчиков интернет-банка и ТСП, которые подключаются к PayBridge B2B.

| Вам нужно | Ссылка на раздел |
| --- | --- |
| Принимать оплату от юридических лиц по QR-коду или ссылке | [Merchant API](api/merchant-api.md), [Входящий платёж](incoming.md) |
| Отправлять платежи из интернет-банка | [Исходящий платёж](outgoing.md) |
| Понять, почему запрос отклонён | [Коды ошибок](api/errors.md) |

## Быстрый старт

1. Получите у банка `client_id` и `client_secret` для тестового контура.
2. Получите токен доступа:

    ```bash
    curl -X POST https://sandbox.paybridge.example/oauth/token \
      -d grant_type=client_credentials \
      -d client_id=$CLIENT_ID \
      -d client_secret=$CLIENT_SECRET
    ```

    Значение поля `access_token` из ответа передавайте в заголовке `Authorization` следующих запросов. Токен действует 3600 секунд (поле `expires_in`).

    ```json
    { "access_token": "eyJhbGciOi...", "token_type": "Bearer", "expires_in": 3600 }
    ```

3. Создайте первую платёжную ссылку:

    ```bash
    curl -X POST https://sandbox.paybridge.example/v1/payment-links \
      -H "Authorization: Bearer $TOKEN" \
      -H "Idempotency-Key: $(uuidgen)" \
      -H "Content-Type: application/json" \
      -d '{"amount": 150000, "currency": "RUB", "purpose": "Оплата по счёту № 42 от 01.10.2026", "merchantId": "MRC-0001"}'
    ```

    Сокращённый ответ:

    ```json
    { "linkId": "lnk_2b9x7", "url": "https://pay.paybridge.example/l/lnk_2b9x7", "status": "ACTIVE" }
    ```

4. Откройте ссылку из поля `url`. В тестовом контуре платёж можно подтвердить без реального списания.

!!! info "Суммы указываются в копейках"
    Во всех методах API сумма передаётся целым числом в копейках: `150000` — это 1 500,00 ₽.
