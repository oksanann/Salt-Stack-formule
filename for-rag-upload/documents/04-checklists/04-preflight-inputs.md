# Preflight input checklist

Before generating the script, verify:

- Formula name provided?
- Name matches `^[a-zA-Z0-9_-]+$`?
- Target OS list provided or defaults accepted?
- Linux repository flow required?
- Windows install strategy chosen?
- Summary and description present (or safe defaults applied)?

If any critical input is missing:
- Ask one concise clarification question.
- Do not generate partial script.

## Recommended defaults
- `--with-repo=true` for package formulas that need external repo.
- `os_family=Debian,RedHat,Windows` for universal formulas.
- `release=1`.
