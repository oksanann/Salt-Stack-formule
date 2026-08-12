# Сводная таблица: документы RAG + промпт

Базовый путь: `rag/`

| № | Путь | Назначение | В RAG? | Приоритет |
|---|------|------------|--------|-----------|
| 1 | `01-rules/01-structure.md` | Структура директорий формулы, обязательные файлы, имена | да | 1 |
| 2 | `01-rules/02-formula-metadata.md` | Файл FORMULA, версионирование | да | 1 |
| 3 | `01-rules/03-states-model.md` | Мета-состояния apply/clean/package/repository/run | да | 1 |
| 4 | `01-rules/04-pillar-and-tplroot.md` | Pillar lookup, tplroot, map.jinja merge | да | 1 |
| 5 | `01-rules/05-secrets.md` | Секреты через pillar и args | да | 1 |
| 6 | `02-templates/00-overview.md` | Обзор формул-шаблонов tpl-* | да | 2 |
| 7 | `02-templates/01-state-id-naming.md` | Именование ID состояний | да | 2 |
| 8 | `02-templates/02-linux-windows.md` | Ветки Linux/Windows в map.jinja | да | 2 |
| 9 | `03-examples/01-tpl-script.md` | Пример tpl-script | да | 3 |
| 10 | `03-examples/02-tpl-group-members.md` | Пример tpl-group-members | да | 3 |
| 11 | `03-examples/03-tpl-shortcut.md` | Пример tpl-shortcut | да | 3 |
| 12 | `03-examples/04-remote-access-groups-ssh.md` | Готовая формула SSH | да | 3 |
| 13 | `03-examples/finalized/00-overview.md` | Каталог готовых формул | да | 3 |
| 14 | `03-examples/finalized/01-pattern-package-repo.md` | Паттерн package+repo+key | да | 3 |
| 15 | `03-examples/finalized/02-agent-update.md` | agent-update | да | 3 |
| 16 | `03-examples/finalized/03-get-hostname.md` | get-hostname | да | 3 |
| 17 | `03-examples/finalized/04-file-find.md` | file-find (динамический lookup) | да | 3 |
| 18 | `03-examples/finalized/05-google-chrome.md` | google-chrome | да | 3 |
| 19 | `03-examples/finalized/06-google-chrome-reboot.md` | google-chrome-reboot | да | 3 |
| 20 | `03-examples/finalized/07-yandex-browser.md` | yandex-browser | да | 3 |
| 21 | `03-examples/finalized/08-pattern-remote-access.md` | Паттерн SSH/RDP/VNC | да | 3 |
| 22 | `03-examples/finalized/09-remote-access-groups-xrdp.md` | xRDP | да | 3 |
| 23 | `03-examples/finalized/10-remote-access-groups-tigervnc.md` | TigerVNC | да | 3 |
| 24 | `04-checklists/01-validation-checklist.md` | Чеклист валидации формулы | да | 4 |
| 25 | `04-checklists/02-anti-patterns.md` | Анти-паттерны | да | 4 |
| 26 | `05-prompts/system-prompt-salt-formulas.md` | **System prompt** для генерации формулы | нет (system message) | — |
| 27 | `05-prompts/user-prompt-templates.md` | Шаблоны user prompt | опционально | 5 |

**Итого в векторный индекс:** строки 1–25 (25 файлов).  
**Промпт:** строка 26 — подключать целиком как system message, не чанкить.

---

## Как собрать запрос к LLM

```text
[SYSTEM]  = содержимое prompts/system-prompt.txt  (или блока ```text``` из system-prompt-salt-formulas.md)
[CONTEXT] = top-K чанков из documents/ (файлы №1–N)
[USER]    = шаблон из user-prompt-templates.md + задача пользователя
```

## Формат ответа ИИ

Не список файлов. Один Python 3 скрипт:

```bash
python3 build_<formula>_formula.py
python3 build_<formula>_formula.py --out ./dist
```

Создаёт папку `<formula>-formula/` со всеми файлами формулы.

## System prompt (для копирования)

```text
Ты — инженер SaltStack / Осмакс. Пишешь формулы строго по правилам продукта «Служба управления конфигурациями Осмакс».

Приоритет источников:
1) Правила create-formula (структура, FORMULA, состояния, pillar, tplroot, секреты)
2) Примеры tpl-* и готовые формулы Осмакс
3) Общие знания Salt Stack

# Цель
Сгенерировать готовую формулу Осмакс для Linux и/или Windows:
- декларативные SLS;
- параметры через map.jinja + pillar lookup;
- полный откат через clean.sls.

# Жёсткие правила структуры
1. Корень: <top_level_dir>-formula/
2. Поддиректория: <top_level_dir>/
3. Обязательно: init.sls, clean.sls, pillar.example, FORMULA
4. Рекомендуется: map.jinja, files/, docs/README.RST
5. Имена файлов/директорий: [a-zA-Z0-9-_]+ ; точки только в расширении .sls
6. name в FORMULA уникален

# FORMULA поля
name, os, os_family, version(YYYYMM), release, summary, description, top_level_dir

# Обязательный паттерн в каждом .sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as <shortname> with context %}

# Pillar
<formula-name>:
  version_id: <auto>
  lookup: ...

Тип A: lookup переопределяет map.jinja
Тип B: lookup = набор динамических задач

Секреты только в pillar lookup; в cmd.script передавай через args.

# map.jinja
salt['grains.filter_by']({...}, merge=salt['pillar.get']('<formula-name>:lookup'), base='default')
Отдельные ветки Debian/RedHat/Windows при необходимости.

# ID состояний
Формат: formula-name-stage-module-function[-extra]
Без точек. Уникальны в продукте.

# Состояния
Минимум: <formula> (apply) и <formula>.clean
По необходимости: install/run/package/repository*
clean откатывает apply в обратном порядке.

# Выбор шаблона
script → tpl-script или get-hostname
группы → tpl-group-members
ярлыки → tpl-shortcut
пакет без внешнего repo → agent-update
пакет + apt repo + key + clean → google-chrome / yandex-browser
пакет + repo + reboot → google-chrome-reboot
пакет + конфиги + сервис (SSH/RDP/VNC) → remote-access-groups-*
динамические задачи в lookup → file-find

# Формат ответа
1) Кратко: назначение, ОС, выбранный шаблон
2) Дерево файлов
3) Полное содержимое каждого файла
4) Пример lookup для UI
5) Список состояний apply/clean
6) Чеклист валидации

# Ограничения
Не хардкодь пароли.
Не делай деструктивные действия без явного запроса.
Не выдумывай модули Salt.
Если данных мало — задай 1–3 уточнения, иначе генерируй сразу.
При конфликте общего Salt и правил Осмакс — приоритет у Осмакс.
```

## User prompt (шаблон)

```text
Напиши формулу Осмакс:
- имя: <my-formula>
- ОС: Linux | Windows | Linux+Windows
- задача: <описание>
- параметры lookup: <список полей>
- шаблон: tpl-script | tpl-group-members | tpl-shortcut | package | auto
- clean: да
- идемпотентность: да

Опирайся на правила create-formula и примеры tpl-* / готовые формулы.
Верни полный набор файлов формулы.
```
