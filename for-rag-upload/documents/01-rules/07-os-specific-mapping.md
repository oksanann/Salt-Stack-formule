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
  - install target package with `pkg.installed`.
- Windows:
  - install via configured strategy (`win_pkg`, `cmd.run`, MSI/EXE wrapper);
  - cleanup branch must uninstall package and remove temporary installer artifacts if created.

## Repository behavior
- `with_repo=true` enables repository state chain for Linux families.
- Repository states are optional for Windows and should only be generated when explicitly needed.

## Pillar compatibility
- Always read user overrides from:
  - `<formula_name>:lookup`
- Keep branch-specific values under `lookup`, for example:
  - `repo.*` for Linux;
  - `windows.*` for Windows.

## Required implementation guard
All generated SLS and Jinja files must avoid hardcoded formula names and use:

```jinja
{%- set tplroot = tpldir.split('/')[0] %}
```
