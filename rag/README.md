# Пакет RAG: формулы Salt для Осмакс

Единственная папка для загрузки в RAG и работы с генерацией формул.

## Быстрый старт (JSON → формула)

| Шаг | Действие |
|-----|----------|
| 1 | Загрузить в RAG содержимое `01-rules/`, `02-templates/`, `03-examples/`, `04-checklists/` |
| 2 | System prompt: `05-prompts/system-prompt-json-spec.txt` |
| 3 | Сохранить JSON в `../json-formula/<name>.json` |
| 4 | Собрать: `./rag/tools/render_formula.sh --spec ./json-formula/<name>.json --out ../dist` |

Примеры JSON: `examples/specs/`  
Контракт: `01-rules/11-json-spec-contract.md`

## Структура

```text
rag/
├── 01-rules/          ← правила JSON-first (приоритет 1, см. 00-overview.md)
├── 02-templates/      ← tpl-* и Linux/Windows
├── 03-examples/       ← few-shot примеры
├── 04-checklists/     ← валидация
├── 05-prompts/        ← system/user prompts, только JSON-first (не в RAG)
│   ├── README.md
│   ├── system-prompt-json-spec.txt
│   └── user-prompt-*.md
├── examples/specs/    ← эталонные JSON
├── tools/
│   └── render_formula.sh
├── UPLOAD-ORDER.txt
├── UPLOAD-PACK.md
├── MANIFEST.md
└── README.md
```

JSON рабочих формул храните в `../json-formula/`.
