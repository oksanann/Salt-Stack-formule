# Upload Pack: Salt Formula Generator (RAG + Prompts)

Единый пакет для загрузки в ИИ-чат с RAG.  
Путь на диске: `for-rag-upload/`

---

## Быстрый старт (рекомендуется: JSON → рендерер)

| Шаг | Действие | Файл / папка |
|-----|----------|--------------|
| 1 | Загрузить в RAG всё из `documents/` (+ `11-json-spec-contract.md`) | `UPLOAD-ORDER.txt` |
| 2 | System prompt | `prompts/system-prompt-json-spec.txt` |
| 3 | User prompt → получить JSON | `prompts/user-prompt-json-yandex-browser.md` |
| 4 | Сохранить ответ в `spec.json` | |
| 5 | Собрать формулу | `./tools/render_formula.sh --spec ./spec.json --out ./dist` |

Примеры JSON: `examples/specs/nginx.json`, `examples/specs/yandex-browser.json`  
Контракт: `documents/01-rules/11-json-spec-contract.md`

**Формат ответа ИИ:** только JSON. Bash пишет **фиксированный** `tools/render_formula.sh` (не ИИ).

### Legacy (ИИ пишет bash сам) — не рекомендуется

System prompt: `prompts/system-prompt-bash-generator.txt` — часто даёт пустые файлы / битый heredoc.

---

## Что куда загружать

```
for-rag-upload/
├── UPLOAD-PACK.md          ← этот файл (инструкция, не в RAG)
├── UPLOAD-ORDER.txt        ← плоский список для batch-upload
├── MANIFEST.md             ← inventory с метаданными
├── metadata.json           ← для автоматического индексатора
├── documents/              ← ЗАГРУЗИТЬ В RAG (31 файл)
└── prompts/                ← НЕ индексировать как обычные чанки
    ├── system-prompt-bash-generator.txt   ← system message (рекомендуется)
    ├── system-prompt-salt-formulas-v2.md
    ├── user-prompt-yandex-browser.md
    └── user-prompt-short-template.md
```

---

## Порядок загрузки (31 файл)

Загружайте **строго в этом порядке** — так RAG получит контекст от правил к примерам.

### Блок 1 — Правила (priority 1, загрузить первыми)

| № | Файл | Назначение |
|---|------|------------|
| 1 | `documents/01-rules/01-structure.md` | Структура директорий, обязательные файлы |
| 2 | `documents/01-rules/02-formula-metadata.md` | Файл FORMULA, версионирование |
| 3 | `documents/01-rules/03-states-model.md` | Мета-состояния apply/clean/package/repository |
| 4 | `documents/01-rules/04-pillar-and-tplroot.md` | Pillar lookup, tplroot, map.jinja |
| 5 | `documents/01-rules/05-secrets.md` | Секреты через pillar и args |
| 6 | `documents/01-rules/07-os-specific-mapping.md` | Astra→Debian, ALT→RedHat, Windows |
| 7 | `documents/01-rules/08-bash-generator-contract.md` | Контракт bash-генератора |
| 8 | `documents/01-rules/09-output-format-policy.md` | Формат ответа ИИ |
| 9 | `documents/01-rules/10-bash-generator-reference.md` | **Эталон рабочего bash-скрипта** |
| 10 | `documents/01-rules/06-python-builder-output.md` | Python-сборщик (для сложных формул) |

### Блок 2 — Шаблоны (priority 2)

| № | Файл | Назначение |
|---|------|------------|
| 10 | `documents/02-templates/00-overview.md` | Обзор формул-шаблонов tpl-* |
| 11 | `documents/02-templates/01-state-id-naming.md` | Именование ID состояний |
| 12 | `documents/02-templates/02-linux-windows.md` | Ветки Linux/Windows в map.jinja |

### Блок 3 — Примеры (priority 3)

| № | Файл | Назначение |
|---|------|------------|
| 13 | `documents/03-examples/finalized/00-overview.md` | Каталог готовых формул |
| 14 | `documents/03-examples/finalized/01-pattern-package-repo.md` | Паттерн package+repo+key |
| 15 | `documents/03-examples/finalized/07-yandex-browser.md` | **Эталон для браузеров** |
| 16 | `documents/03-examples/finalized/05-google-chrome.md` | google-chrome |
| 17 | `documents/03-examples/finalized/06-google-chrome-reboot.md` | google-chrome-reboot |
| 18 | `documents/03-examples/finalized/02-agent-update.md` | agent-update |
| 19 | `documents/03-examples/finalized/03-get-hostname.md` | get-hostname |
| 20 | `documents/03-examples/finalized/04-file-find.md` | file-find (динамический lookup) |
| 21 | `documents/03-examples/finalized/08-pattern-remote-access.md` | Паттерн SSH/RDP/VNC |
| 22 | `documents/03-examples/finalized/09-remote-access-groups-xrdp.md` | xRDP |
| 23 | `documents/03-examples/finalized/10-remote-access-groups-tigervnc.md` | TigerVNC |
| 24 | `documents/03-examples/01-tpl-script.md` | tpl-script |
| 25 | `documents/03-examples/02-tpl-group-members.md` | tpl-group-members |
| 26 | `documents/03-examples/03-tpl-shortcut.md` | tpl-shortcut |
| 27 | `documents/03-examples/04-remote-access-groups-ssh.md` | remote-access-groups-ssh |

### Блок 4 — Чеклисты (priority 4, загрузить последними)

| № | Файл | Назначение |
|---|------|------------|
| 28 | `documents/04-checklists/01-validation-checklist.md` | Валидация формулы |
| 29 | `documents/04-checklists/02-anti-patterns.md` | Анти-паттерны |
| 30 | `documents/04-checklists/03-generation-flow.md` | Flow генерации |
| 31 | `documents/04-checklists/04-preflight-inputs.md` | Preflight входных данных |
| 32 | `documents/04-checklists/05-postgen-smoke-test.md` | Smoke-test после запуска скрипта |
| 33 | `documents/04-checklists/06-bash-quality-gates.md` | Запрет пустых файлов |

> **Итого в RAG:** 33 файла.

---

## Если ИИ генерирует плохой bash (пустые файлы / ошибки)

1. Обнови **system prompt** → `prompts/system-prompt-bash-generator.txt`
2. Перезагрузи в RAG с высоким приоритетом:
   - `10-bash-generator-reference.md`
   - `06-bash-quality-gates.md`
3. В user prompt добавь:
   ```text
   Используй паттерн write_file из 10-bash-generator-reference.md.
   Запрещены пустые файлы и TODO. Self-check: fail_if_empty.
   ```
4. Для сложных формул (repo + Windows) — попроси **Python**:
   ```text
   Сгенерируй Python build_*_formula.py, не bash.
   ```
5. Проверь эталон: `examples/reference_build_nginx_formula.sh`

---

## Настройки RAG

### Chunking

| Параметр | Значение |
|----------|----------|
| Размер чанка | 500–800 токенов |
| Overlap | 100–150 токенов |
| Стратегия | по заголовкам H2/H3 |

**Не чанкить целиком** (если платформа позволяет):
- `08-bash-generator-contract.md`
- `09-output-format-policy.md`

### Retrieval

```text
filter:  product = "osmax"
         AND doc_type IN ("salt-formula-rules", "salt-formula-example", "salt-formula-checklist")
boost:   priority ASC  (1 = highest)
top_k:   6–8
```

### Boost по типу запроса

| Запрос пользователя | Дополнительный boost |
|---------------------|----------------------|
| Браузер / repo / key | `finalized/01-pattern-package-repo`, `07-yandex-browser`, `05-google-chrome` |
| SSH / RDP / VNC | `finalized/08-pattern-remote-access`, `09-*`, `10-*` |
| Скрипт / service | `03-get-hostname`, `01-tpl-script` |
| Динамические задачи | `04-file-find` |
| Astra / ALT / Windows | `07-os-specific-mapping`, `02-linux-windows` |
| Bash-скрипт сборки | `08-bash-generator-contract`, `09-output-format-policy` |

---

## System prompt

**Рекомендуется:** скопировать целиком в system message:

```
prompts/system-prompt-bash-generator.txt
```

**Не индексировать** system prompt в RAG — подключать отдельно.

Альтернативы:
- `prompts/system-prompt-salt-formulas-v2.md` — то же, с markdown-разметкой
- `prompts/system-prompt.txt` — режим Python-сборщика (legacy)

---

## User prompts (шаблоны)

| Файл | Когда использовать |
|------|-------------------|
| `prompts/user-prompt-yandex-browser.md` | Яндекс Браузер на Astra/ALT/Windows |
| `prompts/user-prompt-short-template.md` | Любая формула (заполнить плейсхолдеры) |
| `prompts/user-prompt-templates.md` | Расширенные шаблоны (legacy) |

### Пример минимального user prompt

```text
Сгенерируй bash-скрипт для Salt-формулы:
- name: nginx
- ОС: Astra Linux, ALT Linux
- with_repo: false
- summary: Установка nginx
- description: Формула установки nginx без внешнего репозитория
```

---

## Сборка запроса к LLM

```text
[SYSTEM]  = prompts/system-prompt-bash-generator.txt
[CONTEXT] = top-K чанков из documents/ (retrieval по user query)
[USER]    = шаблон из prompts/ + задача пользователя
```

---

## Ожидаемый результат

1. ИИ возвращает **один bash-скрипт** в блоке ` ```bash `.
2. Пользователь сохраняет и запускает:

```bash
chmod +x create_<name>_formula.sh
./create_<name>_formula.sh
```

3. Создаётся структура:

```text
<name>-formula/
├── FORMULA
├── pillar.example
├── docs/README.RST
└── <name>/
    ├── init.sls
    ├── clean.sls
    ├── map.jinja
    ├── package.sls
    └── ...
```

4. Проверка по чеклисту: `documents/04-checklists/05-postgen-smoke-test.md`

---

## Smoke-test после настройки RAG

Отправьте в чат:

```text
Сгенерируй bash-скрипт для Salt-формулы yandex-browser:
Astra Linux, ALT Linux, Windows, with_repo=true.
```

Проверьте ответ:
- [ ] Один блок `bash`, не список SLS-файлов
- [ ] `#!/usr/bin/env bash` и `set -euo pipefail`
- [ ] Создаёт `<name>-formula/` с init.sls, clean.sls, FORMULA, pillar.example
- [ ] Есть `tplroot` в шаблонах
- [ ] FORMULA содержит os_family: Debian, RedHat, Windows
- [ ] В конце скрипта — self-check

---

## Связанные файлы

| Файл | Описание |
|------|----------|
| `UPLOAD-ORDER.txt` | Плоский список путей для batch-upload |
| `MANIFEST.md` | Полный inventory с chunk_hint |
| `metadata.json` | Метаданные для автоматического индексатора |
| `SUMMARY-RAG-AND-PROMPT.md` | Сводная таблица всех документов |

---

## Внешние ссылки (опционально в RAG)

- [Принципы написания формулы](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/work-with-formulas/create-formula/)
- [Готовые формулы](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/finalized-formulas-overview/)
