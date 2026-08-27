# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Apply SSH hardening drop-in

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context %}

security-baseline-ssh-file-directory:
  file.directory:
    - name: /etc/ssh/sshd_config.d
    - mode: '0755'
    - makedirs: True

security-baseline-ssh-file-managed:
  file.managed:
    - name: {{ sb.ssh.config_path }}
    - source: salt://{{ tplroot }}/files/sshd-security-baseline.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: '0644'
    - defaults:
        ssh: {{ sb.ssh }}
    - require:
      - file: security-baseline-ssh-file-directory

security-baseline-ssh-service-running:
  service.running:
    - name: {{ sb.ssh.service }}
    - enable: True
    - watch:
      - file: security-baseline-ssh-file-managed
