---
product: osmax
doc_type: salt-formula-example
title: Паттерн package + repository (браузеры)
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/google-chrome-formula/
priority: 3
---

# Паттерн готовых формул: package + repository

Используется в `google-chrome`, `yandex-browser`, `google-chrome-reboot`.

## Иерархия состояний

Apply:

1. `{{name}}` → include `{{name}}.repository`, `{{name}}.package`
2. `{{name}}.repository` → `{{name}}.repository.install`
3. `{{name}}.repository.install` → package.install + key.install (require)
4. `{{name}}.repository.package.install` → ставит `repo.required_packages` (обычно `gpg`)
5. `{{name}}.repository.key.install` → загружает `repo.key_file`, dearmor base64→binary
6. `{{name}}.package` → ставит пакет

Clean (обратный порядок):

1. `{{name}}.clean` → package.clean + repository.clean
2. `{{name}}.package.clean` → удаляет пакет
3. `{{name}}.repository.clean` → удаляет repo config + key.clean
4. `{{name}}.repository.key.clean` → удаляет key-файл

## Типовой lookup

```yaml
<formula-name>:
  lookup:
    pkg:
      name: <package-name>
      version: ''          # пусто = latest
      fromrepo: ''
    repo:
      name: 'deb http://example/repo stable main'  # пусто = repo не импортировать
      disabled: False
      comps: ''
      conf_name: 'example'
      key_file: 'https://example/KEY.GPG'
      key_file_dearmor: True
      key_keyrings_dir: '/etc/apt/keyrings/'
      required_packages: [ 'gpg' ]
```

## Вариант с reboot

Дополнительно в lookup:

```yaml
reboot: True
time: ''       # пусто = мгновенная перезагрузка
message: ''    # пусто = сообщение по умолчанию
```

## Выводы для генерации

- Если `repo.name` пустой — репозиторий не импортируется.
- `conf_name` обязателен и не пустой.
- Clean обязан удалить и пакет, и repo, и key.
- Не смешивайте этот паттерн с dynamic `file-find` lookup.
