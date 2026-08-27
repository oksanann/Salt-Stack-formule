---
product: osmax
doc_type: salt-formula-example
title: Обзор формул-шаблонов Осмакс
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/example-formulas/example-formulas-overview/
priority: 2
---

# Формулы-шаблоны Осмакс

Формулы-шаблоны (`tpl-*`) используются как образец для создания собственных формул похожего типа.

## Как пользоваться шаблоном

1. Скопировать директорию шаблона в новую с новым именем.
2. Переименовать ID состояний под новое имя формулы.
3. Обновить `map.jinja` (ключ `<new-name>:lookup` и defaults).
4. Обновить `pillar.example`, `FORMULA`, скрипты/файлы.
5. Сохранить `clean.sls` как полный откат apply.

## Каталог шаблонов `tpl-*`

| Шаблон | Когда выбирать |
|--------|----------------|
| `tpl-script` | Нужно выполнить скрипт на minion |
| `tpl-group-members` | Управление локальными группами и членством |
| `tpl-shortcut` | Ярлыки приложений, URL-ссылки, symlink на Desktop |

## Когда `tpl-*` НЕ подходит

Для установки пакетов / внешнего repo / Windows winrepo используйте паттерны из `03-examples/finalized/`:

| Задача | Паттерн |
|--------|---------|
| Пакет + внешний repo + key | `01-pattern-package-repo`, `google-chrome`, `yandex-browser` |
| Пакет без внешнего repo | `agent-update`, `putty` (with_repo=false) |
| Windows установка | `winrepo` (default), см. `12-repos-winrepo-pillar.md` |

Не подгоняйте package-формулу под `tpl-script`.

## Правило выбора

1. Сначала выберите ближайший `tpl-*` **или** finalized package-pattern.
2. Не создавайте новую архитектуру без причины.
3. Linux/Windows ветки и methods — по `02-linux-windows.md` и `07-os-specific-mapping.md`.
