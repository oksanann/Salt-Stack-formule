# Post-generation smoke test

Run after script execution.

## Directory checks
- `<name>-formula/` exists.
- `<name>-formula/<name>/` exists.

## Mandatory file checks
- `<name>-formula/FORMULA`
- `<name>-formula/pillar.example`
- `<name>-formula/<name>/init.sls`
- `<name>-formula/<name>/clean.sls`

## Recommended file checks
- `<name>-formula/<name>/map.jinja`
- `<name>-formula/docs/README.RST`

## Metadata checks (FORMULA)
- contains `name:`
- contains `os:`
- contains `os_family:`
- contains `version:`
- contains `release:`
- contains `summary:`
- contains `description:`
- contains `top_level_dir:`

## State checks
- `init.sls` includes expected install path.
- `clean.sls` includes expected rollback path.
- repository states exist when `with_repo=true`.

## Pillar checks
- `pillar.example` contains `lookup`.
- branch-specific keys exist when requested:
  - Linux: `repo.*`
  - Windows: `windows.*`
