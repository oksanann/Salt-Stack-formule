# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Meta-state: rollback security baseline (reverse order)

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

include:
{%- if sb.enable_services %}
  - .services.clean
{%- endif %}
{%- if sb.enable_sysctl %}
  - .sysctl.clean
{%- endif %}
{%- if sb.enable_ssh %}
  - .ssh.clean
{%- endif %}
{%- if sb.enable_packages %}
  - .packages.clean
{%- endif %}
