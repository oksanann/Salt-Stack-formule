# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Install Yandex Browser package (Linux pkg / Windows chocolatey|installer)

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as ybu with context %}

{%- if grains['os_family'] == 'Windows' %}

{%- set win = ybu.get('windows', {}) %}
{%- set win_method = win.get('method', 'chocolatey') %}
{%- set choco_name = win.get('chocolatey_name', ybu.pkg.name) %}
{%- set pkg_version = ybu.pkg.get('version', '') %}

{%- if win_method == 'installer' and win.get('installer_url') %}

yandex-browser-universal-package-file-managed-installer:
  file.managed:
    - name: {{ win.installer_path }}
    - source: {{ win.installer_url }}
    - skip_verify: True
    - makedirs: True

yandex-browser-universal-package-cmd-run-installer:
  cmd.run:
    - name: '"{{ win.installer_path }}" {{ win.install_args }}'
    - require:
      - file: yandex-browser-universal-package-file-managed-installer
    - unless:
      - powershell -NoProfile -Command "Get-ItemProperty HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*, HKLM:\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\* | Where-Object { $_.DisplayName -like '*{{ win.uninstall_name }}*' } | Select-Object -First 1"

{%- else %}

yandex-browser-universal-package-chocolatey-installed:
  chocolatey.installed:
    - name: {{ choco_name }}
{%- if pkg_version %}
    - version: '{{ pkg_version }}'
{%- endif %}

{%- endif %}

{%- else %}

{%- set pkg_name = ybu.pkg.name %}
{%- set pkg_version = ybu.pkg.get('version', '') %}
{%- set fromrepo = ybu.pkg.get('fromrepo', '') %}

yandex-browser-universal-package-pkg-installed:
  pkg.installed:
    - name: {{ pkg_name }}
{%- if pkg_version %}
    - version: '{{ pkg_version }}'
{%- endif %}
{%- if fromrepo and grains['os_family'] == 'Debian' %}
    - fromrepo: {{ fromrepo }}
{%- endif %}
{%- if ybu.repo.get('name') %}
    - require:
      - pkgrepo: yandex-browser-universal-repository-install-pkgrepo-managed
{%- endif %}

{%- endif %}
