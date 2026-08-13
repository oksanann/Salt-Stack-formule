---
product: osmax
doc_type: salt-formula-checklist
title: Анти-паттерны формул Осмакс
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/work-with-formulas/create-formula/
priority: 4
---

# Анти-паттерны (чего ИИ не должен делать)

## Структура

- Называть корень не по шаблону `<name>-formula`
- Класть `.sls` сразу в корень без поддиректории `<name>`
- Пропускать `clean.sls` или `FORMULA`
- Использовать точки в именах директорий/`state.sls`-подобных путях кроме расширения

## Pillar / Jinja

- Хардкодить имя формулы вместо `tplroot`
- Читать параметры минуя `lookup`
- Класть секреты в SLS или `files/`
- Передавать пароль через `env` так, что он попадёт в логи

## Состояния

- Дублировать `name` формулы с существующими
- Генерировать ID состояний с точками
- Делать apply без симметричного clean
- Писать неидемпотентный `cmd.run` без `unless`/`onlyif`

## Платформы

- Смешивать Linux и Windows команды в одном состоянии
- Заявлять Windows в FORMULA без Windows-ветки
- Использовать `/home/...` и `.desktop` для Windows без адаптации

## Качество ответа

- Отдавать список файлов для ручного копирования вместо сборщика
- Отдавать псевдокод/`TODO` вместо рабочего скрипта
- **Создавать каталог с пустыми файлами** — критическая ошибка
- **Создавать файлы только с комментариями** (`# placeholder`, `{# TODO #}`)
- Использовать `touch` или `> file` без содержимого
- Heredoc без quoted delimiter (`EOF` вместо `'EOF'`) для SLS — ломает Jinja
- Вкладывать heredoc друг в друга — использовать функцию `write_file`
- Self-check только на существование файла, без проверки `-s` (non-empty)
- Требовать внешние pip-зависимости для Python-сборщика
- Выполнять в сборщике shell/network/удаление чужих каталогов
- Выдумывать несуществующие Salt-модули
- Игнорировать ближайший `tpl-*` шаблон без причины

## Bash-скрипт: типичные ошибки ИИ

1. `mkdir -p` + `touch init.sls` → **запрещено**
2. Heredoc с незакрытым `EOF` → syntax error
3. Jinja `{{ }}` в unquoted heredoc → shell eat content
4. Один giant heredoc со всей формулой → обрезается моделью
5. **Решение:** паттерн `write_file` из `10-bash-generator-reference.md`
