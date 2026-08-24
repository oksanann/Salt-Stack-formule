{# -*- coding: utf-8 -*- #}
# Meta-state: remove Chrome shortcut from Public Desktop (Windows)

{%- set tplroot = tpldir.split('/')[0] -%}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context -%}

{%- if grains['os_family'] == 'Windows' %}
chrome-desktop-shortcut-allusers-remove-chrome-lnk:
  file.absent:
    - name: {{ sb.link.lnk_path }}
{%- endif %}

