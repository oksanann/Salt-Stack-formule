---
product: osmax
doc_type: salt-formula-rules
title: Маппинг ОС для JSON-спеки и рендерера
priority: 1
---

# Маппинг ОС (JSON spec + render_formula.sh)

## Цель

Единые правила ветвления для Linux и Windows при заполнении JSON (`os`, `os_family`, `map_defaults`) и при сборке формулы.

## Поддерживаемые семейства
- `Debian`: includes Astra Linux branch.
- `RedHat`: includes ALT Linux RPM branch.
- `Windows`: native Windows branch.

## Mapping rules
1. Astra Linux в запросе → в JSON `os_family` включает `Debian`.
2. ALT Linux в запросе → в JSON `os_family` включает `RedHat`.
3. Windows в запросе → `os_family` включает `Windows`, `os` включает `"windows"`.
4. Смешанные цели — одна формула, ветки в `map_defaults` (default + Debian + RedHat + Windows).

## Package logic by OS family
- Debian/Astra:
  - install required repo packages if configured;
  - install repo key if provided;
  - install target package with `pkg.installed`.
- RedHat/ALT:
  - install required repo packages if configured;
  - install repo key if provided;
  - install target package with `pkg.installed`;
  - for Yandex Browser prefer ALT baseurl `https://repo.yandex.ru/yandex-browser/alt/$basearch/` when targeting ALT.
- Windows:
  - **preferred:** `windows.method: winrepo` → `pkg.installed` with `windows.winrepo_name`;
  - alternatives: `chocolatey` (`chocolatey.installed`), `installer` (MSI/EXE via `file.managed` + `cmd.run`);
  - cleanup branch must uninstall via the same method and remove temporary installer artifacts if created.

## Repository behavior
- `with_repo=true` enables repository state chain for Linux families.
- Repository states are optional for Windows and should only be generated when explicitly needed.
- Defaults for `repo.*` live in `map.jinja`; **pillar `lookup.repo` may fully replace** name/key/file/comps (corporate mirror, offline mirror, ALT vs RPM URL).
- Empty `repo.name` means: do not import external repo.

## Pillar compatibility
- Always read user overrides from:
  - `<formula_name>:lookup`
- Keep branch-specific values under `lookup`, for example:
  - `repo.*` for Linux (overridable);
  - `windows.method` / `windows.winrepo_name` / `windows.chocolatey_name` for Windows.

## Required implementation guard

Сгенерированные SLS (рендерер) и примеры в RAG используют:

```jinja
{%- set tplroot = tpldir.split('/')[0] %}
```

Не хардкодить имя формулы в путях `salt://`.

See also: `12-repos-winrepo-pillar.md`, `11-json-spec-contract.md`.
