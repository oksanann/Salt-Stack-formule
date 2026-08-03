# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Remove SSH hardening drop-in and reload sshd

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

security-baseline-ssh-clean-file-absent:
  file.absent:
    - name: {{ sb.ssh.config_path }}

security-baseline-ssh-clean-service-running:
  service.running:
    - name: {{ sb.ssh.service }}
    - enable: True
    - watch:
      - file: security-baseline-ssh-clean-file-absent
