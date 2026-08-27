---
product: osmax
doc_type: salt-formula-example
title: Готовая формула google-chrome-reboot
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/google-chrome-reboot-formula/
template: finalized
priority: 3
---

# Формула google-chrome-reboot

Назначение: установка Google Chrome + опция перезагрузки ПО.

## Состояния

Те же, что у `google-chrome`, с префиксом `google-chrome-reboot`.

## Отличие lookup

К стандартным `pkg`/`repo` добавляются:

```yaml
google-chrome-reboot:
  lookup:
    pkg:
      name: google-chrome-stable
      version: ''
      fromrepo: ''
    repo:
      name: 'deb https://dl.google.com/linux/chrome/deb/ stable main'
      disabled: False
      comps: 'main'
      conf_name: 'google-chrome'
      key_file: 'https://dl.google.com/linux/linux_signing_key.pub'
      key_file_dearmor: True
      key_keyrings_dir: '/etc/apt/keyrings/'
      required_packages: [ 'gpg' ]
      file: '/etc/apt/sources.list.d/google-chrome.list'
    windows:
      method: winrepo
      winrepo_name: googlechrome
    reboot: True
    time: ''      # пусто = мгновенная перезагрузка
    message: ''   # пусто = сообщение по умолчанию
```

## Вывод для генерации

Если после установки нужна reboot — отдельный параметр в lookup (`reboot`/`time`/`message`), не хардкод в SLS.
