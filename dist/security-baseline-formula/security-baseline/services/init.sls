# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Stop and disable unwanted services (if unit exists)

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

{%- for svc in sb.services.get('disabled', []) %}
{%- set sid = svc | replace('.', '-') | replace('@', '-at-') %}

security-baseline-services-dead-{{ sid }}:
  service.dead:
    - name: {{ svc }}
    - enable: False
    - onlyif:
      - systemctl list-unit-files {{ svc }} 2>/dev/null | grep -q {{ svc }}

{%- endfor %}
