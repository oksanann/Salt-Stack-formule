---
product: osmax
doc_type: salt-formula-example
title: Linux и Windows в map.jinja
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/work-with-formulas/create-formula/
priority: 2
---

# Кроссплатформенность Linux и Windows

Официально Осмакс тестируется преимущественно на Linux (Astra, Ubuntu, Debian, РЕД ОС и др.). Salt minion может работать и на Windows; для Windows используйте отдельные ветки `os_family`.

## map.jinja с ветками ОС

```jinja
{% set mapdata = salt['grains.filter_by']({
    'default': {
        'shell': '/bin/sh',
        'marker_path': '/var/local/my-script.run.id',
        'script_name': 'script.sh',
    },
    'Debian': {
        'shell': '/bin/bash',
    },
    'RedHat': {
        'shell': '/bin/bash',
    },
    'Windows': {
        'shell': 'powershell',
        'marker_path': 'C:\\ProgramData\\osmax\\my-script.run.id',
        'script_name': 'script.ps1',
    },
}, merge=salt['pillar.get']('my-script:lookup'), base='default') %}
```

## Правила ветвления в SLS

```jinja
{%- if grains['os_family'] == 'Windows' %}
# Windows states: win_*, file.managed с Windows-путями, powershell
{%- else %}
# Linux states: pkg.*, file.*, cmd.script с /bin/sh
{%- endif %}
```

## Запрещено

- Linux-команды (`test -f`, `bash`) в ветке Windows.
- POSIX-пути в ветке Windows без адаптации.
- Один и тот же `shell` для обеих платформ без override в map.jinja.

## FORMULA.os / os_family

Указывайте реально поддерживаемые семейства. Если формула только Linux — не заявляйте Windows.
