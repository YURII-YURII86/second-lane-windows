# Roadmap

Secondary LANE by **Yurii Slepnev** · Apache-2.0  
Telegram: https://t.me/yurii_yurii86 · YouTube: https://youtube.com/@yurii_yurii86 · Instagram: https://instagram.com/yurii_yurii86

## RU

### Текущий фокус

Сейчас Secondary LANE сосредоточен на:

- работе через ChatGPT + Custom GPT + GPT Actions как главный интерфейс выполнения
- работе с локальными проектами через контролируемый daemon
- сильных сценариях разработки: inspect, patch, test, run, verify
- памяти проекта через `.ai_context/`
- нативном Windows-сценарии как основном операторском пути (Python 3.13 + PowerShell + ngrok)

### Ближайшие приоритеты

#### 1. Упаковка запуска на GitHub

- ещё сильнее дожать README
- добавить demo-материалы
- оформить более ясные метаданные репозитория

#### 2. Более удобный операторский контур

- сделать запуск и остановку daemon более гладкими
- улучшить диагностику tunnel
- сделать сообщения о восстановлении понятнее

#### 3. Качество GPT-facing actions

- держать компактную GPT-схему сильной и сфокусированной
- улучшать самые ценные workflow-actions
- не раздувать GPT Actions слабыми удобными, но бесполезными endpoint'ами

#### 4. Больше доказательств и тестов

- усилить smoke-проверки для основного GPT-сценария
- добавить больше regression-тестов на уровне actions
- улучшить проверку корректности setup

### Более дальние приоритеты

#### 1. Поддержка macOS и Linux

- адаптация launcher для macOS и Linux
- daemon и tunnel flow для других ОС
- финальная шлифовка setup

#### 2. Более сильные демо и публичные примеры

- больше записанных сценариев
- публичные walkthrough в формате “от лимита до готового результата”

### Что сейчас не является целью

- становиться полной заменой IDE
- превращаться в hosted SaaS
- превращаться в общий framework для browser automation

## EN

### Current Scope

Secondary LANE currently focuses on:

- ChatGPT + Custom GPT + GPT Actions as the main execution interface
- local machine project work through a controlled daemon
- stronger coding workflows such as inspect, patch, test, run, verify
- durable project memory through `.ai_context/`
- native Windows operator flow as the primary supported path (Python 3.13 + PowerShell + ngrok)

### Near-Term Priorities

#### 1. GitHub launch packaging

- tighten README further
- add demo assets
- publish clearer repo metadata

#### 2. Better operator UX

- smoother daemon start/stop path
- clearer tunnel diagnostics
- better recovery messaging

#### 3. GPT-facing action quality

- keep the compact GPT schema strong and focused
- improve high-value workflow actions
- avoid bloating GPT Actions with weak convenience endpoints

#### 4. More proof and testing

- stronger smoke coverage for the main GPT flow
- more action-level regression tests
- clearer setup validation

### Later Priorities

#### 1. macOS and Linux support

- adapt the launcher for macOS and Linux
- daemon and tunnel flow for other operating systems
- setup polish

#### 2. Better demos and public examples

- more recorded scenarios
- public “from limit to finish” walkthroughs

### Non-Goals Right Now

- becoming a full IDE replacement
- becoming a hosted SaaS
- turning into a generic browser automation framework
