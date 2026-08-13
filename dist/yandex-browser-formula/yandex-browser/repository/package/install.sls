# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cfg with context %}

{%- if grains['os_family'] != 'Windows' and cfg.repo.get('required_packages') %}

yandex-browser-repository-package-install-pkg-installed:
  pkg.installed:
    - pkgs: {{ cfg.repo.required_packages }}

{%- endif %}
