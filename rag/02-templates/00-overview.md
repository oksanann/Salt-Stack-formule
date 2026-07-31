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

## Каталог шаблонов

| Шаблон | Когда выбирать |
|--------|----------------|
| `tpl-script` | Нужно выполнить скрипт на minion |
| `tpl-group-members` | Управление локальными группами и членством |
| `tpl-shortcut` | Ярлыки приложений, URL-ссылки, symlink на Desktop |

## Правило выбора

Сначала выберите ближайший `tpl-*`, затем адаптируйте. Не создавайте новую архитектуру формулы без причины, если подходит существующий шаблон.
