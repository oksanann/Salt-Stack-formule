# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Compliance check: required present, forbidden absent

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

{%- for pkg in sb.packages.get('required', []) %}
security-baseline-packages-check-installed-{{ pkg | replace('.', '-') | replace('+', '-') }}:
  pkg.installed:
    - name: {{ pkg }}
{%- endfor %}

{%- for pkg in sb.packages.get('forbidden', []) %}
security-baseline-packages-check-absent-{{ pkg | replace('.', '-') | replace('+', '-') }}:
  pkg.removed:
    - name: {{ pkg }}
{%- endfor %}
