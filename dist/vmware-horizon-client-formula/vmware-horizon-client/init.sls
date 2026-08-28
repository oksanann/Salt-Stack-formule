# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

include:
{%- if grains['os_family'] == 'Windows' %}
  - .package
{%- else %}
  - .repository
  - .package
{%- endif %}
