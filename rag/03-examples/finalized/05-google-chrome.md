---
product: osmax
doc_type: salt-formula-example
title: Готовая формула google-chrome
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/google-chrome-formula/
template: finalized
priority: 3
---

# Формула google-chrome

Назначение: установка Google Chrome из внешнего apt-репозитория.

## Состояния

Apply: `google-chrome`, `.repository`, `.repository.install`, `.repository.package.install`, `.repository.key.install`, `.package`

Clean: `google-chrome.clean`, `.package.clean`, `.repository.clean`, `.repository.key.clean`

## pillar.example

```yaml
google-chrome:
  lookup:
    pkg:
      name: google-chrome-stable
      version: ''
      fromrepo: ''
    repo:
      name: 'deb http://dl.google.com/linux/chrome/deb/ stable main'
      disabled: False
      comps: ''
      conf_name: 'google-chrome'
      key_file: 'https://dl.google.com/linux/linux_signing_key.pub'
      key_file_dearmor: True
      key_keyrings_dir: '/etc/apt/keyrings/'
      required_packages: [ 'gpg' ]
```

## Паттерн

См. `01-pattern-package-repo.md`. Эталон package+repository+key+clean.
