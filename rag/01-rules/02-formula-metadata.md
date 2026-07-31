---
product: osmax
doc_type: salt-formula-rules
title: Файл FORMULA — метаданные формулы
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/work-with-formulas/create-formula/
priority: 1
---

# Файл FORMULA

Файл `FORMULA` описывает формулу в формате YAML.

## Обязательные атрибуты

| Атрибут | Описание |
|---------|----------|
| `name` | Имя формулы. Должно быть уникальным среди всех формул |
| `os` | Семейства ОС, поддерживающие формулу |
| `os_family` | Семейства ОС (`os_family`), поддерживающие формулу |
| `version` | Версия пакета формулы в формате `YYYYMM` |
| `release` | Выпуск версии внутри месяца (если было несколько релизов) |
| `summary` | Краткое описание |
| `description` | Подробное описание |
| `top_level_dir` | Имя поддиректории, где лежат `.sls` |

## Критическое правило уникальности name

Значение поля `name` должно быть уникальным среди всех формул. При объединении формул дублирование `name` приводит к проблемам с применением конфигураций.

## Пример FORMULA

```yaml
name: my-script
os: Debian, RedHat, Windows
os_family: Debian, RedHat, Windows
version: 202607
release: 1
summary: Execute custom script on minion
description: >
  Formula runs a custom script once and provides clean state
  to remove the idempotency marker.
top_level_dir: my-script
```

## Версионирование

- `version` — год и месяц, например `202607`.
- Если в одном месяце несколько выпусков — увеличивайте `release`: `1`, `2`, `3`.
