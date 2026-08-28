# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

include:
  - .key.clean

{%- if grains['os_family'] != 'Windows' and cfg.repo.get('file') %}

vmware-horizon-client-repository-clean-file-absent:
  file.absent:
    - name: {{ cfg.repo.file }}

{%- endif %}
