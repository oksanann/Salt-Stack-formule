---
product: osmax
doc_type: salt-formula-example
title: Пример tpl-script — выполнениела выполнения скрипта
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/example-formulas/tpl-script/tpl-script-formula/
template: tpl-script
priority: 3
---

# Формула-шаблон tpl-script

Назначение: выполнение скрипта на агенте (minion).

## Доступные состояния

- `tpl-script` — мета-состояние apply, зависит от `tpl-script.run`
- `tpl-script.run` — выполняет скрипт
- `tpl-script.clean` — удаляет маркер идемпотентности

## pillar.example

```yaml
tpl-script:
  # Переопределите значение map.jinja
  lookup:
    # Имя файла скрипта в {{ tpldir }}/files/
    file_name: "test_script.sh"
    # Оболочка для выполнения
    shell: "/bin/sh"
    # Переменные env
    env:
      test_env: "HELLO WORLD!"
```

## Как создать свою формулу на базе tpl-script

1. Скопировать `tpl-script` → `my-script`.
2. Переименовать скрипт в `files/my-new-script.sh`.
3. Обновить ID состояний в `run.sls` и `clean.sls`.
4. Обновить `map.jinja` ключ на `my-script:lookup`.

## Пример скрипта files/my-new-script.sh

```bash
#!/bin/bash
#
echo "Working hard..."
echo "True" > /var/local/my-script.run.id

# writing the state line
echo  # an empty line here so the next line will be the last.
echo "changed=yes comment='Created /var/local/my-script.run.id file' whatever=123"
```

## Пример run.sls

```jinja
# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as tplscript with context %}

{#- Run custom script #}
{%- if tplscript.file_name %}

my-script-run-cmd-script:
  cmd.script:
    - source: salt://{{ tpldir }}/files/{{ tplscript.file_name }}
    - cwd: /
    - shell: {{ tplscript.shell }}
    - unless: "test -f /var/local/my-script.run.id"

{%- endif %}
```

## Пример clean.sls

```jinja
# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as tplscript with context %}

{#- Delete marker file #}
{%- if tplscript.file_name %}

my-script-clean-file-absent:
  file.absent:
    - name: /var/local/my-script.run.id

{%- endif %}
```

## Пример map.jinja

```jinja
{% set mapdata = salt['grains.filter_by']({
    'default': {
        'file_name': 'my-new-script.sh',
        'shell': '/bin/sh',
    },
}, merge=salt['pillar.get']('my-script:lookup'), base='default') %}
```

## Ключевые выводы для генерации

- Идемпотентность через `unless` + файл-маркер.
- Скрипт сообщает Salt через state line `changed=yes comment='...'`.
- `clean` удаляет маркер.
- Источник скрипта: `salt://{{ tpldir }}/files/...`.
