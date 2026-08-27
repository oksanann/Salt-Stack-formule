# json-formula

Сюда сохраняются JSON-спецификации созданных формул.

Пример:
- `putty.json`
- `yandex-browser.json`
- `nginx.json`

Сборка формулы из JSON:

```bash
./rag/tools/render_formula.sh --spec ./json-formula/<name>.json --out ./dist
```
