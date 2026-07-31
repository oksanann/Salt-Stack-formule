# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Download and prepare repository signing key

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as ybu with context %}

{%- if grains['os_family'] != 'Windows' and ybu.repo.get('key_file') %}

{%- set keyrings_dir = ybu.repo.key_keyrings_dir.rstrip('/') ~ '/' %}
{%- set key_path = keyrings_dir ~ ybu.repo.conf_name ~ '.gpg' %}
{%- set tmp_key = '/tmp/' ~ ybu.repo.conf_name ~ '.key.src' %}

yandex-browser-universal-repository-key-install-file-directory:
  file.directory:
    - name: {{ keyrings_dir }}
    - mode: '0755'
    - makedirs: True

yandex-browser-universal-repository-key-install-file-managed-source:
  file.managed:
    - name: {{ tmp_key }}
    - source: {{ ybu.repo.key_file }}
    - skip_verify: True
    - mode: '0644'
    - require:
      - file: yandex-browser-universal-repository-key-install-file-directory

{%- if ybu.repo.get('key_file_dearmor') %}

yandex-browser-universal-repository-key-install-cmd-run-dearmor:
  cmd.run:
    - name: gpg --dearmor < {{ tmp_key }} > {{ key_path }}
    - unless: test -s {{ key_path }}
    - require:
      - file: yandex-browser-universal-repository-key-install-file-managed-source
{%- if ybu.repo.get('required_packages') %}
      - pkg: yandex-browser-universal-repository-package-install-pkg-installed
{%- endif %}

yandex-browser-universal-repository-key-install-file-managed:
  file.managed:
    - name: {{ key_path }}
    - mode: '0644'
    - replace: False
    - require:
      - cmd: yandex-browser-universal-repository-key-install-cmd-run-dearmor

{%- else %}

yandex-browser-universal-repository-key-install-file-managed:
  file.managed:
    - name: {{ key_path }}
    - source: {{ tmp_key }}
    - mode: '0644'
    - require:
      - file: yandex-browser-universal-repository-key-install-file-managed-source

{%- endif %}

{%- endif %}
