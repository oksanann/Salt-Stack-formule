# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Import Yandex Browser repository when repo.name is set

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as ybu with context %}

{%- if grains['os_family'] != 'Windows' and ybu.repo.get('name') %}

include:
  - .package.install
  - .key.install

{%- if grains['os_family'] == 'Debian' %}

{%- set keyring = ybu.repo.key_keyrings_dir.rstrip('/') ~ '/' ~ ybu.repo.conf_name ~ '.gpg' %}
{%- set raw = ybu.repo.name %}
{%- if raw.startswith('deb ') %}
{%- set raw = raw[4:].strip() %}
{%- endif %}
{%- set comps = ybu.repo.get('comps', '') | replace(',', ' ') %}
{%- if comps and comps not in raw %}
{%- set raw = raw ~ ' ' ~ comps %}
{%- endif %}

yandex-browser-universal-repository-install-pkgrepo-managed:
  pkgrepo.managed:
    - name: deb [signed-by={{ keyring }}] {{ raw }}
    - file: {{ ybu.repo.file }}
    - humanname: {{ ybu.repo.humanname }}
    - disabled: {{ ybu.repo.disabled }}
    - require:
      - file: yandex-browser-universal-repository-key-install-file-managed
{%- if ybu.repo.get('required_packages') %}
      - pkg: yandex-browser-universal-repository-package-install-pkg-installed
{%- endif %}

{%- elif grains['os_family'] == 'RedHat' %}

{%- set gpg_path = ybu.repo.key_keyrings_dir.rstrip('/') ~ '/' ~ ybu.repo.conf_name ~ '.gpg' %}

yandex-browser-universal-repository-install-pkgrepo-managed:
  pkgrepo.managed:
    - name: {{ ybu.repo.conf_name }}
    - humanname: {{ ybu.repo.humanname }}
    - baseurl: {{ ybu.repo.name }}
    - enabled: {{ '1' if not ybu.repo.disabled else '0' }}
    - gpgcheck: 1
    - gpgkey: file://{{ gpg_path }}
    - require:
      - file: yandex-browser-universal-repository-key-install-file-managed

{%- endif %}

{%- endif %}
