# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Meta-state: apply Linux security baseline

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

include:
{%- if sb.enable_packages %}
  - .packages
{%- endif %}
{%- if sb.enable_ssh %}
  - .ssh
{%- endif %}
{%- if sb.enable_sysctl %}
  - .sysctl
{%- endif %}
{%- if sb.enable_services %}
  - .services
{%- endif %}
