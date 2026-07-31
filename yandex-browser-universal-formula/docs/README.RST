===============================
yandex-browser-universal-formula
===============================

Кроссплатформенная формула Осмакс для установки «Яндекс Браузер»
на Linux (Debian/Ubuntu/Astra, RedHat) и Windows.

Имя ``yandex-browser-universal`` выбрано, чтобы не конфликтовать
со штатной формулой ``yandex-browser`` (только Linux/apt).

Доступные состояния
===================

Apply
-----

* ``yandex-browser-universal`` — мета-состояние установки
* ``yandex-browser-universal.repository`` — мета-состояние репозитория (Linux)
* ``yandex-browser-universal.repository.install`` — импорт репозитория
* ``yandex-browser-universal.repository.package.install`` — пакеты для импорта (gpg)
* ``yandex-browser-universal.repository.key.install`` — ключ репозитория
* ``yandex-browser-universal.package`` — установка браузера

Clean
-----

* ``yandex-browser-universal.clean`` — полный откат
* ``yandex-browser-universal.package.clean`` — удаление пакета/приложения
* ``yandex-browser-universal.repository.clean`` — удаление репозитория
* ``yandex-browser-universal.repository.key.clean`` — удаление ключа

Платформы
=========

Linux (Debian family)
---------------------

Импортирует apt-репозиторий Yandex и ставит ``yandex-browser-stable``.

Linux (RedHat family)
---------------------

Импортирует yum/dnf-репозиторий и ставит ``yandex-browser-stable``.

Windows
-------

По умолчанию: Chocolatey-пакет ``yandexbrowser``
(на агенте должен быть установлен Chocolatey).

Альтернатива: тихая установка по URL инсталлятора
(``windows.method: installer`` + ``windows.installer_url``).

Пример pillar
=============

См. ``pillar.example`` в корне формулы.

Минимальный пример для Linux (значения по умолчанию из map.jinja)::

    yandex-browser-universal:
      lookup: {}

Windows через Chocolatey::

    yandex-browser-universal:
      lookup:
        windows:
          method: chocolatey
          chocolatey_name: yandexbrowser

Windows через installer::

    yandex-browser-universal:
      lookup:
        windows:
          method: installer
          installer_url: 'https://example.local/yandex_browser_setup.exe'
          installer_path: 'C:\\Windows\\Temp\\yandex-browser-setup.exe'
          install_args: '/silent /install'

Применение
==========

Apply::

    salt '<minion>' state.apply yandex-browser-universal

Clean::

    salt '<minion>' state.apply yandex-browser-universal.clean
