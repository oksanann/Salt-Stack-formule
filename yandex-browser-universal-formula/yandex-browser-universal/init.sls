# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Meta-state: install Yandex Browser (Linux + Windows)

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as ybu with context %}

include:
{%- if grains['os_family'] == 'Windows' %}
  - .package
{%- else %}
  - .repository
  - .package
{%- endif %}
