---
product: osmax
doc_type: salt-formula-example
title: Готовая формула get-hostname
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/get-hostname-formula/
template: finalized
priority: 3
---

# Формула get-hostname

Назначение: выполнение скриптов / развёртывание systemd-сервиса со скриптом.

## Состояния

- `get-hostname` — apply (include install)
- `get-hostname.install` — systemd + Python-скрипт + веб-сервер localhost:9898
- `get-hostname.clean` — удаляет service/script, отключает сервис

## pillar.example

```yaml
get-hostname:
  lookup:
    python_path: '/opt/saltstack/salt/bin/python3'
    script_path: '/opt/saltstack/salt/include/get-hostname.py'
    service_path: '/etc/systemd/system/get-hostname.service'
    owner_name: 'root'
    owner_group: 'root'
```

## Паттерн

Статический lookup (тип A): пути и владельцы через map.jinja + override.
Clean симметрично удаляет файлы сервиса и скрипта.
Ближайший шаблон для кастомизации: `tpl-script`, но здесь ещё есть systemd unit.
