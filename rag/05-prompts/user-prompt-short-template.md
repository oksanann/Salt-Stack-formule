# User prompt short template

Сгенерируй один полный bash-скрипт для создания Salt-формулы.

Параметры:
- name: <formula-name>
- targets: <Astra Linux/ALT Linux/Windows>
- with_repo: <true|false>
- windows_strategy: <win_pkg|msi|cmd.run>
- summary: <short summary>
- description: <detailed description>

Ограничения:
- Соблюдай структуру `<top_level_dir>-formula` и обязательные файлы.
- Включи `map.jinja` и поддержку `lookup` через pillar.
- Используй `date +%Y%m` для FORMULA version.
- Добавь self-check в конце скрипта.
