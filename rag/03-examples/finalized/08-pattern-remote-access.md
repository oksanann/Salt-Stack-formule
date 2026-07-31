---
product: osmax
doc_type: salt-formula-example
title: Паттерн remote-access-groups (SSH / xRDP / TigerVNC)
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/remote-access-groups-ssh-formula/
priority: 3
---

# Паттерн remote-access-groups-*

Семейство готовых формул:

- `remote-access-groups-ssh` → пакет `osmax-ira-openssh`
- `remote-access-groups-xrdp` → пакет `osmax-ira-xrdp`
- `remote-access-groups-tigervnc` → пакет `osmax-ira-tigervnc`

## Общая модель

Apply:

1. Установить специализированный пакет Осмакс (с автосуффиксом Astra)
2. Создать конфиги в `/opt/osmax/...` и access-файлы в `/etc/...`
3. Включить и запустить сервис(ы)

Clean (обратно):

1. Остановить сервис(ы)
2. Удалить конфиги
3. Удалить пакет

Состояния обычно:

- `{{name}}`
- `{{name}}.package`
- `{{name}}.clean`
- `{{name}}.package.clean`

## Astra: автовыбор имени пакета

С Осмакс 1.19.0 в map.jinja:

| ОС | SSH | TigerVNC | xRDP |
|----|-----|----------|------|
| Astra 1.7 | `...-astra1.7` | `...-astra1.7` | `...-astra1.7-xorg...` |
| Astra 1.8 | `...-astra1.8` | `...-astra1.8` | `...-astra1.8-xorg...` |

В pillar достаточно базового `pkg.name` или только `pkg.version`. Имя пакета в UI часто не указывают.

## Общие поля lookup

```yaml
lookup:
  pkg:
    name: osmax-ira-<product>
    version: '1.3.0'   # '' = latest
  remote_access_groups: []   # Samba: DOMAIN\Group; в JSON: DOMAIN\\Group
```

Плюс продукто-специфичные access IP / ini options.

## Доступ по умолчанию

Пустые access-правила = все подключения заблокированы.

## Выводы для генерации

- Не хардкодьте суффикс `-astra1.7` в pillar — считайте в map.jinja по grains.
- Clean всегда останавливает сервис до удаления файлов/пакета.
- Доменные группы — формат Samba с экранированием в JSON.
