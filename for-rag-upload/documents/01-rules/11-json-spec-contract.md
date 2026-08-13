---
product: osmax
doc_type: salt-formula-rules
title: JSON-спецификация формулы (вход для рендерера)
priority: 1
chunk: none
---

# JSON-first: ИИ → JSON → bash-рендерер → формула

## Пайплайн

```text
[User] → [LLM + RAG] → spec.json → [render_formula.sh] → <name>-formula/
```

ИИ **НЕ** генерирует bash и **НЕ** пишет SLS вручную.  
ИИ генерирует **только валидный JSON** по схеме ниже.  
Фиксированный скрипт `tools/render_formula.sh` собирает файлы.

## Формат ответа ИИ

1. Кратко 1 предложение (опционально)
2. Один блок ` ```json ` с полной спецификацией
3. Без bash, без списка файлов, без markdown внутри JSON

## JSON Schema (логическая)

Обязательные поля:

| Поле | Тип | Описание |
|------|-----|----------|
| `name` | string | Имя формулы, regex `^[a-zA-Z0-9_-]+$` |
| `top_level_dir` | string | Обычно = name |
| `os` | string[] | например `["linux","windows"]` |
| `os_family` | string[] | `Debian`, `RedHat`, `Windows` |
| `summary` | string | Краткое описание |
| `description` | string | Подробное описание |
| `with_repo` | boolean | Нужна ли цепочка repository |
| `pillar_lookup` | object | Содержимое `lookup` для pillar.example |
| `map_defaults` | object | Defaults по os_family для map.jinja |

Опциональные:

| Поле | Тип | Описание |
|------|-----|----------|
| `release` | number | По умолчанию 1 |
| `package_state` | string | `pkg` (default) |
| `windows` | object | `method`, `chocolatey_name`, `installer_url`, … |
| `notes` | string[] | Подсказки (не пишутся в формулу) |

## Минимальный пример (nginx, без repo)

```json
{
  "name": "nginx",
  "top_level_dir": "nginx",
  "os": ["linux"],
  "os_family": ["Debian", "RedHat"],
  "summary": "Install nginx",
  "description": "Install nginx package on Linux",
  "with_repo": false,
  "release": 1,
  "pillar_lookup": {
    "pkg": {
      "name": "nginx",
      "version": ""
    }
  },
  "map_defaults": {
    "default": {
      "pkg": {"name": "nginx", "version": ""}
    },
    "Debian": {},
    "RedHat": {}
  }
}
```

## Пример с repo + Windows (yandex-browser)

```json
{
  "name": "yandex-browser",
  "top_level_dir": "yandex-browser",
  "os": ["linux", "windows"],
  "os_family": ["Debian", "RedHat", "Windows"],
  "summary": "Установка Яндекс Браузера",
  "description": "Формула установки Яндекс Браузера на Astra Linux, ALT Linux и Windows",
  "with_repo": true,
  "release": 1,
  "pillar_lookup": {
    "pkg": {
      "name": "yandex-browser-stable",
      "version": "",
      "fromrepo": "stable"
    },
    "repo": {
      "name": "deb http://repo.yandex.ru/yandex-browser/deb stable",
      "disabled": false,
      "comps": "main,contrib,non-free",
      "conf_name": "yandex-browser",
      "key_file": "https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG",
      "key_file_dearmor": true,
      "key_keyrings_dir": "/etc/apt/keyrings/",
      "required_packages": ["gpg"]
    },
    "windows": {
      "method": "chocolatey",
      "chocolatey_name": "yandexbrowser",
      "installer_url": "",
      "installer_path": "C:\\\\Windows\\\\Temp\\\\yandex-browser-setup.exe",
      "install_args": "/silent /install",
      "uninstall_name": "Yandex"
    }
  },
  "map_defaults": {
    "default": {
      "pkg": {"name": "yandex-browser-stable", "version": "", "fromrepo": "stable"},
      "repo": {
        "name": "",
        "disabled": false,
        "comps": "",
        "conf_name": "yandex-browser",
        "key_file": "https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG",
        "key_file_dearmor": true,
        "key_keyrings_dir": "/etc/apt/keyrings/",
        "required_packages": ["gpg"],
        "file": "",
        "humanname": "Yandex Browser"
      },
      "windows": {
        "method": "chocolatey",
        "chocolatey_name": "yandexbrowser",
        "installer_url": "",
        "installer_path": "C:\\\\Windows\\\\Temp\\\\yandex-browser-setup.exe",
        "install_args": "/silent /install",
        "uninstall_name": "Yandex"
      }
    },
    "Debian": {
      "repo": {
        "name": "deb http://repo.yandex.ru/yandex-browser/deb stable",
        "comps": "main,contrib,non-free",
        "file": "/etc/apt/sources.list.d/yandex-browser.list",
        "humanname": "Yandex Browser"
      }
    },
    "RedHat": {
      "repo": {
        "name": "https://repo.yandex.ru/yandex-browser/rpm/stable/$basearch/",
        "key_file_dearmor": false,
        "key_keyrings_dir": "/etc/pki/rpm-gpg/",
        "required_packages": [],
        "file": "/etc/yum.repos.d/yandex-browser.repo",
        "humanname": "Yandex Browser"
      }
    },
    "Windows": {
      "pkg": {"name": "yandexbrowser", "version": "", "fromrepo": ""},
      "repo": {"name": "", "disabled": true}
    }
  },
  "windows": {
    "method": "chocolatey",
    "chocolatey_name": "yandexbrowser"
  }
}
```

## Правила валидации JSON (перед рендером)

1. `name` и `top_level_dir` совпадают с `^[a-zA-Z0-9_-]+$`
2. `os_family` не пустой
3. Если в `os_family` есть `Windows` — в `os` есть `windows`
4. Astra → `Debian`, ALT → `RedHat` (ИИ нормализует до генерации JSON)
5. `with_repo=true` ⇒ в `pillar_lookup` и/или `map_defaults` есть `repo`
6. JSON парсится (`jq empty`)

## Запуск рендерера

```bash
# Сохранить ответ ИИ в файл
# затем:
./tools/render_formula.sh --spec ./spec.json --out ./dist
```

## Что делает рендерер (не ИИ)

- Создаёт `<name>-formula/`
- Пишет FORMULA, pillar.example, map.jinja, init.sls, clean.sls
- Пишет package (+ repository при with_repo)
- Self-check: файлы существуют и не пустые
