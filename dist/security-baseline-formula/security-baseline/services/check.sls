# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Compliance check: unwanted services are inactive/disabled when present

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

{%- for svc in sb.services.get('disabled', []) %}
{%- set sid = svc | replace('.', '-') | replace('@', '-at-') %}

security-baseline-services-check-dead-{{ sid }}:
  cmd.run:
    - name: >
        if systemctl list-unit-files {{ svc }} 2>/dev/null | grep -q {{ svc }}; then
          systemctl is-active {{ svc }} 2>/dev/null | grep -Eq 'inactive|failed|unknown'
          && ! systemctl is-enabled {{ svc }} 2>/dev/null | grep -q enabled
        else
          true
        fi
    - shell: /bin/bash

{%- endfor %}
