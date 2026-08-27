---
product: osmax
doc_type: salt-formula-checklist
title: Post-generation smoke test
priority: 4
---

# Post-generation smoke test

Run **after** `render_formula.sh` (not after inventing files by hand).

```bash
./tools/render_formula.sh --spec ./spec.json --out ./dist
find ./dist/<name>-formula -type f -empty   # must be empty output
jq empty ./spec.json
```

## Directory checks
- `<name>-formula/` exists
- `<name>-formula/<name>/` exists

## Mandatory file checks
- `FORMULA`
- `pillar.example`
- `<name>/init.sls`
- `<name>/clean.sls`
- `<name>/map.jinja` (recommended / expected from renderer)
- `docs/README.RST` (recommended)

## with_repo checks
- `with_repo=true` → `repository/` present (install/clean/key as needed)
- `with_repo=false` → no `repository/` directory

## Metadata checks (FORMULA)
- `name`, `os`, `os_family`, `version`, `release`, `summary`, `description`, `top_level_dir`

## State checks
- `init.sls` includes install path (`.package`, and `.repository` on Linux when with_repo)
- `clean.sls` includes rollback path
- package states use real Salt modules (`pkg.installed` / winrepo / chocolatey if chosen)

## Pillar / Windows checks
- `pillar.example` contains `lookup`
- Linux with external repo: `repo.*` present and overridable
- Windows: `windows.method` (+ `winrepo_name` for winrepo)
- Repo URLs use `https://` where official sources support it

## Content quality
- No empty files
- No `TODO` / `placeholder` stubs in SLS
- `tplroot` present in generated SLS
