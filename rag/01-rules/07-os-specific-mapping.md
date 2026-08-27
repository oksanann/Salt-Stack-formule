---
product: osmax
doc_type: salt-formula-rules
title: OS-specific mapping for Salt formulas
priority: 1
---

# OS-specific mapping for Salt formulas

## Goal
Define deterministic branching rules for Linux and Windows when generating formula files and states.

## Supported families
- `Debian`: includes Astra Linux branch.
- `RedHat`: includes ALT Linux RPM branch.
- `Windows`: native Windows branch.

## Mapping rules
1. If user requests Astra Linux, generator must include `Debian` in `os_family`.
2. If user requests ALT Linux, generator must include `RedHat` in `os_family`.
3. If user requests Windows, generator must include `Windows` in `os_family` and `windows` in `os`.
4. For mixed targets, keep all requested branches in one formula and route behavior via `map.jinja`.

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
All generated SLS and Jinja files must avoid hardcoded formula names and use:

```jinja
{%- set tplroot = tpldir.split('/')[0] %}
```

See also: `12-repos-winrepo-pillar.md`.
