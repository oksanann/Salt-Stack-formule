# Bash generator contract

## Purpose
This contract defines mandatory behavior for any AI-generated Bash script that creates a Salt formula skeleton.

## Script format requirements
1. Script must start with:
   - `#!/usr/bin/env bash`
   - `set -euo pipefail`
2. Script must be self-contained and runnable without manual file edits.
3. Script must use heredoc blocks to write content files.
4. Script must exit with non-zero code on validation errors.

## Input parameters
Required:
- `--name`

Optional:
- `--os-family` (comma-separated, default `Debian,RedHat,Windows`)
- `--summary`
- `--description`
- `--with-repo` (`true|false`, default `true`)
- `--base-dir` (output root)

## Input validation
1. `name` must match regex: `^[a-zA-Z0-9_-]+$`.
2. Reject names containing dots, spaces, or non-latin symbols.
3. If `--with-repo` is not `true|false`, stop with clear error.

## Output structure (mandatory)
For formula `<name>`:

- `<name>-formula/`
- `<name>-formula/FORMULA`
- `<name>-formula/pillar.example`
- `<name>-formula/docs/README.RST` (recommended)
- `<name>-formula/<name>/init.sls`
- `<name>-formula/<name>/clean.sls`
- `<name>-formula/<name>/map.jinja` (recommended)

Additional files are generated based on selected states.

## FORMULA file rules
Must include fields:
- `name`
- `os`
- `os_family`
- `version` (`YYYYMM`)
- `release`
- `summary`
- `description`
- `top_level_dir`

`version` should be computed at runtime using `date +%Y%m`.

## State model expectations
Base:
- `<name>` (meta)
- `<name>.package`
- `<name>.clean` (meta)
- `<name>.package.clean`

If repository flow is enabled:
- `<name>.repository`
- `<name>.repository.install`
- `<name>.repository.package.install`
- `<name>.repository.key.install` (if key used)
- `<name>.repository.clean`
- `<name>.repository.key.clean` (if key used)

## Pillar and templating rules
1. Generated templates must read data from `lookup` via `tplroot`.
2. Include in templates:

```jinja
{%- set tplroot = tpldir.split('/')[0] %}
```

3. Store sensitive values in pillar and pass to scripts through command args.

## Final self-check block (mandatory)
At script end, verify:
- Formula directory exists.
- Mandatory files exist.
- `FORMULA` contains required keys.
- Exit with success summary if checks pass.
