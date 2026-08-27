# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Install required packages and remove forbidden ones

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

{%- if sb.packages.get('required') %}
security-baseline-packages-pkg-installed:
  pkg.installed:
    - pkgs:
{%- for pkg in sb.packages.required %}
      - {{ pkg }}
{%- endfor %}
{%- endif %}

{%- if sb.packages.get('forbidden') %}
security-baseline-packages-pkg-removed:
  pkg.removed:
    - pkgs:
{%- for pkg in sb.packages.forbidden %}
      - {{ pkg }}
{%- endfor %}
{%- endif %}
