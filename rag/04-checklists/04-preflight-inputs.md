---
product: osmax
doc_type: salt-formula-checklist
title: Preflight input checklist (JSON-first)
priority: 4
---

# Preflight input checklist

Before generating **JSON** (not a bash script), verify:

- Formula name provided?
- Name matches `^[a-zA-Z0-9_-]+$`?
- Target OS list provided or defaults accepted?
- Linux external repository needed? (`with_repo`)
- Windows requested? → default method **`winrepo`** (+ `winrepo_name`)
- If user asked chocolatey/installer — capture explicitly
- Summary and description present (or safe defaults)?
- Pattern clear: tpl-script / package+repo / package-only?

If any critical input is missing:
- Ask one concise clarification question.
- Do not generate partial JSON.

## Recommended defaults
- `with_repo=true` only when external vendor repo is required (browsers, etc.).
- `with_repo=false` for packages from OS repos (e.g. putty).
- `os_family`: Debian, RedHat, Windows for universal formulas.
- `windows.method`: **winrepo**.
- `release`: 1.
- Repo URLs: https from `12-repos-winrepo-pillar.md` (overridable via pillar).
