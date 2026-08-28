---
product: osmax
doc_type: salt-formula-rules
title: Формат ответа ИИ — только JSON
priority: 1
chunk: none
---

# Политика формата ответа ИИ (JSON-first)

## Ожидаемый выход

По запросу на создание формулы ИИ возвращает **только JSON-спецификацию** по `11-json-spec-contract.md`.

Сборку выполняет человек или CI:

```bash
./rag/tools/render_formula.sh --spec ./json-formula/<name>.json --out ./dist
```

## Формат ответа в чате

1. Одно короткое предложение (имя формулы и ОС).
2. Ровно один блок ` ```json ` с полной спецификацией.
3. Команда рендера (см. выше).

## Запрещено

- Bash-скрипты, Python-скрипты (`build_*_formula.py`), shell one-liner для сборки.
- Списки файлов формулы (SLS, FORMULA, map.jinja) вне JSON.
- Несколько вариантов JSON в одном ответе.
- Пустой JSON, TODO, placeholder URL без пометки.
- Markdown внутри JSON.

## Если данных не хватает

Задай **один** короткий уточняющий вопрос (name, ОС, with_repo).  
Не переключайся на другой формат ответа (bash/Python/файлы).

## Локализация

- `summary`, `description` — на русском, если пользователь пишет по-русски.
- Ключи JSON, `name`, `top_level_dir`, идентификаторы — ASCII, regex `^[a-zA-Z0-9_-]+$`.

## Связанные документы

- Контракт: `11-json-spec-contract.md`
- Winrepo / repo: `12-repos-winrepo-pillar.md`
- System prompt: `05-prompts/system-prompt-json-spec.txt`
