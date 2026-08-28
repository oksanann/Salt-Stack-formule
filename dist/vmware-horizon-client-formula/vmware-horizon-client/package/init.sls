# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

{%- if grains['os_family'] == 'Windows' %}

{%- set win = cfg.get('windows', {}) %}
{%- set win_method = win.get('method', 'winrepo') %}
{%- set winrepo_name = win.get('winrepo_name', cfg.pkg.name) %}
{%- set choco_name = win.get('chocolatey_name', cfg.pkg.name) %}
{%- set pkg_version = cfg.pkg.get('version', '') %}

{%- if win_method == 'installer' and win.get('installer_url') %}

vmware-horizon-client-package-file-managed-installer:
  file.managed:
    - name: {{ win.installer_path }}
    - source: {{ win.installer_url }}
    - skip_verify: True
    - makedirs: True

vmware-horizon-client-package-cmd-run-installer:
  cmd.run:
    - name: '"{{ win.installer_path }}" {{ win.install_args }}'
    - require:
      - file: vmware-horizon-client-package-file-managed-installer

{%- elif win_method == 'chocolatey' %}

vmware-horizon-client-package-chocolatey-installed:
  chocolatey.installed:
    - name: {{ choco_name }}
{%- if pkg_version %}
    - version: '{{ pkg_version }}'
{%- endif %}

{%- else %}

{# Default / winrepo: Salt Windows Software Repository #}
vmware-horizon-client-package-winrepo-pkg-installed:
  pkg.installed:
    - name: {{ winrepo_name }}
{%- if pkg_version %}
    - version: '{{ pkg_version }}'
{%- endif %}

{%- endif %}

{%- else %}

vmware-horizon-client-package-pkg-installed:
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
      - pkgrepo: vmware-horizon-client-repository-install-pkgrepo-managed
{%- endif %}

{%- endif %}
