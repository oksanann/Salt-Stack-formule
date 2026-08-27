---
product: osmax
doc_type: salt-formula-checklist
title: Generation flow checklist (JSON-first)
priority: 4
---

# Generation flow checklist

Текущий пайплайн для каждого запроса:

```text
User → LLM (JSON only) → spec.json → render_formula.sh → <name>-formula/
```

## Step 1: parse request
- Extract formula name.
- Extract target OS list (Astra/ALT/Windows → normalize).
- Determine `with_repo` (external repo needed?).
- Determine Windows method: default **`winrepo`** (unless user asks chocolatey/installer).
- Choose pattern: `tpl-*` vs package/repo finalized.

## Step 2: normalize targets
- Astra Linux → Debian.
- ALT Linux → RedHat (prefer ALT Yandex URL when applicable).
- Windows → Windows + `os` includes `windows`.

## Step 3: build JSON spec
- Fill required fields: name, top_level_dir, os, os_family, summary, description, with_repo, pillar_lookup, map_defaults.
- Include `repo.*` when `with_repo=true` (overridable via pillar).
- Include `windows.method` / `winrepo_name` when Windows requested.
- Use working `https://` URLs from `12-repos-winrepo-pillar.md`.

## Step 4: return answer
- One short sentence.
- One ```json block only.
- Render command:
  `./tools/render_formula.sh --spec ./spec.json --out ./dist`

## Step 5: user renders
- Save JSON as UTF-8 text (`jq empty spec.json`).
- Run renderer (requires `jq`).
- Check smoke-test checklist (`05-postgen-smoke-test.md`).

## Do not
- Generate bash/Python builder in JSON mode.
- Skip self-check after render.
