# Промпты (05-prompts)

**Только JSON-first.** Legacy bash/Python промпты удалены.

## System prompt (вставить в чат)

| Файл | Назначение |
|------|------------|
| **`system-prompt-json-spec.txt`** | Единственный system message |

## User prompts (примеры запросов)

| Файл | Назначение |
|------|------------|
| `user-prompt-short-template.md` | Короткий шаблон для любой формулы |
| `user-prompt-templates.md` | Шаблоны: package, tpl-*, кроссплатформа |
| `user-prompt-yandex-browser.md` | Пример: Яндекс Браузер + repo + Windows |

## После ответа ИИ

1. Сохранить JSON в `json-formula/<name>.json` (UTF-8)
2. `./rag/tools/render_formula.sh --spec ./json-formula/<name>.json --out ./dist`

Промпты **не загружаются в RAG** — только system message отдельно.
