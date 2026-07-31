---
product: osmax
doc_type: salt-formula-example
title: Готовая формула agent-update
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/agent-update-formula/
template: finalized
priority: 3
---

# Формула agent-update

Назначение: переустановка агента (minion).

## Состояния

- `agent-update` — мета-состояние apply
- зависимость: `agent-update.package`

Устанавливает пакет `salt-minion` из целевого репозитория.

## pillar.example

```yaml
agent-update:
  lookup:
    pkg:
      name: "salt-minion"
      version: "3006.5"   # пустая строка = последняя версия
      fromrepo: ""
```

## Паттерн

Простой package-install без внешнего repo-блока. Подходит как образец минимальной package-формулы.
