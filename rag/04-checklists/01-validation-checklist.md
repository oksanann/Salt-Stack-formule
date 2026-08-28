---
product: osmax
doc_type: salt-formula-checklist
title: Чеклист валидации формулы Осмакс
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/work-with-formulas/create-formula/
priority: 4
---

# Чеклист проверки сгенерированной формулы

Используйте после пайплайна: **ИИ → JSON → `render_formula.sh` → формула**.  
Если пункт не выполнен — формула не готова.

## Пайплайн (текущая реализация)

- [ ] ИИ вернул **только JSON** (не bash/Python и не список файлов)
- [ ] JSON валиден: `jq empty spec.json`
- [ ] Формула собрана: `./rag/tools/render_formula.sh --spec ./json-formula/<name>.json --out ./dist`
- [ ] Нет пустых файлов: `find <name>-formula -type f -empty` без вывода

## Структура

- [ ] Корень называется `<top_level_dir>-formula`
- [ ] Есть поддиректория `<top_level_dir>`
- [ ] Есть `init.sls`, `clean.sls`, `pillar.example`, `FORMULA`
- [ ] Рекомендуется: `map.jinja`, `docs/README.RST`
- [ ] При `with_repo=true`: есть `repository/` (init/install/clean + key при необходимости)
- [ ] При `with_repo=false`: каталога `repository/` нет
- [ ] Имена файлов/директорий: `[a-zA-Z0-9-_]+` (точки только в `.sls`)

## FORMULA

- [ ] `name` уникален
- [ ] `os` и `os_family` соответствуют реальной поддержке
- [ ] Astra → Debian, ALT → RedHat отражены в `os_family`
- [ ] `version` в формате `YYYYMM`
- [ ] `release`, `summary`, `description`, `top_level_dir` заполнены
- [ ] `top_level_dir` == имя поддиректории с SLS

## SLS / Jinja

- [ ] В каждом `.sls` есть `tplroot = tpldir.split('/')[0]`
- [ ] Параметры из `map.jinja` + `merge=pillar lookup`
- [ ] ID состояний уникальны, без точек, с префиксом имени формулы
- [ ] `init.sls` включает apply-путь; `clean.sls` — откат в обратном порядке

## Pillar / repo override

- [ ] `pillar.example` содержит `<formula-name>.lookup`
- [ ] При внешнем repo: документированы переопределяемые `repo.*`
- [ ] Можно задать другой repo/mirror через pillar (не только defaults map.jinja)
- [ ] Пустой `repo.name` означает «не импортировать внешний repo»
- [ ] URL в примерах — рабочие `https://` (см. `12-repos-winrepo-pillar.md`)
- [ ] Секреты только в lookup; в скрипты — через `args`

## Windows

- [ ] Если заявлена Windows — есть ветка в `map.jinja` / `windows.*` в lookup
- [ ] Default method: **`winrepo`** (`pkg.installed` + `winrepo_name`)
- [ ] Альтернативы `chocolatey` / `installer` только если явно запрошены
- [ ] Clean удаляет тем же методом
- [ ] Нет Linux-команд/путей в Windows-ветке

## Выбор шаблона

- [ ] Script → `tpl-script`; группы → `tpl-group-members`; ярлыки → `tpl-shortcut`
- [ ] Package/repo → finalized pattern (`google-chrome` / `yandex-browser` / `agent-update`)
- [ ] Не подогнана package-формула под `tpl-script`

## Идемпотентность и безопасность

- [ ] Повторный apply безопасен
- [ ] Нет хардкода паролей
- [ ] Нет деструктивных действий без явного требования
