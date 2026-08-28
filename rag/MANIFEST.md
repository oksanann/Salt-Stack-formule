# Манифест файлов для загрузки в RAG

Базовый путь: `rag/`

| path | doc_type | priority | chunk_hint |
|------|----------|----------|------------|
| 01-rules/00-overview.md | salt-formula-rules | 1 | DO NOT CHUNK |
| 01-rules/01-structure.md | salt-formula-rules | 1 | by H2 |
| 01-rules/02-formula-metadata.md | salt-formula-rules | 1 | by H2 |
| 01-rules/03-states-model.md | salt-formula-rules | 1 | by H2/H3 |
| 01-rules/04-pillar-and-tplroot.md | salt-formula-rules | 1 | by H2 |
| 01-rules/05-secrets.md | salt-formula-rules | 1 | whole/small |
| 01-rules/07-os-specific-mapping.md | salt-formula-rules | 1 | by H2 |
| 01-rules/09-json-output-policy.md | salt-formula-rules | 1 | DO NOT CHUNK |
| 01-rules/11-json-spec-contract.md | salt-formula-rules | 1 | DO NOT CHUNK |
| 01-rules/12-repos-winrepo-pillar.md | salt-formula-rules | 1 | DO NOT CHUNK |
| 02-templates/00-overview.md | salt-formula-example | 2 | whole |
| 02-templates/01-state-id-naming.md | salt-formula-example | 2 | whole |
| 02-templates/02-linux-windows.md | salt-formula-example | 2 | by H2 |
| 03-examples/finalized/* | salt-formula-example | 3 | by file |
| 03-examples/01-tpl-script.md | salt-formula-example | 3 | code blocks |
| 03-examples/02-tpl-group-members.md | salt-formula-example | 3 | code blocks |
| 03-examples/03-tpl-shortcut.md | salt-formula-example | 3 | code blocks |
| 03-examples/04-remote-access-groups-ssh.md | salt-formula-example | 3 | by H2 |
| 04-checklists/* | salt-formula-checklist | 4 | whole |

## Промпты (НЕ в RAG)

| path | purpose |
|------|---------|
| **05-prompts/system-prompt-json-spec.txt** | **Единственный** system message (JSON-first) |
| 05-prompts/user-prompt-short-template.md | User: короткий шаблон |
| 05-prompts/user-prompt-templates.md | User: шаблоны (package, repo, security-baseline…) |
| 05-prompts/user-prompt-yandex-browser.md | User: пример Яндекс Браузер |
| 05-prompts/README.md | Описание папки промптов |

Legacy bash/Python system prompts удалены.

Полный порядок: `UPLOAD-ORDER.txt`. Инструкция: `UPLOAD-PACK.md`.
