# Пакет для загрузки в RAG

Папка готова к передаче в RAG/индексатор.

## Структура

```
for-rag-upload/
  documents/     ← загрузить в векторную БД (25 файлов)
  prompts/       ← НЕ индексировать как обычные чанки
    system-prompt.txt              ← чистый system prompt для LLM
    system-prompt-salt-formulas.md ← то же + пояснения
    user-prompt-templates.md       ← шаблоны запросов пользователя
  MANIFEST.md
  metadata.json
  SUMMARY-RAG-AND-PROMPT.md
```

## Что делать

1. **В RAG** загрузите всё из `documents/`.
2. **В LLM** подключайте `prompts/system-prompt.txt` как system message.
3. Перед генерацией подставляйте retrieved-контекст из `documents/` + user prompt из `prompts/user-prompt-templates.md`.

## Счётчики

- Документы для индекса: **25**
- Промпты: **3** (включая `.txt`)
