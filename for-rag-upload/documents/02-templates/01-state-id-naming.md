---
product: osmax
doc_type: salt-formula-example
title: Паттерн именования ID состояний
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/example-formulas/tpl-shotrcut/tpl-shortcut-formula/
priority: 2
---

# Именование ID состояний в формулах Осмакс

## Рекомендуемый формат

```text
formula-name-state-name-other-state-name-module-function-some-id
```

Пример для symlink:

```text
my-shortcut-install-file-symlink-{{ username }}-symlink
```

## Примеры корректных ID

- `my-script-run-cmd-script`
- `my-script-clean-file-absent`
- `my-group-members-group-present`
- `my-group-members-group-absent`
- `my-shortcut-install-file-managed-{{ username }}-application`
- `my-shortcut-install-file-managed-{{ username }}-link`

## Правила

1. ID уникален в рамках продукта.
2. В ID нет точек.
3. Имя формулы — префикс ID.
4. При циклах (`for username`) включайте переменную в ID.
5. В `clean.sls` ID могут совпадать с apply-ID только если это осознанно и не конфликтует; предпочтительно различать stage (`install`/`clean`) или module function (`present`/`absent`).
