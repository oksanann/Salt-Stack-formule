# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

{%- if grains['os_family'] == 'Windows' %}

{%- set win = cfg.get('windows', {}) %}
{%- set win_method = win.get('method', 'winrepo') %}
{%- set winrepo_name = win.get('winrepo_name', cfg.pkg.name) %}
{%- set choco_name = win.get('chocolatey_name', cfg.pkg.name) %}

{%- if win_method == 'chocolatey' %}

total-commander-package-chocolatey-uninstalled:
  chocolatey.uninstalled:
    - name: {{ choco_name }}

{%- else %}

{# winrepo or installer cleanup via pkg.removed #}
total-commander-package-winrepo-pkg-removed:
  pkg.removed:
    - name: {{ winrepo_name }}

{%- endif %}

{%- else %}

total-commander-package-pkg-removed:
  pkg.removed:
    - name: {{ cfg.pkg.name }}

{%- endif %}
