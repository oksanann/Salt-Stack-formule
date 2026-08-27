---
product: osmax
doc_type: salt-formula-rules
title: Эталонный bash-скрипт сборки формулы (РАБОЧИЙ ПРИМЕР)
priority: 1
chunk: none
---

# Эталонный bash-скрипт — копировать паттерн

ИИ **ОБЯЗАН** генерировать скрипт по этому шаблону.  
**ЗАПРЕЩЕНО** создавать пустые файлы или файлы только с комментариями `# TODO`.

## Обязательный паттерн: функция write_file

```bash
#!/usr/bin/env bash
set -euo pipefail

write_file() {
  local rel="$1"
  local target="${FORMULA_DIR}/${rel}"
  mkdir -p "$(dirname "$target")"
  cat > "$target"
}

fail_if_empty() {
  local f="$1"
  if [[ ! -s "$f" ]]; then
    echo "ERROR: empty file created: $f" >&2
    exit 1
  fi
}
```

## Минимальный рабочий скрипт (package без repo)

```bash
#!/usr/bin/env bash
set -euo pipefail

NAME="${1:-nginx}"
BASE_DIR="${2:-.}"
FORMULA_DIR="${BASE_DIR}/${NAME}-formula"
TOP="${NAME}"
VERSION="$(date +%Y%m)"

write_file() {
  local rel="$1"
  local target="${FORMULA_DIR}/${rel}"
  mkdir -p "$(dirname "$target")"
  cat > "$target"
}

fail_if_empty() {
  local f="$1"
  [[ -s "$f" ]] || { echo "ERROR: empty: $f" >&2; exit 1; }
}

if [[ ! "${NAME}" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  echo "ERROR: invalid name" >&2; exit 1
fi

write_file "FORMULA" <<EOF
name: ${NAME}
os:
  - linux
os_family:
  - Debian
  - RedHat
version: ${VERSION}
release: 1
summary: "Install ${NAME}"
description: "Install ${NAME} package"
top_level_dir: ${TOP}
EOF

write_file "pillar.example" <<'EOF'
nginx:
  lookup:
    pkg:
      name: nginx
      version: ''
EOF

write_file "${TOP}/map.jinja" <<'EOF'
{% set mapdata = salt['grains.filter_by']({
    'default': {
        'pkg': {'name': 'nginx', 'version': ''},
    },
    'Debian': {},
    'RedHat': {},
}, merge=salt['pillar.get'](tpldir.split('/')[0] ~ ':lookup'), base='default') %}
EOF

write_file "${TOP}/init.sls" <<'EOF'
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

include:
  - .package
EOF

write_file "${TOP}/clean.sls" <<'EOF'
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

include:
  - .package.clean
EOF

write_file "${TOP}/package.sls" <<'EOF'
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

nginx-package-pkg-installed:
  pkg.installed:
    - name: {{ cfg.pkg.name }}
{%- if cfg.pkg.get('version') %}
    - version: '{{ cfg.pkg.version }}'
{%- endif %}
EOF

write_file "${TOP}/package.clean.sls" <<'EOF'
# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

nginx-package-pkg-removed:
  pkg.removed:
    - name: {{ cfg.pkg.name }}
EOF

write_file "docs/README.RST" <<'EOF'
nginx formula
=============

Apply::

  salt '*' state.apply nginx

Pillar lookup overrides map.jinja defaults.
EOF

# Self-check: files exist AND non-empty
REQUIRED=(
  "FORMULA"
  "pillar.example"
  "${TOP}/init.sls"
  "${TOP}/clean.sls"
  "${TOP}/map.jinja"
  "${TOP}/package.sls"
  "${TOP}/package.clean.sls"
)
for f in "${REQUIRED[@]}"; do
  fail_if_empty "${FORMULA_DIR}/${f}"
done

grep -q '^name:' "${FORMULA_DIR}/FORMULA" || { echo "ERROR: FORMULA missing name" >&2; exit 1; }
grep -q 'tplroot' "${FORMULA_DIR}/${TOP}/init.sls" || { echo "ERROR: init.sls missing tplroot" >&2; exit 1; }
grep -q 'pkg.installed' "${FORMULA_DIR}/${TOP}/package.sls" || { echo "ERROR: package.sls missing state" >&2; exit 1; }

echo "OK: formula created at ${FORMULA_DIR}"
find "${FORMULA_DIR}" -type f | sort
```

## Правила heredoc (частая причина ошибок)

| Ситуация | Heredoc | Почему |
|----------|---------|--------|
| SLS/Jinja с `{{`, `$`, `` ` `` | `<<'EOF'` | Без подстановки shell |
| FORMULA с `${NAME}` из bash | `<<EOF` | Нужна подстановка bash |
| Нельзя вкладывать heredoc в heredoc | — | Используй `write_file` |

## Минимальное содержимое каждого файла

| Файл | Минимум |
|------|---------|
| `init.sls` | `tplroot`, `import mapdata`, `include:` |
| `clean.sls` | `tplroot`, `include:` отката |
| `map.jinja` | `grains.filter_by`, `merge=pillar.get` |
| `package.sls` | реальное состояние `pkg.installed` |
| `package.clean.sls` | `pkg.removed` |
| `FORMULA` | все 8 полей |
| `pillar.example` | ключ формулы + `lookup:` |

## Если формула сложная (repo + Windows + key)

Используй **Python-сборщик** (`06-python-builder-output.md`) — надёжнее bash heredoc.
