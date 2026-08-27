# Upload Pack: Salt Formula Generator (RAG)

Единый пакет в папке `rag/`.

## Быстрый старт (JSON → рендерер)

| Шаг | Действие | Файл |
|-----|----------|------|
| 1 | Загрузить документы по `UPLOAD-ORDER.txt` | `01-rules` … `04-checklists` |
| 2 | System prompt | `05-prompts/system-prompt-json-spec.txt` |
| 3 | Получить JSON от ИИ → сохранить | `../json-formula/<name>.json` |
| 4 | Собрать формулу | `./rag/tools/render_formula.sh --spec ./json-formula/<name>.json --out ../dist` |

Контракт: `01-rules/11-json-spec-contract.md`  
Winrepo / repo URLs: `01-rules/12-repos-winrepo-pillar.md`  
Примеры JSON: `examples/specs/`

## Что куда

- **В RAG:** `01-rules/`, `02-templates/`, `03-examples/`, `04-checklists/`
- **Не в RAG:** `05-prompts/` (system message отдельно)
- **JSON формул:** `../json-formula/`
- **Собранные формулы:** `../dist/`

## Chunking

- 500–800 токенов, overlap 100–150
- `11-json-spec-contract.md`, `12-repos-winrepo-pillar.md` — по возможности не дробить
