# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Meta-state: compliance check (no remediation)

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

include:
{%- if sb.enable_ssh %}
  - .ssh.check
{%- endif %}
{%- if sb.enable_sysctl %}
  - .sysctl.check
{%- endif %}
{%- if sb.enable_services %}
  - .services.check
{%- endif %}
{%- if sb.enable_packages %}
  - .packages.check
{%- endif %}
