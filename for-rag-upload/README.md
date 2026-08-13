# Пакет для загрузки в RAG

Готовый upload pack для ИИ-чата с RAG: генерация **bash-скриптов**, создающих Salt-формулы Осмакс.

## С чего начать

1. Открой **UPLOAD-PACK.md** — полная инструкция.
2. Загрузи файлы из **UPLOAD-ORDER.txt** в RAG (32 документа).
3. Вставь **prompts/system-prompt-bash-generator.txt** как system message.
4. Протестируй запросом из **prompts/user-prompt-yandex-browser.md**.

## Структура

```
for-rag-upload/
├── UPLOAD-PACK.md              ← главная инструкция
├── UPLOAD-ORDER.txt            ← порядок batch-upload
├── MANIFEST.md                 ← inventory
├── metadata.json               ← для автоматического индексатора
├── documents/                  ← ЗАГРУЗИТЬ В RAG (32 файла)
└── prompts/                    ← НЕ индексировать
    ├── system-prompt-bash-generator.txt   ← system message ★
    ├── system-prompt-salt-formulas-v2.md
    ├── system-prompt.txt                  ← Python-режим (legacy)
    ├── user-prompt-yandex-browser.md
    ├── user-prompt-short-template.md
    └── user-prompt-templates.md
```

## Счётчики

| Категория | Кол-во |
|-----------|--------|
| Документы для RAG | 32 |
| System prompts | 3 |
| User prompt templates | 3 |

## Рекомендуемый режим: JSON → bash-рендерер

1. System prompt: `prompts/system-prompt-json-spec.txt`
2. ИИ возвращает только JSON-спецификацию
3. Сборка формулы:

```bash
# сохранить JSON из чата в spec.json
./tools/render_formula.sh --spec ./spec.json --out ./dist
```

Примеры JSON: `examples/specs/nginx.json`, `examples/specs/yandex-browser.json`  
Контракт: `documents/01-rules/11-json-spec-contract.md`

## Legacy-режимы

- Bash от ИИ: `prompts/system-prompt-bash-generator.txt` (часто ломается)
- Python-сборщик: `prompts/system-prompt.txt`
