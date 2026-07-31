# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Remove repository config and key (Linux)

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as ybu with context %}

{%- if grains['os_family'] != 'Windows' and ybu.repo.get('name') %}

include:
  - .key.clean

{%- if grains['os_family'] == 'Debian' %}

yandex-browser-universal-repository-clean-pkgrepo-absent:
  pkgrepo.absent:
    - name: deb [signed-by={{ ybu.repo.key_keyrings_dir.rstrip('/') ~ '/' ~ ybu.repo.conf_name ~ '.gpg' }}] {{ ybu.repo.name[4:].strip() if ybu.repo.name.startswith('deb ') else ybu.repo.name }}

yandex-browser-universal-repository-clean-file-absent-list:
  file.absent:
    - name: {{ ybu.repo.file }}

{%- elif grains['os_family'] == 'RedHat' %}

yandex-browser-universal-repository-clean-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ ybu.repo.conf_name }}

yandex-browser-universal-repository-clean-file-absent-repo:
  file.absent:
    - name: {{ ybu.repo.file }}

{%- endif %}

{%- endif %}
