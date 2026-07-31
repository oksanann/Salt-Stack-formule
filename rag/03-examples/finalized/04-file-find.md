---
product: osmax
doc_type: salt-formula-example
title: Готовая формула file-find
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/file-find-formula/
template: finalized
priority: 3
---

# Формула file-find

Назначение: файловая инвентаризация через модуль `file.find` / `file_find.find_formatted`.

## Состояния

- `file-find.run` — для каждого правила в `lookup` создаёт `module.run` с вызовом `file_find.find_formatted`

## Тип pillar: динамические задачи (тип B)

Каждый ключ в `lookup` — отдельное правило поиска. Имя ключа произвольное, но уникальное.

Обязательный параметр правила: `path`.

## Поддерживаемые параметры правила

| Параметр | Описание | Пример |
|----------|----------|--------|
| `path` | Корневой путь (обязательный) | `/var/log` |
| `name` | Glob имени (case-sensitive) | `*.log` |
| `iname` | Glob имени (case-insensitive) | `*.LOG` |
| `regex` / `iregex` | Regex имени | `^access\.log\.\d+$` |
| `type` | Тип: a/b/c/d/f/l/p/s | `f` |
| `user`/`owner`, `group` | Владелец/группа | `root` |
| `size` | `[+-]number[kMG]` | `+10k` |
| `mtime` | `[+-][number][wdhms]` | `-1d` |
| `maxdepth` / `mindepth` | Глубина | `3` |
| `md5` | Вернуть MD5 | `true` |

## Сокращённый pillar.example

```yaml
file_find:
  version_id: 20241128
  lookup:
    logs_recent:
      path: /var/log
      name: "*.log"
      type: f
      mtime: -1d
      size: +10k
      md5: true
    configs_root:
      path: /etc
      owner: root
      type: f
      name: "*.conf"
      maxdepth: 1
    ssh_find:
      path: /home
      name: "id_*"
      type: f
      iname: "*.pub"
      mindepth: 1
      maxdepth: 3
```

## Выводы для генерации

- Не используйте map.jinja-defaults как единственный источник — задачи живут в lookup.
- Состояние `run` динамически разворачивает подсостояния.
- Имя директории формулы = ключ pillar (`file-find` / в примере также `file_find`).
- Для дублирования правил на одном устройстве нужна копия формулы с другим именем.
