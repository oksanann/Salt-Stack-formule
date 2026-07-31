---
product: osmax
doc_type: salt-formula-rules
title: Мета-состояния apply и clean
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/work-with-formulas/create-formula/
priority: 1
---

# Доступные состояния формулы Осмакс

Каждому состоянию нужен уникальный ID в рамках продукта. Ниже — каноническая модель состояний из документации Осмакс.

## Состояние {{formula-name}}

Мета-состояние apply. Включает другие состояния через `include`.

Типично устанавливает пакет `{{formula-name}}` из целевого репозитория. Может зависеть от:

- `{{formula-name}}.repository`
- `{{formula-name}}.package`

## Состояние {{formula-name}}.repository (если применимо)

Зависит от `{{formula-name}}.repository.install` через `include`.

### {{formula-name}}.repository.install

Импортирует репозиторий, если `repo.name` задан в pillar (или не пустой по умолчанию). Зависит от:

- `{{formula-name}}.repository.package.install` через `include`
- `{{formula-name}}.repository.key.install` через `include` и `require`

### {{formula-name}}.repository.package.install

Устанавливает пакеты `repo.required_packages`.

### {{formula-name}}.repository.key.install

Загружает `repo.key_file` на minion и декодирует base64 в бинарный ключ.

## Состояние {{formula-name}}.package

Устанавливает пакет `{{formula-name}}`.

## Состояние {{formula-name}}.clean

Мета-состояние отката. Отменяет действия `{{formula-name}}` **в обратном порядке**:

- удаляет пакет;
- удаляет целевой репозиторий (если был импортирован).

Зависит от:

- `{{formula-name}}.package.clean`
- `{{formula-name}}.repository.clean`

через `include`.

### {{formula-name}}.package.clean

Удаляет пакет `{{formula-name}}`.

### {{formula-name}}.repository.clean

Удаляет файл конфигурации репозитория. Зависит от `{{formula-name}}.repository.key.clean`.

### {{formula-name}}.repository.key.clean

Удаляет key-файл репозитория.

## Состояние {{formula-name}}.run (если применимо)

Мета-состояние, которое динамически генерирует подсостояния на основе pillar.

Выполняет действия на агенте через модули, заданные в:

```text
pillar:{{formula-name}}.lookup
```

## Правило отката

`clean` всегда должен полностью откатывать то, что сделал apply, в обратном порядке. Нельзя оставлять «хвосты» (файлы, сервисы, пакеты, ключи репозитория).
