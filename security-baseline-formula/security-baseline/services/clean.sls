# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Clean does not re-enable previously disabled services by default
# (would weaken security). Placeholder for explicit restore list.

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

{%- set restore = sb.services.get('restore_on_clean', []) %}
{%- for svc in restore %}
{%- set sid = svc | replace('.', '-') | replace('@', '-at-') %}

security-baseline-services-clean-running-{{ sid }}:
  service.running:
    - name: {{ svc }}
    - enable: True
    - onlyif:
      - systemctl list-unit-files {{ svc }} 2>/dev/null | grep -q {{ svc }}

{%- endfor %}
