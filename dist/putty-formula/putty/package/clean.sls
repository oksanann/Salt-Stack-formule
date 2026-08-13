# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

{%- if grains['os_family'] == 'Windows' %}

{%- set win = cfg.get('windows', {}) %}
{%- set win_method = win.get('method', 'chocolatey') %}
{%- set choco_name = win.get('chocolatey_name', cfg.pkg.name) %}

{%- if win_method == 'chocolatey' %}

putty-package-chocolatey-uninstalled:
  chocolatey.uninstalled:
    - name: {{ choco_name }}

{%- else %}

putty-package-pkg-removed-windows:
  pkg.removed:
    - name: {{ cfg.pkg.name }}

{%- endif %}

{%- else %}

putty-package-pkg-removed:
  pkg.removed:
    - name: {{ cfg.pkg.name }}

{%- endif %}
