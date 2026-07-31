---
product: osmax
doc_type: salt-formula-example
title: Готовая формула remote-access-groups-tigervnc
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/remote-access-groups-tigervnc-formula/
template: finalized
priority: 3
---

# Формула remote-access-groups-tigervnc

Назначение: ограниченный VNC-доступ через TigerVNC (`osmax-ira-tigervnc`).

## Astra

- 1.7 → `osmax-ira-tigervnc-astra1.7`
- 1.8 → `osmax-ira-tigervnc-astra1.8`

Выбор по `grains.osmajorrelease`.

## Состояния

- `remote-access-groups-tigervnc`
- `remote-access-groups-tigervnc.package`
- `remote-access-groups-tigervnc.clean`
- `remote-access-groups-tigervnc.package.clean`

Apply создаёт:

- `/opt/osmax/tigervnc/etc/x0vncserver.options`
- `/etc/access-groups-vnc`
- `/etc/access-ip-vnc`

и запускает `osmax-ira-tigervnc`.

## pillar.example

```yaml
remote-access-groups-tigervnc:
  lookup:
    pkg:
      name: osmax-ira-tigervnc
      version: '1.3.0'
    x0vncserver_options:
      rfbport: 5899
      QueryConnect: 1
      QueryConnectTimeout: 15
      ShowRemoteConnect: 1
    tigervnc_access_ips: []
    remote_access_groups: []
```

## Пример lookup для UI

```json
{
  "lookup": {
    "pkg": { "version": "1.4.5" },
    "tigervnc_access_ips": "+",
    "x0vncserver_options": {
      "rfbport": 5899,
      "QueryConnect": 0
    },
    "remote_access_groups": ["Domain Users"]
  }
}
```

## tigervnc_access_ips

- `+` разрешить
- `-` запретить
- `?` запрос подтверждения
- пустой список = всё заблокировано

## Ключевые x0vncserver_options

| Параметр | Смысл |
|----------|--------|
| `rfbport` | порт VNC |
| `QueryConnect` | 0 без запроса / 1 модальное окно |
| `QueryConnectTimeout` | секунды до авто-отказа |
| `ShowRemoteConnect` | показать окно Disconnect |
| `IdleTimeout` | таймаут простоя (0 = никогда) |

## Паттерн

См. `08-pattern-remote-access.md`. SSH-вариант уже в `../04-remote-access-groups-ssh.md`.
