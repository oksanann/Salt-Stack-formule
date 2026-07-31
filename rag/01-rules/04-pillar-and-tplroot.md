---
product: osmax
doc_type: salt-formula-rules
title: Pillar lookup и паттерн tplroot
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/work-with-formulas/create-formula/
priority: 1
---

# Передача данных через pillar в формулах Осмакс

## Как Осмакс формирует pillar

Система автоматически создаёт в pillar ключ, совпадающий с именем директории формулы (например: `file-find`, `get-hostname`, `xrdp`).

В этот ключ попадают:

- пользовательские параметры из `lookup` (задаёт администратор в Кабинете администратора);
- автоматически генерируемые атрибуты (например `version_id`).

## Каноническая структура pillar

```yaml
<имя_формулы>:
  version_id: <version_id>
  lookup:
    ...
```

## Тип A: статические настройки

`lookup` переопределяет значения по умолчанию из `map.jinja`.

Примеры формул: `get-hostname`, `xrdp`.

```yaml
get-hostname:
  lookup:
    python_path: '/opt/saltstack/salt/bin/python3'
    script_path: '/opt/saltstack/salt/get-hostname.py'
    service_path: '/etc/systemd/system/get-hostname.service'
```

## Тип B: динамические задачи

`lookup` содержит набор задач. Каждая задача — маппинг параметров для модуля.

Пример: `file-find`.

```yaml
file_find:
  lookup:
    logs_recent:
      path: /var/log
      name: "*.log"
      type: f
      mtime: -1d
      size: +10k
      md5: true
```

## Обязательный паттерн tplroot

Для переиспользования формулы используйте:

```jinja
{%- set tplroot = tpldir.split('/')[0] %}
```

Зачем:

1. Имя формулы берётся из директории, без хардкода в SLS.
2. Можно скопировать формулу (`file-find` → `file-find-custom`), сменив только имя папки.
3. Система использует новое имя директории как ключ pillar; формула читает параметры через `tplroot`.

Типичное начало SLS:

```jinja
# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as myformula with context %}
```

## map.jinja и merge lookup

Рекомендуемый стиль:

```jinja
{% set mapdata = salt['grains.filter_by']({
    'default': {
        'key': 'value',
    },
}, merge=salt['pillar.get']('my-formula:lookup'), base='default') %}
```

Ключ merge: `<formula-name>:lookup`.
