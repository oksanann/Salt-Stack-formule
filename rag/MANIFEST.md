# Манифест файлов для загрузки в RAG

Базовый путь: `rag/`

| path | doc_type | priority | chunk_hint |
|------|----------|----------|------------|
| 01-rules/01-structure.md | salt-formula-rules | 1 | by H2 |
| 01-rules/02-formula-metadata.md | salt-formula-rules | 1 | by H2 |
| 01-rules/03-states-model.md | salt-formula-rules | 1 | by H2/H3 |
| 01-rules/04-pillar-and-tplroot.md | salt-formula-rules | 1 | by H2 |
| 01-rules/05-secrets.md | salt-formula-rules | 1 | whole/small |
| 01-rules/07-os-specific-mapping.md | salt-formula-rules | 1 | by H2 |
| 01-rules/08-bash-generator-contract.md | salt-formula-rules | 1 | DO NOT CHUNK |
| 01-rules/09-output-format-policy.md | salt-formula-rules | 1 | DO NOT CHUNK |
| 01-rules/10-bash-generator-reference.md | salt-formula-rules | 1 | DO NOT CHUNK |
| 01-rules/11-json-spec-contract.md | salt-formula-rules | 1 | DO NOT CHUNK |
| 01-rules/12-repos-winrepo-pillar.md | salt-formula-rules | 1 | DO NOT CHUNK |
| 01-rules/06-python-builder-output.md | salt-formula-rules | 1 | by H2 |
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
| 05-prompts/system-prompt-json-spec.txt | System message (рекомендуется) |
| 05-prompts/user-prompt-json-yandex-browser.md | User: Яндекс Браузер |
| 05-prompts/user-prompt-templates.md | User templates |

Полный порядок: `UPLOAD-ORDER.txt`. Инструкция: `UPLOAD-PACK.md`.
