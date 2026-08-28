# 01-rules

Правила для RAG и генерации JSON-спек. **Только JSON-first.**

| # | Файл | Назначение |
|---|------|------------|
| 00 | `00-overview.md` | Карта папки, пайплайн |
| 01 | `01-structure.md` | Структура `<name>-formula/` |
| 02 | `02-formula-metadata.md` | FORMULA |
| 03 | `03-states-model.md` | apply/clean, package, security-baseline |
| 04 | `04-pillar-and-tplroot.md` | pillar lookup, tplroot |
| 05 | `05-secrets.md` | Секреты |
| 07 | `07-os-specific-mapping.md` | Astra/ALT/Windows |
| 09 | `09-json-output-policy.md` | Формат ответа ИИ |
| **11** | **`11-json-spec-contract.md`** | **Контракт JSON** |
| **12** | **`12-repos-winrepo-pillar.md`** | **Repo, winrepo, pillar** |

Загрузка в RAG: порядок в `../UPLOAD-ORDER.txt`.

Удалено (legacy): `06-python-builder-output.md`, `08-bash-generator-contract.md`, `09-output-format-policy.md`, `10-bash-generator-reference.md`.
