# Meta-state: create Chrome shortcut for all users (Windows Public Desktop)

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] -%}
{%- from tplroot ~ "/map.jinja" import mapdata as sb with context -%}

{%- if grains['os_family'] == 'Windows' %}

chrome-desktop-shortcut-allusers-public-desktop-dir:
  file.directory:
    - name: {{ sb.desktop.public_desktop_dir }}
    - makedirs: True

chrome-desktop-shortcut-allusers-create-chrome-lnk:
  cmd.script:
    - source: salt://{{ tpldir }}/files/create-chrome-desktop-shortcut-allusers.ps1
    - shell: powershell
    - args:
      - -LnkPath
      - '{{ sb.link.lnk_path }}'
      - -ChromeExeX64
      - '{{ sb.chrome.exe_x64 }}'
      - -ChromeExeX86
      - '{{ sb.chrome.exe_x86 }}'
      - -ChromeExeCustom
      - '{{ sb.chrome.exe_custom }}'
    - require:
      - file: chrome-desktop-shortcut-allusers-public-desktop-dir

{%- endif %}

