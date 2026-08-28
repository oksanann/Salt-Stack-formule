# User prompt: Яндекс Браузер (JSON)

Сгенерируй **только JSON-спецификацию** Salt-формулы.

Задача:
- name: yandex-browser
- ОС: Astra Linux, ALT Linux, Windows
- with_repo: true
- Windows: winrepo (yandexbrowser)

Требования:
- Astra → Debian, ALT → RedHat
- pillar_lookup и map_defaults (default + Debian + RedHat + Windows)
- Repo/key Yandex — из 12-repos-winrepo-pillar.md
- Контракт: 11-json-spec-contract.md

Формат ответа:
1) одно предложение
2) блок ```json
3) команда:
   ./rag/tools/render_formula.sh --spec ./json-formula/yandex-browser.json --out ./dist
