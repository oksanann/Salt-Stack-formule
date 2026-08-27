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

`repo.*` **переопределяемы через pillar** (другой mirror / offline). Пустой `repo.name` — не импортировать.

```yaml
<formula-name>:
  lookup:
    pkg:
      name: <package-name>
      version: ''          # пусто = latest
      fromrepo: ''
    repo:
      name: 'deb https://official.example/repo stable main'  # или корпоративный mirror
      disabled: False
      comps: 'main'
      conf_name: 'example'
      key_file: 'https://official.example/KEY.GPG'
      key_file_dearmor: True
      key_keyrings_dir: '/etc/apt/keyrings/'
      required_packages: [ 'gpg' ]
      file: '/etc/apt/sources.list.d/example.list'
    windows:
      method: winrepo
      winrepo_name: <package-name>
```

Рабочие эталонные URL: см. `12-repos-winrepo-pillar.md` (Yandex, Chrome).
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
