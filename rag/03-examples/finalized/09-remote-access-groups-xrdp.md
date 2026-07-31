---
product: osmax
doc_type: salt-formula-example
title: Готовая формула remote-access-groups-xrdp
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/remote-access-groups-xrdp-formula/
template: finalized
priority: 3
---

# Формула remote-access-groups-xrdp

Назначение: ограниченный удалённый доступ к рабочему столу через xRDP (`osmax-ira-xrdp`).

## Особенности Astra

Пакет привязан к версии ОС и `xserver-xorg-core`.

Автоподстановка имени: `osmax-ira-xrdp-astra<версия>-xorg<версия>` (если установлен xserver-xorg-core).

Версия `1.3.0+xorg` → к версии добавляется версия xorg с хоста.

## Состояния

- `remote-access-groups-xrdp`
- `remote-access-groups-xrdp.package`
- `remote-access-groups-xrdp.clean`
- `remote-access-groups-xrdp.package.clean`

Apply создаёт:

- `/opt/osmax/xrdp/etc/xrdp/xrdp.ini`
- `/opt/osmax/xrdp/etc/xrdp/sesman.ini`
- `/etc/access-groups-rdp`
- `/etc/access-ip-rdp`

и запускает `osmax-ira-xrdp`, `osmax-ira-xrdp-sesman`.

## Пример lookup для UI

```json
{
  "lookup": {
    "pkg": { "version": "1.5.5" },
    "xrdp_ini": {
      "port": "3388",
      "LogFile": "xrdp-daemon.log",
      "LogLevel": "INFO",
      "SysLogLevel": "INFO",
      "security_layer": "negotiate"
    },
    "sesman_ini": {
      "param": "/usr/lib/xorg/Xorg",
      "LogLevel": "INFO",
      "ListenPort": "3349",
      "SysLogLevel": "INFO",
      "IdleTimeLimit": "0",
      "KillDisconnected": "false",
      "DisconnectedTimeLimit": "0"
    },
    "xrdp_access_ips": ["+"],
    "remote_access_groups": ["Domain Users"]
  }
}
```

## xrdp_access_ips

- `+` разрешить, `-` запретить
- можно с IP/маской: `+199.35.209.1/32`
- правила проверяются по порядку до первого совпадения

## Паттерн

См. `08-pattern-remote-access.md`.
