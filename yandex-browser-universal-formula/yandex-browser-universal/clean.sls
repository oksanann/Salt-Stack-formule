# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Meta-state: reverse cleanup of Yandex Browser install

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as ybu with context %}

include:
{%- if grains['os_family'] == 'Windows' %}
  - .package.clean
{%- else %}
  - .package.clean
  - .repository.clean
{%- endif %}
