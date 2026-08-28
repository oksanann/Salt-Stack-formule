# json-formula

Сюда сохраняются JSON-спецификации созданных формул.

Пример:
- `putty.json` — package
- `yandex-browser.json` — package + repo
- `nginx.json` — package
- `security-baseline.json` — `formula_kind: security-baseline`
- `vmware-horizon-client.json` — Omnissa Horizon Client (Linux mirror via pillar + Windows winrepo)

Сборка формулы из JSON:

```bash
./rag/tools/render_formula.sh --spec ./json-formula/<name>.json --out ./dist
```
