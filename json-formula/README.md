# json-formula

Сюда сохраняются JSON-спецификации созданных формул.

Пример:
- `putty.json` — package
- `yandex-browser.json` — package + repo
- `nginx.json` — package
- `security-baseline.json` — `formula_kind: security-baseline`

Сборка формулы из JSON:

```bash
./rag/tools/render_formula.sh --spec ./json-formula/<name>.json --out ./dist
```
