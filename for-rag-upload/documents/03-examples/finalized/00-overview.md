---
product: osmax
doc_type: salt-formula-example
title: Обзор готовых формул Осмакс
source_url: https://docs.inno.tech/ru/linux-configuration-manager/latest/maintenance-guide/saltstack/salt-formulas/finalized-formulas/finalized-formulas-overview/
priority: 3
---

# Готовые формулы Осмакс

Готовые формулы загружены на Salt master и работают с настройками по умолчанию. Параметры можно переопределить через `lookup` в pillar (см. `pillar.example` каждой формулы).

## Каталог (для выбора паттерна ИИ)

| Формула | Тип паттерна | Назначение |
|---------|--------------|------------|
| `agent-update` | package | Переустановка salt-minion |
| `get-hostname` | script + systemd service | Скрипт + сервис, clean удаляет файлы/сервис |
| `file-find` | dynamic lookup tasks | Инвентаризация файлов через `module.run` |
| `google-chrome` | package + repository | Установка браузера из внешнего repo |
| `google-chrome-reboot` | package + repository + reboot | Chrome + опциональная перезагрузка |
| `yandex-browser` | package + repository | Установка Яндекс Браузера |
| `remote-access-groups-ssh` | package + config + service | SSH-доступ с группами/IP |
| `remote-access-groups-xrdp` | package + config + service | xRDP-доступ (Astra + xorg) |
| `remote-access-groups-tigervnc` | package + config + service | TigerVNC-доступ |

## Как выбирать паттерн при генерации новой формулы

1. Нужен только пакет → `agent-update`
2. Нужен внешний apt-репозиторий + пакет + clean → `google-chrome` / `yandex-browser`
3. Нужен пакет + конфиги + сервис + clean → `remote-access-groups-*`
4. Нужен одноразовый/сервисный скрипт → `get-hostname` (или tpl-script)
5. Нужен набор динамических задач из pillar → `file-find`
6. После установки нужна reboot → `google-chrome-reboot`

## Общее правило UI

В «Кабинете администратора» в JSON pillar указывают только содержимое `lookup` (без имени формулы). Имя формулы добавляется системой автоматически.
