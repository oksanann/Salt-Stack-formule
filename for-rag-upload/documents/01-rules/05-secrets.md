---
product: osmax
doc_type: salt-formula-rules
title: Безопасность секретов в pillar и args
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/work-with-formulas/create-formula/
priority: 1
---

# Безопасное хранение и передача конфиденциальных данных

## Правило

Пароли, ключи и другие секреты передавайте через pillar-файлы. Pillar содержит информацию, специфичную для minion, и защищает данные при передаче.

Секреты задаются администратором при создании версии конфигурации в UI «Кабинет администратора».

## Пример pillar с секретами

```json
{
  "lookup": {
    "user": "user123",
    "password": "password"
  }
}
```

## Как передавать секреты в скрипт

Чтобы пароли не попали в логи и результаты исполнения, передавайте их в скрипт через атрибут `args`, а не через `env` и не через echo.

```yaml
run_script:
  cmd.script:
    - name: salt://{{ slspath }}/files/error.sh
    - args: "-u {{ error_params.user }} -p {{ error_params.password }}"
```

## Запрещено

- Хардкодить пароли в `.sls` и файлах в `files/`.
- Писать секреты в `env` скрипта, если это приводит к появлению в логах.
- Выводить секреты в `comment` state line или `cmd.run` echo.
