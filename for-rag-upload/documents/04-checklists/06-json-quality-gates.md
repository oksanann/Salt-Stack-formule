---
product: osmax
doc_type: salt-formula-checklist
title: Quality gates for JSON spec + renderer
priority: 4
---

# Quality gates — JSON + render_formula.sh

Основной режим. ИИ не пишет файлы формулы напрямую.

## JSON от ИИ

- [ ] Один блок ```json, парсится (`jq empty`)
- [ ] Обязательные поля: name, top_level_dir, os, os_family, summary, description, with_repo, pillar_lookup, map_defaults
- [ ] `map_defaults` содержит `default` и ветки для каждого `os_family`
- [ ] `with_repo=true` ⇒ есть `repo` в pillar_lookup и/или map_defaults
- [ ] Windows ⇒ `windows.method` (default **winrepo**) и `winrepo_name`
- [ ] Repo URL — рабочие https (Yandex: `.../deb stable main`, comps=`main`)
- [ ] Нет TODO / placeholder / example.com в боевых URL без пометки

## После render_formula.sh

```bash
./tools/render_formula.sh --spec ./spec.json --out ./dist
find dist/<name>-formula -type f -empty
# пусто = OK
```

- [ ] Обязательные файлы существуют и **не пустые**
- [ ] `FORMULA` содержит name/os/os_family/version/top_level_dir
- [ ] SLS содержат `tplroot`
- [ ] package содержит реальное состояние (`pkg.installed` / winrepo / chocolatey)
- [ ] repository присутствует только при `with_repo=true`

## Legacy: bash от ИИ

Не рекомендуется. Если всё же bash:
- использовать `write_file` + `fail_if_empty` (`10-bash-generator-reference.md`);
- для package+repo+Windows лучше JSON+renderer или Python-сборщик.

См. также: `11-json-spec-contract.md`, `12-repos-winrepo-pillar.md`.
