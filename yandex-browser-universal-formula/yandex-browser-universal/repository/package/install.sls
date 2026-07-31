# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Install packages required to import the repository (usually gpg)

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as ybu with context %}

{%- if grains['os_family'] != 'Windows' and ybu.repo.get('required_packages') %}

yandex-browser-universal-repository-package-install-pkg-installed:
  pkg.installed:
    - pkgs:
{%- for pkg in ybu.repo.required_packages %}
      - {{ pkg }}
{%- endfor %}

{%- endif %}
