# User prompt example: Yandex Browser formula

Сгенерируй один полный bash-скрипт (без JSON и без пояснений вне минимума), который создаст Salt-формулу для установки Яндекс Браузера.

Требования:
- name: yandex-browser
- top_level_dir: yandex-browser
- Целевые ОС:
  - Astra Linux (Debian family)
  - ALT Linux (RedHat family)
  - Windows
- Linux: with_repo=true, добавить ветку repository + key (если указан key)
- Windows: установка через MSI/EXE (параметры в pillar lookup)
- Обязательные файлы:
  - yandex-browser/init.sls
  - yandex-browser/clean.sls
  - pillar.example
  - FORMULA
- Добавь map.jinja и docs/README.RST
- FORMULA:
  - os: linux, windows
  - os_family: Debian, RedHat, Windows
  - version: через date +%Y%m
  - release: 1
  - summary/description на русском

Состояния:
- yandex-browser
- yandex-browser.package
- yandex-browser.clean
- yandex-browser.package.clean
- yandex-browser.repository
- yandex-browser.repository.install
- yandex-browser.repository.package.install
- yandex-browser.repository.key.install
- yandex-browser.repository.clean
- yandex-browser.repository.key.clean

Pillar lookup должен включать:
- package_name
- package_version (optional)
- repo.name
- repo.required_packages
- repo.key_file (base64)
- windows.installer_url
- windows.installer_args
- windows.package_manager

В конце скрипта добавь self-check обязательных файлов и вывод пути к созданной формуле.
