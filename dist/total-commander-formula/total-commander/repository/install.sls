# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

{%- if grains['os_family'] != 'Windows' and cfg.repo.get('name') %}

include:
  - .package.install
  - .key.install

{%- if grains['os_family'] == 'Debian' %}

{%- set keyring = cfg.repo.key_keyrings_dir.rstrip('/') ~ '/' ~ cfg.repo.conf_name ~ '.gpg' %}
{%- set raw = cfg.repo.name %}
{%- if raw.startswith('deb ') %}
{%- set raw = raw[4:].strip() %}
{%- endif %}
{%- set comps = cfg.repo.get('comps', '') | replace(',', ' ') %}
{%- if comps and comps not in raw %}
{%- set raw = raw ~ ' ' ~ comps %}
{%- endif %}

total-commander-repository-install-pkgrepo-managed:
  pkgrepo.managed:
    - name: deb [signed-by={{ keyring }}] {{ raw }}
    - file: {{ cfg.repo.file }}
    - humanname: {{ cfg.repo.humanname }}
    - disabled: {{ cfg.repo.disabled }}
    - require:
      - file: total-commander-repository-key-install-file-managed
{%- if cfg.repo.get('required_packages') %}
      - pkg: total-commander-repository-package-install-pkg-installed
{%- endif %}

{%- elif grains['os_family'] == 'RedHat' %}

{%- set gpg_path = cfg.repo.key_keyrings_dir.rstrip('/') ~ '/' ~ cfg.repo.conf_name ~ '.gpg' %}

total-commander-repository-install-pkgrepo-managed:
  pkgrepo.managed:
    - name: {{ cfg.repo.conf_name }}
    - humanname: {{ cfg.repo.humanname }}
    - baseurl: {{ cfg.repo.name }}
    - enabled: {{ '1' if not cfg.repo.disabled else '0' }}
    - gpgcheck: 1
    - gpgkey: file://{{ gpg_path }}
    - require:
      - file: total-commander-repository-key-install-file-managed

{%- endif %}

{%- endif %}
