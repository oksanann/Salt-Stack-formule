# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

{%- if grains['os_family'] != 'Windows' and cfg.repo.get('key_file') %}

{%- set key_path = cfg.repo.key_keyrings_dir.rstrip('/') ~ '/' ~ cfg.repo.conf_name ~ '.gpg' %}

total-commander-repository-key-install-file-managed:
  file.managed:
    - name: {{ key_path }}
    - source: {{ cfg.repo.key_file }}
    - skip_verify: True
    - makedirs: True

{%- endif %}
