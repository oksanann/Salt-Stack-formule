---
product: osmax
doc_type: salt-formula-example
title: Пример tpl-group-members — локальные группы
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/example-formulas/tpl-group-members/tpl-group-members-formula/
template: tpl-group-members
priority: 3
---

# Формула-шаблон tpl-group-members

Назначение: управление членством в локальных группах.

## Доступные состояния

- `tpl-group-members` — мета-состояние apply
- `tpl-group-members.install` — создать/настроить группу
- `tpl-group-members.clean` — удалить группу

## Логика параметра change

| `change` | Поведение |
|----------|-----------|
| `add` | добавить пользователей (`addusers`) |
| `del` | удалить пользователей (`delusers`) |
| `""` (пусто) | заменить состав группы (`members`) |

## pillar.example

```yaml
tpl-group-members:
  lookup:
    group_name: "sudo"
    gid: ""
    system: false
    change: ""
    users: [
      "user1",
      "user2",
    ]
```

## Пример install.sls (после адаптации в my-group-members)

```jinja
# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as tplgroupmembers with context %}

{%- if tplgroupmembers.group_name %}

my-group-members-group-present:
  group.present:
    - name: {{ tplgroupmembers.group_name }}
    {%- if tplgroupmembers.gid %}
    - gid: {{ tplgroupmembers.gid }}
    {%- endif %}
    {%- if tplgroupmembers.system %}
    - system: {{ tplgroupmembers.system }}
    {%- endif %}
    {%- if tplgroupmembers.change == 'add' %}
    - addusers: {{ tplgroupmembers.users }}
    {%- elif tplgroupmembers.change == 'del' %}
    - delusers: {{ tplgroupmembers.users }}
    {%- else %}
    - members: {{ tplgroupmembers.users }}
    {%- endif %}

{%- endif %}
```

## Пример clean.sls

```jinja
# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as tplgroupmembers with context %}

{%- if tplgroupmembers.group_name %}

my-group-members-group-absent:
  group.absent:
    - name: {{ tplgroupmembers.group_name }}

{%- endif %}
```

## Пример map.jinja

```jinja
{% set mapdata = salt['grains.filter_by']({
    'default': {
        'group_name': 'sudo',
        'gid': '',
        'system': false,
        'change': 'add',
        'users': [
            'user1',
            'user2',
        ],
    },
}, merge=salt['pillar.get']('my-group-members:lookup'), base='default') %}
```

## Ключевые выводы для генерации

- Используйте declarative `group.present` / `group.absent`.
- Параметры группы — только через map/pillar.
- `clean` удаляет группу целиком.
