---
product: osmax
doc_type: salt-formula-example
title: Пример tpl-shortcut — ярлыки Desktop
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/example-formulas/tpl-shotrcut/tpl-shortcut-formula/
template: tpl-shortcut
priority: 3
---

# Формула-шаблон tpl-shortcut

Назначение: ярлык приложения, URL-ссылка и symlink на рабочий стол пользователя (`~/Desktop`).

## Доступные состояния

- `tpl-shortcut` — мета-состояние apply
- `tpl-shortcut.install` — создать ярлыки/symlink
- `tpl-shortcut.clean` — удалить ярлыки/symlink

## Пользователи

Если `user.usernames` пуст — пользователи выбираются по каталогам в `/home`.

Если `link.name` / нужные поля не заданы — соответствующий блок не выполняется.

## pillar.example

```yaml
tpl-shortcut:
  lookup:
    application:
      name: "bash_application"
    link:
      name: "ya-ru_link"
    symlink:
      name: "distro-info_debian_symlink"
      target: "/usr/share/distro-info/debian.csv"
    user:
      usernames: [
        "username_1",
        "username_2",
      ]
```

## Фрагмент install.sls (адаптация my-shortcut)

```jinja
# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as tplshortcut with context %}
{%- from tplroot ~ "/_usernames_lib.sls" import usernames with context %}

{#- Create application link #}
{%- if tplshortcut.application.name %}
{%- for username in usernames %}

my-shortcut-install-file-managed-{{ username }}-application:
  file.managed:
    - name: /home/{{ username }}/Desktop/{{ tplshortcut.application.name }}.desktop
    - user: {{ username }}
    - group: {{ username }}
    - makedirs: True
    - contents: |
        [Desktop Entry]
        Type=Application
        Name=Run bash manpage
        Exec=man bash
        Terminal=true
        Icon=dictionary

{%- endfor %}
{%- endif %}

{#- Create url link #}
{%- if tplshortcut.link.name %}
{%- for username in usernames %}

my-shortcut-install-file-managed-{{ username }}-link:
  file.managed:
    - name: /home/{{ username }}/Desktop/{{ tplshortcut.link.name }}.desktop
    - user: {{ username }}
    - group: {{ username }}
    - makedirs: True
    - contents: |
        [Desktop Entry]
        Type=Link
        Name=Love DuckDuckGo!
        URL=https://duckduckgo.com

{%- endfor %}
{%- endif %}

{#- Create symlink #}
{%- if tplshortcut.symlink.name %}
{%- for username in usernames %}

my-shortcut-install-file-symlink-{{ username }}-symlink:
  file.symlink:
    - name: /home/{{ username }}/Desktop/{{ tplshortcut.symlink.name }}
    - target: {{ tplshortcut.symlink.target }}
    - user: {{ username }}
    - group: {{ username }}
    - makedirs: True

{%- endfor %}
{%- endif %}
```

## Пример map.jinja

```jinja
{% set mapdata = salt['grains.filter_by']({
    'default': {
        'application': {
            'name': 'man_application',
        },
        'link': {
            'name': 'duckduckgo_link',
        },
        'symlink': {
            'name': 'distro-info_ubuntu_symlink',
            'target': '/usr/share/distro-info/ubuntu.csv'
        },
        'user': {
            'usernames': [
            ],
        },
    },
}, merge=salt['pillar.get']('my-shortcut:lookup'), base='default') %}
```

## Ключевые выводы для генерации

- ID включают `{{ username }}`.
- Условные блоки `{%- if ... %}` вокруг каждого типа ярлыка.
- `clean` делает `file.absent` для тех же путей.
- Ключ pillar merge: `my-shortcut:lookup`.
