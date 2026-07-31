# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Remove repository signing key

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as ybu with context %}

{%- if grains['os_family'] != 'Windows' and ybu.repo.get('conf_name') %}

{%- set keyrings_dir = ybu.repo.key_keyrings_dir.rstrip('/') ~ '/' %}
{%- set key_path = keyrings_dir ~ ybu.repo.conf_name ~ '.gpg' %}
{%- set tmp_key = '/tmp/' ~ ybu.repo.conf_name ~ '.key.src' %}

yandex-browser-universal-repository-key-clean-file-absent-key:
  file.absent:
    - name: {{ key_path }}

yandex-browser-universal-repository-key-clean-file-absent-tmp:
  file.absent:
    - name: {{ tmp_key }}

{%- endif %}
