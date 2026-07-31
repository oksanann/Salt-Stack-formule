# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Remove Yandex Browser package (Linux / Windows)

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as ybu with context %}

{%- if grains['os_family'] == 'Windows' %}

{%- set win = ybu.get('windows', {}) %}
{%- set win_method = win.get('method', 'chocolatey') %}
{%- set choco_name = win.get('chocolatey_name', ybu.pkg.name) %}

{%- if win_method == 'installer' %}

yandex-browser-universal-package-clean-cmd-run-uninstall:
  cmd.run:
    - name: >
        powershell -NoProfile -Command
        "$u = Get-ItemProperty HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*,
        HKLM:\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\* |
        Where-Object { $_.DisplayName -like '*{{ win.uninstall_name }}*' } |
        Select-Object -First 1;
        if ($u -and $u.UninstallString) {
          $cmd = $u.UninstallString;
          if ($cmd -match 'msiexec') { Start-Process msiexec.exe -ArgumentList '/x',$($u.PSChildName),'/qn','/norestart' -Wait }
          else { Start-Process cmd.exe -ArgumentList '/c',$cmd,'/silent' -Wait }
        }"
    - onlyif:
      - powershell -NoProfile -Command "Get-ItemProperty HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*, HKLM:\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\* | Where-Object { $_.DisplayName -like '*{{ win.uninstall_name }}*' } | Select-Object -First 1"

yandex-browser-universal-package-clean-file-absent-installer:
  file.absent:
    - name: {{ win.installer_path }}

{%- else %}

yandex-browser-universal-package-clean-chocolatey-uninstalled:
  chocolatey.uninstalled:
    - name: {{ choco_name }}

{%- endif %}

{%- else %}

yandex-browser-universal-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ ybu.pkg.name }}

{%- endif %}
