# RAG-корпус: формулы Salt для Осмакс

Набор документов для загрузки в RAG-систему сценария «ИИ пишет формулы Salt Stack для Осмакс».

## Источники

- [Принципы написания формулы](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/work-with-formulas/create-formula/)
- [Формулы-шаблоны (overview)](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/example-formulas/example-formulas-overview/)
- [tpl-script-formula](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/example-formulas/tpl-script/tpl-script-formula/)
- [tpl-group-members-formula](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/example-formulas/tpl-group-members/tpl-group-members-formula/)
- [tpl-shortcut-formula](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/example-formulas/tpl-shotrcut/tpl-shortcut-formula/)
- [Готовые формулы (overview)](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/finalized-formulas-overview/)
- [agent-update](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/agent-update-formula/)
- [get-hostname](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/get-hostname-formula/)
- [file-find](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/file-find-formula/)
- [google-chrome](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/google-chrome-formula/)
- [google-chrome-reboot](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/google-chrome-reboot-formula/)
- [yandex-browser](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/yandex-browser-formula/)
- [remote-access-groups-ssh](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/remote-access-groups-ssh-formula/)
- [remote-access-groups-xrdp](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/remote-access-groups-xrdp-formula/)
- [remote-access-groups-tigervnc](https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/remote-access-groups-tigervnc-formula/)

## Структура для индексации

```
rag/
  01-rules/          # обязательные правила (приоритет №1)
  02-templates/      # выбор шаблона и паттерны
  03-examples/       # few-shot: tpl-* + finalized/
  04-checklists/     # валидация результата
  05-prompts/        # system prompt для LLM
```

## Приоритет retrieval

При конфликте правил:

1. `01-rules/*` (create-formula)
2. `02-templates/*` и `03-examples/*`
3. Общие знания Salt Stack

## Рекомендации по чанкингу

| Документ | Стратегия |
|----------|-----------|
| `01-rules/*` | по H2/H3, overlap 10–15% |
| `03-examples/*` | один пример кода = один чанк + соседний текст |
| `05-prompts/*` | не дробить system prompt; хранить целиком |

## Метаданные для индекса

Для каждого файла задайте:

- `product`: `osmax`
- `doc_type`: `salt-formula-rules` | `salt-formula-example` | `salt-formula-checklist` | `salt-formula-prompt`
- `language`: `ru`
- `source_url`: URL из frontmatter файла
- `priority`: `1` (rules) … `5` (prompts)

## Как использовать

1. Загрузите все `.md` из `rag/` в векторную БД.
2. В AI Gateway при `mode=salt-formula` фильтруйте коллекцию `osmax-salt-formulas`.
3. В system prompt подставляйте retrieved top-K (обычно 5–8 чанков) + полный `05-prompts/system-prompt-salt-formulas.md`.
