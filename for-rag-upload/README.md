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

## Формат ответа ИИ

Один **bash-скрипт**, который создаёт `<name>-formula/` со всеми файлами.

```bash
chmod +x create_<name>_formula.sh
./create_<name>_formula.sh
```

## Альтернативный режим

Python-сборщик: используй `prompts/system-prompt.txt` + `documents/01-rules/06-python-builder-output.md`.
