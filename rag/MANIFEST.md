# Манифест файлов для загрузки в RAG

Используйте этот список как inventory при индексации.

| path | doc_type | priority | chunk_hint |
|------|----------|----------|------------|
| rag/01-rules/01-structure.md | salt-formula-rules | 1 | by H2 |
| rag/01-rules/02-formula-metadata.md | salt-formula-rules | 1 | by H2 |
| rag/01-rules/03-states-model.md | salt-formula-rules | 1 | by H2/H3 |
| rag/01-rules/04-pillar-and-tplroot.md | salt-formula-rules | 1 | by H2 |
| rag/01-rules/05-secrets.md | salt-formula-rules | 1 | whole/small |
| rag/02-templates/00-overview.md | salt-formula-example | 2 | whole |
| rag/02-templates/01-state-id-naming.md | salt-formula-example | 2 | whole |
| rag/02-templates/02-linux-windows.md | salt-formula-example | 2 | by H2 |
| rag/03-examples/01-tpl-script.md | salt-formula-example | 3 | code blocks separate |
| rag/03-examples/02-tpl-group-members.md | salt-formula-example | 3 | code blocks separate |
| rag/03-examples/03-tpl-shortcut.md | salt-formula-example | 3 | code blocks separate |
| rag/03-examples/04-remote-access-groups-ssh.md | salt-formula-example | 3 | by H2 |
| rag/03-examples/finalized/00-overview.md | salt-formula-example | 3 | whole |
| rag/03-examples/finalized/01-pattern-package-repo.md | salt-formula-example | 3 | by H2 |
| rag/03-examples/finalized/02-agent-update.md | salt-formula-example | 3 | whole |
| rag/03-examples/finalized/03-get-hostname.md | salt-formula-example | 3 | whole |
| rag/03-examples/finalized/04-file-find.md | salt-formula-example | 3 | by H2 |
| rag/03-examples/finalized/05-google-chrome.md | salt-formula-example | 3 | whole |
| rag/03-examples/finalized/06-google-chrome-reboot.md | salt-formula-example | 3 | whole |
| rag/03-examples/finalized/07-yandex-browser.md | salt-formula-example | 3 | whole |
| rag/03-examples/finalized/08-pattern-remote-access.md | salt-formula-example | 3 | by H2 |
| rag/03-examples/finalized/09-remote-access-groups-xrdp.md | salt-formula-example | 3 | by H2 |
| rag/03-examples/finalized/10-remote-access-groups-tigervnc.md | salt-formula-example | 3 | by H2 |
| rag/04-checklists/01-validation-checklist.md | salt-formula-checklist | 4 | whole |
| rag/04-checklists/02-anti-patterns.md | salt-formula-checklist | 4 | by H2 |
| rag/05-prompts/system-prompt-salt-formulas.md | salt-formula-prompt | 5 | DO NOT CHUNK |
| rag/05-prompts/user-prompt-templates.md | salt-formula-prompt | 5 | by H2 |

## Рекомендуемые фильтры retrieval

При генерации формулы:

```text
filter: product=osmax AND doc_type IN (salt-formula-rules, salt-formula-example, salt-formula-checklist)
boost: priority ASC (меньший номер — выше приоритет)
top_k: 6–8
```

При запросах про браузеры / repo / reboot — дополнительно boost `finalized/01-pattern-package-repo` и `google-chrome`/`yandex-browser`.

При запросах про SSH/RDP/VNC — boost `finalized/08-pattern-remote-access` и соответствующую формулу.

System prompt (`05-prompts/system-prompt-salt-formulas.md`) подключайте отдельно, не через similarity search.
