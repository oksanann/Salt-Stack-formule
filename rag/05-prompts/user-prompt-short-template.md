# User prompt: короткий шаблон (JSON)

Сгенерируй **только JSON-спецификацию** Salt-формулы по контракту 11-json-spec-contract.md.

Параметры:
- name: `<formula-name>`
- top_level_dir: `<formula-name>`
- os / os_family: `<Astra/ALT/Windows — нормализуй>`
- with_repo: `<true|false>`
- summary / description: `<на русском>`

Windows (если нужен):
- method: winrepo (по умолчанию)
- winrepo_name: `<имя в winrepo>`

Формат ответа:
1) одно предложение
2) блок ```json
3) команда:
   `./rag/tools/render_formula.sh --spec ./json-formula/<name>.json --out ./dist`
