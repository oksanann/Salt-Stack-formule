---
product: osmax
doc_type: salt-formula-rules
title: Репозитории, pillar override и Windows winrepo
priority: 1
chunk: none
---

# Репозитории, переопределение через pillar и Windows winrepo

## 1. Рабочие URL в примерах (проверено)

Используйте **актуальные официальные** ссылки. Предпочитайте `https://`.

### Yandex Browser

| Назначение | Рабочий URL |
|------------|-------------|
| Корень | `https://repo.yandex.ru/yandex-browser/` |
| Ключ GPG | `https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG` |
| Debian/Astra (apt line) | `deb https://repo.yandex.ru/yandex-browser/deb stable main` |
| RedHat/Fedora (baseurl) | `https://repo.yandex.ru/yandex-browser/rpm/stable/$basearch/` |
| ALT Linux (baseurl) | `https://repo.yandex.ru/yandex-browser/alt/$basearch/` |

Правила для Yandex apt:
- компонент **только `main`** (не `main,contrib,non-free`);
- схема **https**, не http;
- пакет: `yandex-browser-stable`.

### Google Chrome

| Назначение | Рабочий URL |
|------------|-------------|
| Ключ | `https://dl.google.com/linux/linux_signing_key.pub` |
| Debian apt line | `deb https://dl.google.com/linux/chrome/deb/ stable main` |

Пакет: `google-chrome-stable`.

### Запрещено в примерах

- placeholder `https://example/KEY.GPG` в production-примерах (только в абстрактном шаблоне с пометкой «заглушка»);
- `http://repo.yandex.ru/...` без https;
- `comps: main,contrib,non-free` для Yandex Browser.

## 2. Pillar может передать другой репозиторий

`map.jinja` задаёт defaults. **Любой** ключ `repo.*` и `pkg.*` переопределяется через:

```yaml
<formula-name>:
  lookup:
    pkg:
      name: yandex-browser-stable
      version: ''
      fromrepo: 'stable'
    repo:
      # другой / внутренний mirror вместо defaults
      name: 'deb https://mirror.company.local/yandex-browser/deb stable main'
      disabled: False
      comps: 'main'
      conf_name: 'yandex-browser'
      key_file: 'https://mirror.company.local/yandex-browser/YANDEX-BROWSER-KEY.GPG'
      key_file_dearmor: True
      key_keyrings_dir: '/etc/apt/keyrings/'
      required_packages: [ 'gpg' ]
      file: '/etc/apt/sources.list.d/yandex-browser.list'
      humanname: 'Yandex Browser'
```

Правила:

1. Merge всегда: `merge=salt['pillar.get']('<name>:lookup')`.
2. Если в pillar задан `repo.name` — используется **он**, а не default из map.jinja.
3. Пустой `repo.name` (`''`) — репозиторий **не** импортируется (пакет из уже настроенных источников ОС).
4. Для RedHat/ALT в pillar можно подменить `repo.name` на ALT-mirror:
   `https://repo.yandex.ru/yandex-browser/alt/$basearch/`
   или корпоративный mirror.
5. `pillar.example` **обязан** показывать, что `repo.*` переопределяемы.

## 3. Windows: установка из winrepo

На Windows формула должна поддерживать метод **`winrepo`** (Salt Windows Software Repository / `pkg.installed` через winrepo), наряду с `chocolatey` и `installer`.

### Выбор метода

```yaml
lookup:
  windows:
    # winrepo | chocolatey | installer
    method: winrepo
    # имя пакета в winrepo (для pkg.installed на Windows)
    winrepo_name: putty
    # альтернативы:
    chocolatey_name: putty
    installer_url: ''
    installer_path: 'C:\\Windows\\Temp\\putty-setup.exe'
    install_args: '/S'
    uninstall_name: 'PuTTY'
```

### Логика package на Windows

```jinja
{%- set win = cfg.get('windows', {}) %}
{%- set method = win.get('method', 'winrepo') %}

{%- if method == 'winrepo' %}
pkg.installed:
  - name: {{ win.get('winrepo_name', cfg.pkg.name) }}
{%- elif method == 'chocolatey' %}
chocolatey.installed:
  - name: {{ win.get('chocolatey_name', cfg.pkg.name) }}
{%- elif method == 'installer' and win.get('installer_url') %}
# file.managed + cmd.run silent installer
{%- endif %}
```

### Требования к окружению winrepo

- На master настроен Salt winrepo (`winrepo_dir` / `salt-run winrepo.update_git_repos` по политике площадки).
- Пакет с именем `windows.winrepo_name` есть в winrepo.
- Minion Windows получает обновлённый cache (`pkg.refresh_db` при необходимости).

### Defaults

- Для универсальных формул default Windows method: **`winrepo`** (предпочтительно в Осмакс/Salt), если пользователь не указал иначе.
- `chocolatey` и `installer` — допустимые альтернативы через pillar.
- Clean для winrepo: `pkg.removed` с тем же `winrepo_name`.

## 4. Минимальный pillar.example для package+repo+Windows

```yaml
my-app:
  lookup:
    pkg:
      name: my-app
      version: ''
    repo:
      name: 'deb https://official.example/repo stable main'  # можно заменить mirror
      key_file: 'https://official.example/KEY.GPG'
      conf_name: 'my-app'
      comps: 'main'
      key_file_dearmor: True
      key_keyrings_dir: '/etc/apt/keyrings/'
      required_packages: [ 'gpg' ]
    windows:
      method: winrepo
      winrepo_name: my-app
```
