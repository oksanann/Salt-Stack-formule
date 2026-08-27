# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Remove sysctl hardening drop-in

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

security-baseline-sysctl-clean-file-absent:
  file.absent:
    - name: {{ sb.sysctl.config_path }}

security-baseline-sysctl-clean-cmd-reload:
  cmd.run:
    - name: sysctl --system
    - onchanges:
      - file: security-baseline-sysctl-clean-file-absent
