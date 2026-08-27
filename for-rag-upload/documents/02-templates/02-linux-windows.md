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
{# Windows: prefer winrepo (pkg.installed), else chocolatey / installer #}
{%- else %}
# Linux states: pkg.*, file.*, cmd.script с /bin/sh
{%- endif %}
```

Для скриптов/маркеров берите пути из `mapdata` (`marker_path`, `shell`), а не хардкодьте Linux-пути в SLS.

## Windows methods (package formulas)

| method | Модуль | Когда |
|--------|--------|-------|
| `winrepo` | `pkg.installed` | Default в Осмакс/Salt winrepo |
| `chocolatey` | `chocolatey.installed` | Через pillar |
| `installer` | `file.managed` + `cmd.run` | Прямой MSI/EXE URL |

Pillar может переопределить `repo.*` на Linux и `windows.method` на Windows.
См. `12-repos-winrepo-pillar.md`.

## Запрещено

- Linux-команды (`test -f`, `bash`) в ветке Windows.
- POSIX-пути в ветке Windows без адаптации.
- Один и тот же `shell` для обеих платформ без override в map.jinja.
- Default Windows method `chocolatey`, если правила требуют `winrepo` (если пользователь явно не просил chocolatey).

## FORMULA.os / os_family

Указывайте реально поддерживаемые семейства. Если формула только Linux — не заявляйте Windows.
