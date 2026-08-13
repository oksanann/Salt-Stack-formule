---
product: osmax
doc_type: salt-formula-checklist
title: Quality gates для bash-скрипта сборки
priority: 4
---

# Quality gates — bash-скрипт не должен создавать пустые файлы

## Перед отдачей скрипта ИИ проверяет сам

- [ ] Каждый `write_file` / heredoc содержит **полный текст файла**, не заглушку
- [ ] Нет файлов с только `# TODO`, `{# placeholder #}`, пустыми строками
- [ ] `init.sls` содержит `tplroot` и `include:`
- [ ] `package.sls` содержит реальное Salt-состояние (`pkg.installed`, `chocolatey.installed`, …)
- [ ] `map.jinja` содержит `grains.filter_by` и `merge=salt['pillar.get']`
- [ ] `FORMULA` содержит: name, os, os_family, version, release, summary, description, top_level_dir
- [ ] Heredoc для SLS использует `<<'EOF'` (quoted)
- [ ] В конце скрипта: `fail_if_empty` или `[[ -s file ]]` для каждого обязательного файла
- [ ] Скрипт завершается `exit 1` при пустом файле

## После запуска пользователь проверяет

```bash
find <name>-formula -type f -empty
# должно быть пусто (нет вывода)

grep -r 'TODO\|placeholder\|FIXME' <name>-formula || true
# не должно находить заглушки
```

## Если формула package+repo+Windows

Bash heredoc часто ломается. **Рекомендация:** переключиться на Python-сборщик.
