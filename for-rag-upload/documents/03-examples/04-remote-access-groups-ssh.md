---
product: osmax
doc_type: salt-formula-example
title: Пример готовой формулы remote-access-groups-ssh
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/remote-access-groups-ssh-formula/
template: finalized
priority: 3
---

# Готовая формула remote-access-groups-ssh

Назначение: установка и настройка ограничений SSH-доступа через пакет `osmax-ira-openssh` с учётом версии Astra Linux.

## Особенности ОС

Начиная с Осмакс 1.19.0:

- Astra Linux 1.7 → `osmax-ira-openssh-astra1.7`
- Astra Linux 1.8 → `osmax-ira-openssh-astra1.8`

Формула выбирает пакет по `grains.osmajorrelease`. В pillar достаточно базового имени или только `pkg.version`.

## Доступные состояния

- `remote-access-groups-ssh`
- `remote-access-groups-ssh.package`
- `remote-access-groups-ssh.clean`
- `remote-access-groups-ssh.package.clean`

## Что делает apply

1. Устанавливает пакет `osmax-ira-openssh` (с суффиксом ОС).
2. Создаёт конфиги SSH/PAM/access-groups.
3. Включает и запускает сервис `osmax-ira-sshd`.

## Что делает clean

1. Останавливает сервис.
2. Удаляет конфиги.
3. Удаляет пакет.

## Пример lookup для UI (JSON)

```json
{
  "lookup": {
    "pkg": {
      "version": "1.4.5"
    },
    "sshd_config": {
      "Port": "222"
    },
    "remote_access_groups": [
      "Domain Users"
    ],
    "passwordauthentication_ips": [
      "*"
    ]
  }
}
```

## Фрагмент pillar.example

```yaml
remote-access-groups-ssh:
  lookup:
    pkg:
      name: osmax-ira-openssh
      version: '1.3.0'
    access_groups_ignore: false
    kerberosauthentication_ips: ['*']
    passwordauthentication_ips: ['*']
    gssapiauthentication_ips: ['*']
    pubkeyauthentication_ips: ['*']
    kbdinteractiveauthentication_ips: ['*']
    remote_access_groups: []
    config_customize:
      ChannelTimeout: '*=5m'
      UnusedConnectionTimeout: '5m'
    sshd_config:
      Port: 22
```

## Доменные группы

В `remote_access_groups` указывайте Samba-формат `DOMAIN\group`. В JSON экранируйте слэш: `LOCALDOMAIN\\Local Users`.

## Ключевые выводы для генерации

- Готовая формула = package + config files + service + симметричный clean.
- OS-specific значения лучше вычислять в map/jinja по grains, а не требовать от админа.
- Pillar в UI может быть короче `pillar.example` — только переопределения.
