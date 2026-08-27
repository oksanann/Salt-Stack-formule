# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Clean: remove required packages; forbidden stay removed by default.

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

{%- if sb.packages.get('required') %}
security-baseline-packages-clean-pkg-removed:
  pkg.removed:
    - pkgs:
{%- for pkg in sb.packages.required %}
      - {{ pkg }}
{%- endfor %}
{%- endif %}
