# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

{%- if grains['os_family'] == 'Windows' %}

{%- set win = cfg.get('windows', {}) %}
{%- set win_method = win.get('method', 'chocolatey') %}
{%- set choco_name = win.get('chocolatey_name', cfg.pkg.name) %}
{%- set pkg_version = cfg.pkg.get('version', '') %}

{%- if win_method == 'installer' and win.get('installer_url') %}

yandex-browser-package-file-managed-installer:
  file.managed:
    - name: {{ win.installer_path }}
    - source: {{ win.installer_url }}
    - skip_verify: True
    - makedirs: True

yandex-browser-package-cmd-run-installer:
  cmd.run:
    - name: '"{{ win.installer_path }}" {{ win.install_args }}'
    - require:
      - file: yandex-browser-package-file-managed-installer

{%- else %}

yandex-browser-package-chocolatey-installed:
  chocolatey.installed:
    - name: {{ choco_name }}
{%- if pkg_version %}
    - version: '{{ pkg_version }}'
{%- endif %}

{%- endif %}

{%- else %}

yandex-browser-package-pkg-installed:
  pkg.installed:
    - name: {{ cfg.pkg.name }}
{%- if cfg.pkg.get('version') %}
    - version: '{{ cfg.pkg.version }}'
{%- endif %}
{%- if cfg.pkg.get('fromrepo') and grains['os_family'] == 'Debian' %}
    - fromrepo: {{ cfg.pkg.fromrepo }}
{%- endif %}
{%- if cfg.get('repo', {}).get('name') %}
    - require:
      - pkgrepo: yandex-browser-repository-install-pkgrepo-managed
{%- endif %}

{%- endif %}
