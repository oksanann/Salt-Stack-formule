---
product: osmax
doc_type: salt-formula-prompt
title: User prompt шаблоны для генерации формул
priority: 5
---

# User prompt шаблоны

## Универсальный

```text
Напиши формулу Осмакс:
- имя: <my-formula>
- ОС: Linux | Windows | Linux+Windows
- задача: <описание>
- параметры lookup: <список полей>
- шаблон: tpl-script | tpl-group-members | tpl-shortcut | package | auto
- clean: да
- идемпотентность: да

Опирайся на правила create-formula и примеры tpl-*.
Верни полный набор файлов формулы.
```

## Скрипт

```text
Сгенерируй формулу типа tpl-script:
имя my-audit-script,
Linux,
скрипт пишет hostname и date в /var/local/my-audit-script.run.id,
повторный запуск запрещён unless,
clean удаляет маркер.
```

## Группы

```text
Сгенерируй формулу типа tpl-group-members:
имя my-ops-group,
группа ops,
change=add,
пользователи из lookup.users,
clean удаляет группу.
```

## Ярлык

```text
Сгенерируй формулу типа tpl-shortcut:
имя my-portal-shortcut,
Linux,
URL-ярлык на https://portal.example.com,
пользователи из lookup.user.usernames (если пусто — /home),
clean удаляет .desktop.
```

## Кроссплатформенный скрипт

```text
Сгенерируй формулу my-marker-script для Linux и Windows.
Linux: shell /bin/sh, маркер /var/local/my-marker-script.run.id
Windows: powershell, маркер C:\ProgramData\osmax\my-marker-script.run.id
Параметры через lookup, clean удаляет маркер на обеих ОС.
```
