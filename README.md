# RAG-корпус: формулы Salt для Осмакс

## Папки

| Папка | Назначение |
|-------|------------|
| `rag/` | Единственный RAG-пакет: правила, примеры, чеклисты, prompts, renderer |
| `json-formula/` | JSON-спецификации созданных формул |
| `dist/` | Собранные формулы (`*-formula/`) из JSON |

## Быстрый старт

1. Загрузить в RAG документы из `rag/` по `rag/UPLOAD-ORDER.txt`
2. System prompt: `rag/05-prompts/system-prompt-json-spec.txt`
3. Сохранить JSON ИИ в `json-formula/<name>.json`
4. Собрать формулу:

```bash
./rag/tools/render_formula.sh --spec ./json-formula/<name>.json --out ./dist
```

Подробнее: [rag/README.md](rag/README.md), [rag/UPLOAD-PACK.md](rag/UPLOAD-PACK.md).
