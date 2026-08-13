#!/usr/bin/env bash
# Reference builder — copy this pattern for AI-generated scripts.
# Usage: ./reference_build_nginx_formula.sh [name] [output_dir]

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
  [[ -s "$f" ]] || { echo "ERROR: empty file: $f" >&2; exit 1; }
}

if [[ ! "${NAME}" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  echo "ERROR: name must match [a-zA-Z0-9_-]+" >&2
  exit 1
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
description: "Install ${NAME} package on Linux"
top_level_dir: ${TOP}
EOF

write_file "pillar.example" <<EOF
${NAME}:
  lookup:
    pkg:
      name: ${NAME}
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

write_file "docs/README.RST" <<EOF
${NAME} formula
=============

Apply::

  salt '*' state.apply ${TOP}
EOF

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

grep -q '^name:' "${FORMULA_DIR}/FORMULA"
grep -q 'tplroot' "${FORMULA_DIR}/${TOP}/init.sls"
grep -q 'pkg.installed' "${FORMULA_DIR}/${TOP}/package.sls"

echo "OK: ${FORMULA_DIR}"
find "${FORMULA_DIR}" -type f | sort
