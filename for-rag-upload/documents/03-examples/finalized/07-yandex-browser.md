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

```yaml
yandex-browser:
  lookup:
    pkg:
      name: yandex-browser-stable
      version: '23.5.4.685-1'
      fromrepo: 'stable'
    repo:
      name: 'deb http://repo.yandex.ru/yandex-browser/deb stable'
      disabled: False
      comps: 'main,contrib,non-free'
      conf_name: 'yandex-browser'
      key_file: 'https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG'
      key_file_dearmor: True
      key_keyrings_dir: '/etc/apt/keyrings/'
      required_packages: [ 'gpg' ]
```

## Паттерн

Тот же package+repository, что у google-chrome. Отличия — имена пакета/repo/key и `comps`.
