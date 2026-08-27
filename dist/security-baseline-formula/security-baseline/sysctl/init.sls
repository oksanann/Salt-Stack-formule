# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Apply sysctl hardening via drop-in

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

{%- for key, value in sb.sysctl.params.items() %}
security-baseline-sysctl-present-{{ key | replace('.', '-') }}:
  sysctl.present:
    - name: {{ key }}
    - value: {{ value }}
    - config: {{ sb.sysctl.config_path }}
{%- endfor %}
