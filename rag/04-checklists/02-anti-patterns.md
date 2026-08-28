---
product: osmax
doc_type: salt-formula-checklist
title: Анти-паттерны формул Осмакс
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/work-with-formulas/create-formula/
priority: 4
---

# Анти-паттерны (чего ИИ / генератор не должен делать)

## Пайплайн ответа

- Отдавать bash/Python-сборщик вместо **JSON-спецификации** (в JSON-режиме)
- Отдавать список файлов для ручного копирования
- Отдавать псевдокод / `TODO` / пустой JSON
- Сохранять JSON как бинарный/AppleScript файл вместо UTF-8 text

## Структура

- Корень не по шаблону `<name>-formula`
- `.sls` в корне без поддиректории `<name>`
- Пропуск `clean.sls` или `FORMULA`
- Точки в именах директорий (кроме расширения `.sls`)
- `repository/` при `with_repo=false` (или наоборот — нет repo при `with_repo=true`)

## Pillar / Jinja / repo

- Хардкод имени формулы вместо `tplroot` в SLS
- Параметры минуя `lookup`
- Захардкоженный repo без возможности override через pillar
- Устаревшие URL: `http://repo.yandex.ru/...`, comps `main,contrib,non-free` для Yandex
- Placeholder URL (`example.com`) в production-примерах без пометки «заглушка»
- Секреты в SLS/`files/`; пароль через `env` в логи

## Состояния

- Дубли `name` формулы
- ID состояний с точками
- Apply без симметричного clean
- Неидемпотентный `cmd.run` без `unless`/`onlyif`

## Платформы / Windows

- Смешивать Linux и Windows команды в одном состоянии
- Windows в FORMULA без Windows-ветки
- Default Windows = `chocolatey`, когда правила требуют **`winrepo`**
- Отсутствие `windows.winrepo_name` при `method: winrepo`
- Linux-пути/`test -f` в Windows-ветке

## Выбор шаблона

- Package/repo-формулу строить как `tpl-script`
- Игнорировать ближайший `tpl-*` или finalized package-pattern без причины

## Сборка (render_formula.sh)

- Пустые файлы / только комментарии-заглушки
- Self-check рендерера не пройден (скрипт завершился с ошибкой)
- Выдуманные модули Salt в сгенерированных SLS
