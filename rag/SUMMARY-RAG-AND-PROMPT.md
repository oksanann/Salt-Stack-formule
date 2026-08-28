# Сводная таблица: RAG + промпты

Базовый путь: `rag/`

## Документы для RAG

См. `UPLOAD-ORDER.txt` и `MANIFEST.md`.

Основные блоки:
1. `01-rules/` — структура, pillar, repo/winrepo, JSON-контракт
2. `02-templates/` — tpl-* и Linux/Windows
3. `03-examples/` — tpl-* и finalized
4. `04-checklists/` — валидация JSON-first

## Промпты (не в RAG)

| Файл | Назначение |
|------|------------|
| **`05-prompts/system-prompt-json-spec.txt`** | System message (единственный) |
| `05-prompts/user-prompt-yandex-browser.md` | User: Яндекс Браузер |
| `05-prompts/user-prompt-templates.md` | User: шаблоны запросов |
| `05-prompts/user-prompt-short-template.md` | User: короткий шаблон |

## Пайплайн

```text
[SYSTEM]  = 05-prompts/system-prompt-json-spec.txt
[CONTEXT] = top-K из 01–04
[USER]    = задача
→ JSON → json-formula/<name>.json
→ ./rag/tools/render_formula.sh --spec ./json-formula/<name>.json --out ./dist
```
