# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Repository meta-state (Linux only)

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}

{%- if grains['os_family'] != 'Windows' %}
include:
  - .install
{%- endif %}
