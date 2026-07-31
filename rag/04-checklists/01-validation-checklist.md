---
product: osmax
doc_type: salt-formula-checklist
title: Чеклист валидации формулы Осмакс
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/work-with-formulas/create-formula/
priority: 4
---

# Чеклист проверки сгенерированной формулы

Используйте после генерации формулы ИИ. Если пункт не выполнен — формула не готова.

## Структура

- [ ] Корень называется `<top_level_dir>-formula`
- [ ] Есть поддиректория `<top_level_dir>`
- [ ] Есть `init.sls`
- [ ] Есть `clean.sls`
- [ ] Есть `pillar.example`
- [ ] Есть `FORMULA`
- [ ] Имена файлов/директорий соответствуют `[a-zA-Z0-9-_]+` (точки только в `.sls`)

## FORMULA

- [ ] `name` уникален
- [ ] `os` и `os_family` заполнены и соответствуют реальной поддержке
- [ ] `version` в формате `YYYYMM`
- [ ] `release` указан
- [ ] `summary`, `description`, `top_level_dir` заполнены
- [ ] `top_level_dir` == имя поддиректории с SLS

## SLS / Jinja

- [ ] В каждом `.sls` есть `tplroot = tpldir.split('/')[0]`
- [ ] Параметры берутся из `map.jinja`
- [ ] `map.jinja` делает `merge=salt['pillar.get']('<name>:lookup')`
- [ ] ID состояний уникальны и без точек
- [ ] ID имеют префикс имени формулы
- [ ] `init.sls` включает нужные состояния apply
- [ ] `clean.sls` откатывает apply в обратном порядке

## Pillar

- [ ] `pillar.example` отражает ключ `<formula-name>.lookup`
- [ ] Секреты только в lookup
- [ ] Секреты в скрипты передаются через `args`

## Платформы

- [ ] Linux-ветки не содержат Windows-команд и наоборот
- [ ] Пути/shell для Windows заданы отдельно (если заявлена поддержка Windows)
- [ ] FORMULA не заявляет ОС, которые формула не поддерживает

## Идемпотентность и безопасность

- [ ] Повторный apply безопасен (`unless`/`onlyif` или declarative state)
- [ ] Нет хардкода паролей
- [ ] Нет деструктивных действий без явного требования
