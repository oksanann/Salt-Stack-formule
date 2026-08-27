# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Compliance check: sysctl values match policy

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

security-baseline-sysctl-check-file-exists:
  file.exists:
    - name: {{ sb.sysctl.config_path }}

{%- for key, value in sb.sysctl.params.items() %}
security-baseline-sysctl-check-{{ key | replace('.', '-') }}:
  cmd.run:
    - name: test "$(sysctl -n {{ key }})" = "{{ value }}"
    - require:
      - file: security-baseline-sysctl-check-file-exists
{%- endfor %}
