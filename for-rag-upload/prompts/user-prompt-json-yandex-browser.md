# User prompt: JSON-спецификация формулы

Сгенерируй ТОЛЬКО JSON-спецификацию Salt-формулы (не bash, не Python, не список файлов).

Задача:
- name: yandex-browser
- ОС: Astra Linux, ALT Linux, Windows
- with_repo: true
- Windows: winrepo (yandexbrowser); chocolatey/installer — только если явно нужно

Требования:
- Astra → Debian, ALT → RedHat
- Заполни pillar_lookup и map_defaults (default + Debian + RedHat + Windows)
- В repo укажи официальный Yandex Browser repo/key
- Опирайся на 11-json-spec-contract.md и пример yandex-browser

Формат ответа:
1) одно предложение
2) блок ```json
3) команда:
   ./tools/render_formula.sh --spec ./yandex-browser.json --out ./dist
