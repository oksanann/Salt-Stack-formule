# Манифест файлов для загрузки в RAG

Базовый путь: `documents/` (относительно `for-rag-upload/`)

Полная инструкция: **UPLOAD-PACK.md**  
Плоский список: **UPLOAD-ORDER.txt**

| path | doc_type | priority | chunk_hint |
|------|----------|----------|------------|
| documents/01-rules/01-structure.md | salt-formula-rules | 1 | by H2 |
| documents/01-rules/02-formula-metadata.md | salt-formula-rules | 1 | by H2 |
| documents/01-rules/03-states-model.md | salt-formula-rules | 1 | by H2/H3 |
| documents/01-rules/04-pillar-and-tplroot.md | salt-formula-rules | 1 | by H2 |
| documents/01-rules/05-secrets.md | salt-formula-rules | 1 | whole/small |
| documents/01-rules/07-os-specific-mapping.md | salt-formula-rules | 1 | by H2 |
| documents/01-rules/08-bash-generator-contract.md | salt-formula-rules | 1 | DO NOT CHUNK |
| documents/01-rules/09-output-format-policy.md | salt-formula-rules | 1 | DO NOT CHUNK |
| documents/01-rules/06-python-builder-output.md | salt-formula-rules | 1 | by H2 |
| documents/02-templates/00-overview.md | salt-formula-example | 2 | whole |
| documents/02-templates/01-state-id-naming.md | salt-formula-example | 2 | whole |
| documents/02-templates/02-linux-windows.md | salt-formula-example | 2 | by H2 |
| documents/03-examples/finalized/00-overview.md | salt-formula-example | 3 | whole |
| documents/03-examples/finalized/01-pattern-package-repo.md | salt-formula-example | 3 | by H2 |
| documents/03-examples/finalized/07-yandex-browser.md | salt-formula-example | 3 | whole |
| documents/03-examples/finalized/05-google-chrome.md | salt-formula-example | 3 | whole |
| documents/03-examples/finalized/06-google-chrome-reboot.md | salt-formula-example | 3 | whole |
| documents/03-examples/finalized/02-agent-update.md | salt-formula-example | 3 | whole |
| documents/03-examples/finalized/03-get-hostname.md | salt-formula-example | 3 | whole |
| documents/03-examples/finalized/04-file-find.md | salt-formula-example | 3 | by H2 |
| documents/03-examples/finalized/08-pattern-remote-access.md | salt-formula-example | 3 | by H2 |
| documents/03-examples/finalized/09-remote-access-groups-xrdp.md | salt-formula-example | 3 | by H2 |
| documents/03-examples/finalized/10-remote-access-groups-tigervnc.md | salt-formula-example | 3 | by H2 |
| documents/03-examples/01-tpl-script.md | salt-formula-example | 3 | code blocks separate |
| documents/03-examples/02-tpl-group-members.md | salt-formula-example | 3 | code blocks separate |
| documents/03-examples/03-tpl-shortcut.md | salt-formula-example | 3 | code blocks separate |
| documents/03-examples/04-remote-access-groups-ssh.md | salt-formula-example | 3 | by H2 |
| documents/04-checklists/01-validation-checklist.md | salt-formula-checklist | 4 | whole |
| documents/04-checklists/02-anti-patterns.md | salt-formula-checklist | 4 | by H2 |
| documents/04-checklists/03-generation-flow.md | salt-formula-checklist | 4 | whole |
| documents/04-checklists/04-preflight-inputs.md | salt-formula-checklist | 4 | whole |
| documents/04-checklists/05-postgen-smoke-test.md | salt-formula-checklist | 4 | whole |

## Промпты (НЕ в RAG)

| path | purpose |
|------|---------|
| prompts/system-prompt-bash-generator.txt | **System message (рекомендуется)** |
| prompts/system-prompt-salt-formulas-v2.md | System message (markdown) |
| prompts/system-prompt.txt | System message (Python-режим, legacy) |
| prompts/user-prompt-yandex-browser.md | User prompt: Яндекс Браузер |
| prompts/user-prompt-short-template.md | User prompt: короткий шаблон |
| prompts/user-prompt-templates.md | User prompt: расширенные шаблоны |

## Рекомендуемые фильтры retrieval

```text
filter: product=osmax AND doc_type IN (salt-formula-rules, salt-formula-example, salt-formula-checklist)
boost: priority ASC (меньший номер — выше приоритет)
top_k: 6–8
```

### Boost по типу запроса

| Запрос | Boost |
|--------|-------|
| Браузер / repo / key | finalized/01-pattern-package-repo, 07-yandex-browser, 05-google-chrome |
| SSH / RDP / VNC | finalized/08-pattern-remote-access, 09-*, 10-* |
| Astra / ALT / Windows | 07-os-specific-mapping, 02-linux-windows |
| Bash-скрипт | 08-bash-generator-contract, 09-output-format-policy |

System prompt подключайте отдельно, не через similarity search.
