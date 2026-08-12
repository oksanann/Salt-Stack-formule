# Сводная таблица: документы RAG + промпты

Базовый путь: `documents/`  
Полная инструкция: **UPLOAD-PACK.md**

## Документы для RAG (32 файла)

| № | Путь | Назначение | Приоритет |
|---|------|------------|-----------|
| 1 | `01-rules/01-structure.md` | Структура директорий, обязательные файлы | 1 |
| 2 | `01-rules/02-formula-metadata.md` | Файл FORMULA, версионирование | 1 |
| 3 | `01-rules/03-states-model.md` | Мета-состояния apply/clean/package/repository | 1 |
| 4 | `01-rules/04-pillar-and-tplroot.md` | Pillar lookup, tplroot, map.jinja | 1 |
| 5 | `01-rules/05-secrets.md` | Секреты через pillar и args | 1 |
| 6 | `01-rules/07-os-specific-mapping.md` | Astra→Debian, ALT→RedHat, Windows | 1 |
| 7 | `01-rules/08-bash-generator-contract.md` | Контракт bash-генератора | 1 |
| 8 | `01-rules/09-output-format-policy.md` | Формат ответа ИИ | 1 |
| 9 | `01-rules/06-python-builder-output.md` | Python-сборщик (legacy) | 1 |
| 10 | `02-templates/00-overview.md` | Обзор tpl-* | 2 |
| 11 | `02-templates/01-state-id-naming.md` | Именование ID состояний | 2 |
| 12 | `02-templates/02-linux-windows.md` | Ветки Linux/Windows | 2 |
| 13 | `03-examples/finalized/00-overview.md` | Каталог готовых формул | 3 |
| 14 | `03-examples/finalized/01-pattern-package-repo.md` | Паттерн package+repo+key | 3 |
| 15 | `03-examples/finalized/07-yandex-browser.md` | yandex-browser ★ | 3 |
| 16 | `03-examples/finalized/05-google-chrome.md` | google-chrome | 3 |
| 17 | `03-examples/finalized/06-google-chrome-reboot.md` | google-chrome-reboot | 3 |
| 18 | `03-examples/finalized/02-agent-update.md` | agent-update | 3 |
| 19 | `03-examples/finalized/03-get-hostname.md` | get-hostname | 3 |
| 20 | `03-examples/finalized/04-file-find.md` | file-find | 3 |
| 21 | `03-examples/finalized/08-pattern-remote-access.md` | Паттерн SSH/RDP/VNC | 3 |
| 22 | `03-examples/finalized/09-remote-access-groups-xrdp.md` | xRDP | 3 |
| 23 | `03-examples/finalized/10-remote-access-groups-tigervnc.md` | TigerVNC | 3 |
| 24 | `03-examples/01-tpl-script.md` | tpl-script | 3 |
| 25 | `03-examples/02-tpl-group-members.md` | tpl-group-members | 3 |
| 26 | `03-examples/03-tpl-shortcut.md` | tpl-shortcut | 3 |
| 27 | `03-examples/04-remote-access-groups-ssh.md` | SSH | 3 |
| 28 | `04-checklists/01-validation-checklist.md` | Валидация формулы | 4 |
| 29 | `04-checklists/02-anti-patterns.md` | Анти-паттерны | 4 |
| 30 | `04-checklists/03-generation-flow.md` | Flow генерации | 4 |
| 31 | `04-checklists/04-preflight-inputs.md` | Preflight входных данных | 4 |
| 32 | `04-checklists/05-postgen-smoke-test.md` | Smoke-test после скрипта | 4 |

## Промпты (не в RAG)

| Файл | Назначение |
|------|------------|
| `prompts/system-prompt-bash-generator.txt` | **System message (рекомендуется)** |
| `prompts/system-prompt-salt-formulas-v2.md` | System message (markdown) |
| `prompts/system-prompt.txt` | System message (Python, legacy) |
| `prompts/user-prompt-yandex-browser.md` | User: Яндекс Браузер |
| `prompts/user-prompt-short-template.md` | User: короткий шаблон |
| `prompts/user-prompt-templates.md` | User: расширенные шаблоны |

---

## Как собрать запрос к LLM

```text
[SYSTEM]  = prompts/system-prompt-bash-generator.txt
[CONTEXT] = top-K чанков из documents/
[USER]    = шаблон из prompts/ + задача пользователя
```

## Формат ответа ИИ

Один bash-скрипт:

```bash
chmod +x create_<formula>_formula.sh
./create_<formula>_formula.sh
```

Создаёт `<formula>-formula/` со всеми файлами формулы.

## Smoke-test

```text
Сгенерируй bash-скрипт для Salt-формулы yandex-browser:
Astra Linux, ALT Linux, Windows, with_repo=true.
```

Проверь: один блок bash, init.sls + clean.sls + FORMULA + pillar.example, tplroot, self-check.
