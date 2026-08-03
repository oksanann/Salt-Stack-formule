=======================
security-baseline-formula
=======================

Формула Осмакс: базовая политика безопасности для Linux
(Debian / Ubuntu / Astra / RedHat) и контроль соответствия.

Состояния
=========

Apply
-----

* ``security-baseline`` — применить всю политику
* ``security-baseline.ssh`` — hardening SSH (drop-in)
* ``security-baseline.sysctl`` — параметры ядра
* ``security-baseline.services`` — отключить лишние сервисы
* ``security-baseline.packages`` — required / forbidden пакеты

Check (без исправления)
-----------------------

* ``security-baseline.check`` — полный compliance-check
* ``security-baseline.ssh.check``
* ``security-baseline.sysctl.check``
* ``security-baseline.services.check``
* ``security-baseline.packages.check``

Clean (откат)
-------------

* ``security-baseline.clean`` — удалить drop-in SSH/sysctl,
  снять required-пакеты; forbidden-пакеты и disabled-сервисы
  по умолчанию **не** возвращаются (см. ``services.restore_on_clean``)

Что настраивается
=================

SSH
---

Файл ``/etc/ssh/sshd_config.d/99-security-baseline.conf``:

* PermitRootLogin no
* PasswordAuthentication no
* PubkeyAuthentication yes
* X11Forwarding no
* MaxAuthTries 3
* ClientAliveInterval / CountMax
* опционально AllowUsers / AllowGroups

Sysctl
------

Файл ``/etc/sysctl.d/99-security-baseline.conf``:

* ip_forward=0, syncookies, no redirects, ASLR, и др.

Services
--------

Остановка и disable: telnet, rsh, nfs-server, rpcbind, avahi, cups, bluetooth
(если unit есть в системе).

Packages
--------

* ``required`` — установить
* ``forbidden`` — удалить (telnet, rsh-client, talk, xinetd, …)

Пример pillar
=============

См. ``pillar.example``.

Минимум (дефолты из map.jinja)::

    security-baseline:
      lookup: {}

Только проверка SSH + sysctl::

    security-baseline:
      lookup:
        enable_packages: False
        enable_services: False
        ssh:
          password_authentication: 'yes'   # если нужны пароли временно
          allow_users: ['admin']

Применение
==========

Apply::

    salt '<minion>' state.apply security-baseline

Check::

    salt '<minion>' state.apply security-baseline.check

Dry-run apply::

    salt '<minion>' state.apply security-baseline test=True

Clean::

    salt '<minion>' state.apply security-baseline.clean

Расписание контроля (pillar minion)::

    schedule:
      security_baseline_check:
        function: state.apply
        args:
          - security-baseline.check
        hours: 6

Важно
=====

* Перед apply с ``PasswordAuthentication: no`` убедитесь, что
  на хосте есть рабочий SSH-ключ, иначе можно потерять доступ.
* На RedHat сервис SSH — ``sshd`` (задано в map.jinja).
* Формула не заменяет SELinux/AppArmor/firewalld — при необходимости
  расширьте отдельными состояниями.
