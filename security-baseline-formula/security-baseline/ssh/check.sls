# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Compliance check: SSH drop-in and effective settings

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

security-baseline-ssh-check-file-exists:
  file.exists:
    - name: {{ sb.ssh.config_path }}

security-baseline-ssh-check-permit-root:
  cmd.run:
    - name: grep -Eq '^PermitRootLogin[[:space:]]+{{ sb.ssh.permit_root_login }}$' {{ sb.ssh.config_path }}
    - require:
      - file: security-baseline-ssh-check-file-exists

security-baseline-ssh-check-password-auth:
  cmd.run:
    - name: grep -Eq '^PasswordAuthentication[[:space:]]+{{ sb.ssh.password_authentication }}$' {{ sb.ssh.config_path }}
    - require:
      - file: security-baseline-ssh-check-file-exists

security-baseline-ssh-check-service-enabled:
  service.enabled:
    - name: {{ sb.ssh.service }}

security-baseline-ssh-check-service-running:
  service.running:
    - name: {{ sb.ssh.service }}
