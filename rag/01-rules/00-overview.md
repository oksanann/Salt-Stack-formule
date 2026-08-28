---
product: osmax
doc_type: salt-formula-rules
title: Обзор правил (01-rules) — JSON-first
priority: 1
chunk: none
---

# Папка 01-rules: правила для генерации формул

## Единственный поддерживаемый пайплайн

```text
Запрос → ИИ (JSON) → json-formula/<name>.json → render_formula.sh → dist/<name>-formula/
```

ИИ **не** пишет SLS, bash и Python. ИИ заполняет JSON по контракту.  
Сборку выполняет `rag/tools/render_formula.sh`.

System prompt: `05-prompts/system-prompt-json-spec.txt`

## Карта документов

| Файл | За что отвечает |
|------|-----------------|
| **11-json-spec-contract.md** | **Главный контракт JSON** — поля, примеры, валидация |
| **12-repos-winrepo-pillar.md** | Repo URL, winrepo, pillar override |
| 01-structure.md | Структура каталогов `<name>-formula/` |
| 02-formula-metadata.md | Файл FORMULA (YAML) |
| 03-states-model.md | Состояния apply/clean (package, repository, security-baseline) |
| 04-pillar-and-tplroot.md | Pillar lookup, map.jinja, tplroot |
| 05-secrets.md | Секреты только через pillar |
| 07-os-specific-mapping.md | Astra→Debian, ALT→RedHat, Windows |
| 09-json-output-policy.md | Формат ответа ИИ (только JSON) |

## formula_kind (рендерер)

| kind | Назначение |
|------|------------|
| `package` (default) | Установка ПО: package + optional repository |
| `security-baseline` | Linux hardening: ssh, sysctl, services, packages + check/clean |

## Приоритет при конфликте

1. `12-repos-winrepo-pillar.md`
2. `11-json-spec-contract.md`
3. `01-structure` … `07-os-specific-mapping`
4. Примеры из `03-examples/finalized/`

Legacy-документы про bash/Python-сборщики **удалены** — не использовать.
