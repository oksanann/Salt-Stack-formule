---
product: osmax
doc_type: salt-formula-prompt
title: User prompt шаблоны (JSON-first)
priority: 5
---

# User prompt шаблоны

Все ответы — **только JSON** + команда render_formula.sh.  
Эталоны: `examples/specs/`, контракт: `11-json-spec-contract.md`.

## Универсальный (package)

```text
Сгенерируй JSON-спецификацию Salt-формулы:
- name: <my-formula>
- ОС: Linux | Windows | Linux+Windows
- with_repo: true | false
- задача: <что устанавливаем / настраиваем>
- pillar_lookup: <ключевые поля pkg, repo, windows>

Astra → Debian, ALT → RedHat.
Windows default: winrepo.

Ответ: 1 предложение + ```json + команда render_formula.sh
```

## Простой пакет без repo (как putty)

```text
JSON-спека формулы putty:
- Linux (Astra/ALT) + Windows
- with_repo: false
- Linux: pkg из штатных repo ОС
- Windows: winrepo_name putty

Сохраню в json-formula/putty.json и соберу через render_formula.sh
```

## Пакет + внешний repo (как yandex-browser)

```text
JSON-спека yandex-browser:
- Astra, ALT, Windows
- with_repo: true
- Official Yandex repo/key из 12-repos-winrepo-pillar.md
- pillar lookup.repo можно переопределить mirror

См. user-prompt-yandex-browser.md
```

## Security baseline (formula_kind)

```text
JSON-спека security-baseline:
- formula_kind: security-baseline
- os: linux only (Debian, RedHat)
- with_repo: false
- ssh, sysctl, services, packages + toggles в pillar_lookup

См. examples/specs/security-baseline.json
```

## Корпоративное ПО без публичного repo (Horizon Client)

```text
JSON-спека vmware-horizon-client:
- Linux + Windows
- with_repo: true, repo.name пустой — mirror задаётся в pillar
- Windows: winrepo omnissa-horizon-client

См. examples/specs/vmware-horizon-client.json
```
