=======================
security-baseline-formula
=======================

Linux security baseline (Debian / Ubuntu / Astra / RedHat):
SSH hardening, sysctl, services lockdown, packages policy + compliance check.

Apply::

  salt '*' state.apply security-baseline

Check::

  salt '*' state.apply security-baseline.check

Clean::

  salt '*' state.apply security-baseline.clean

Pillar lookup overrides map.jinja defaults. See pillar.example.
