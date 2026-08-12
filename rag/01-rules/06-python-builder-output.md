---
product: osmax
doc_type: salt-formula-rules
title: Формат ответа ИИ — Python-сборщик формулы
priority: 1
---

# Формат ответа ИИ: Python-скрипт сборки формулы

ИИ не должен отдавать формулу как список файлов для ручного копирования.

## Ожидаемый артефакт

Один скрипт Python 3:

```text
build_<formula_name>_formula.py
```

После запуска он создаёт:

```text
<out>/<top_level_dir>-formula/
  <top_level_dir>/
    init.sls
    clean.sls
    map.jinja
    ...
  FORMULA
  pillar.example
  docs/...
```

## Минимальный каркас сборщика

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from __future__ import annotations

import argparse
from pathlib import Path

FORMULA_NAME = "my-script"
ROOT_DIR_NAME = f"{FORMULA_NAME}-formula"

FILES: dict[str, str] = {
    f"{FORMULA_NAME}/init.sls": """\
# -*- coding: utf-8 -*-
# vim: ft=sls
...
""",
    f"{FORMULA_NAME}/clean.sls": """\
...
""",
    "FORMULA": """\
name: my-script
...
""",
    "pillar.example": """\
my-script:
  lookup:
    ...
""",
}


def build(out_dir: Path) -> Path:
    root = out_dir / ROOT_DIR_NAME
    for rel, content in FILES.items():
        path = root / rel
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")
    return root


def main() -> None:
    parser = argparse.ArgumentParser(description=f"Build Osmax formula {FORMULA_NAME}")
    parser.add_argument("--out", type=Path, default=Path("."), help="Output directory")
    args = parser.parse_args()
    root = build(args.out.resolve())
    print(f"Formula created: {root}")
    for p in sorted(root.rglob("*")):
        if p.is_file():
            print(f"  {p.relative_to(root)}")


if __name__ == "__main__":
    main()
```

## Правила для ИИ

1. Весь контент формулы внутри `FILES` (или аналога).
2. Только стандартная библиотека Python.
3. UTF-8, `pathlib`, argparse `--out`.
4. Повторный запуск перезаписывает файлы формулы.
5. Не выполнять shell/network.
6. В ответе: краткое описание + скрипт + пример запуска + lookup JSON + чеклист.
