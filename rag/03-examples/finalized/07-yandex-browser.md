---
product: osmax
doc_type: salt-formula-example
title: Готовая формула yandex-browser
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/yandex-browser-formula/
template: finalized
priority: 3
---

# Формула yandex-browser

Назначение: установка «Яндекс Браузер» из внешнего apt-репозитория.

## Состояния

Apply: `yandex-browser`, `.repository*`, `.package`

Clean: `yandex-browser.clean`, `.package.clean`, `.repository.clean`, `.repository.key.clean`

## pillar.example

Рабочие официальные URL (https, comps=`main`). Через pillar можно подменить `repo.*` на корпоративный mirror.

```yaml
yandex-browser:
  lookup:
    pkg:
      name: yandex-browser-stable
      version: ''
      fromrepo: 'stable'
    repo:
      # Default (Astra/Debian). Можно заменить на mirror.
      name: 'deb https://repo.yandex.ru/yandex-browser/deb stable main'
      disabled: False
      comps: 'main'
      conf_name: 'yandex-browser'
      key_file: 'https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG'
      key_file_dearmor: True
      key_keyrings_dir: '/etc/apt/keyrings/'
      required_packages: [ 'gpg' ]
      file: '/etc/apt/sources.list.d/yandex-browser.list'
      humanname: 'Yandex Browser'
    windows:
      method: winrepo
      winrepo_name: yandexbrowser
      chocolatey_name: yandexbrowser
```

Для ALT (RedHat family) в map/pillar используйте:

```yaml
repo:
  name: 'https://repo.yandex.ru/yandex-browser/alt/$basearch/'
```

или RPM:

```yaml
repo:
  name: 'https://repo.yandex.ru/yandex-browser/rpm/stable/$basearch/'
```

## Паттерн

Тот же package+repository, что у google-chrome. Windows — `winrepo` (или chocolatey через pillar).
