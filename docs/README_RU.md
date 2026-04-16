# Secondary LANE | Версия для Windows

**Вторая линия для твоего вайбкодинга.**

Secondary LANE даёт ChatGPT реальные действия на твоей машине: смотреть код, править файлы, запускать тесты, поднимать сервисы, проверять результат и помнить контекст проекта между сессиями.

**Особенно хорошо это работает, когда Claude Code, Codex или другой coding-agent упирается в лимиты, теряет контекст или просто перестаёт быть удобным.**

В основе — официальные возможности ChatGPT: GPTs, Actions, instructions и knowledge files.

Автор: [Yurii Slepnev](https://t.me/yurii_yurii86) · [YouTube](https://youtube.com/@yurii_yurii86) · [Instagram](https://instagram.com/yurii_yurii86) · Apache-2.0

Язык: [English version](../README.md)

---

## Демо

Прежде чем читать инструкцию по установке, посмотри, как работает версия для Windows:

<p align="center">
  <img src="../assets/demo/secondary-lane-demo.gif" alt="Secondary LANE Windows demo" width="100%">
</p>

## Скриншоты

<p align="center">
  <img src="../assets/screenshots/chat-view-showcase.png" alt="Secondary LANE chat workflow" width="49%">
  <img src="../assets/screenshots/main-interface-showcase.png" alt="Secondary LANE control panel and local runtime" width="49%">
</p>

<p align="center">
  <sub><strong>Рабочий процесс через чат</strong> · Задача двигается внутри обычного интерфейса ChatGPT</sub>
  <br>
  <sub><strong>Панель управления и локальный рантайм</strong> · ChatGPT с одной стороны, локальный исполнительный слой с другой</sub>
</p>

## Самый сильный сценарий

Secondary LANE — это не просто «ChatGPT, который умеет читать файлы».

Его главная сила — дать тебе вторую рабочую линию, когда Claude Code, Codex или другой агент стопорится:

- **Продолжить после лимитов** вместо ожидания следующего сброса квоты
- **Подхватить работу после потери контекста** без перезапуска всего с нуля
- **Делать реальные локальные действия через ChatGPT**: inspect, patch, run, verify
- **Хранить память проекта между сессиями** через `.ai_context/`
- **Работать из обычного интерфейса ChatGPT**, а не только через CLI

## Зачем это людям

Secondary LANE нужен тем, кому нравится ChatGPT, но кто хочет не просто советы в чате, а реальную работу с проектом.

- **Без отдельной возни с API-ключами.** Если у тебя уже есть ChatGPT Plus или другой план с GPTs и Actions, не нужно строить отдельную схему оплаты моделей.
- **Локальный по своей природе.** Secondary LANE работает на твоей машине и видит только те папки, которые ты сам разрешил.
- **Можно работать даже с телефона.** Через `ngrok` твой GPT может достучаться до компьютера из приложения ChatGPT.
- **Работает с разными языками и стеками.** Python, Node, Go, Rust, Java, скрипты, монорепы — если на компьютере можно запустить нужную команду, ChatGPT сможет этим управлять.
- **Интерфейс — привычный ChatGPT, а не CLI.** То есть обычный чат, а не терминал-first инструмент.

## Только официальные возможности ChatGPT

Secondary LANE работает через обычный workflow ChatGPT: Custom GPTs, Actions, instructions и knowledge files.

- **Без скрытых API-трюков.** Ты подключаешь GPT к своему локальному серверу через стандартные Actions.
- **Без серых схем и чужих ключей.** Используется твой собственный аккаунт ChatGPT и уже существующие возможности продукта.
- **Без неофициального слоя доступа.** Secondary LANE не заменяет ChatGPT, а добавляет к нему локальный исполнительный слой на твоей машине.

## Что это такое

Secondary LANE — это локальный сервер, который подключает ChatGPT к твоему проекту через GPT Actions.

Он даёт ChatGPT возможность:

- **читать и искать** файлы проекта
- **править код** с автоматическим откатом, если проверка не прошла
- **запускать тесты** с автоопределением (`pytest`, `npm test`, `make test`)
- **поднимать сервисы** и делать smoke-check
- **выполнять команды** в рабочей папке
- **хранить память проекта** между сессиями через `.ai_context/`

```text
Твой компьютер                       ChatGPT
┌─────────────────┐    ngrok     ┌──────────────┐
│ Secondary LANE  │◄────────────►│  GPT Actions │
│ localhost:8787  │   tunnel     │  Custom GPT  │
└─────────────────┘              └──────────────┘
```

## Почему это ощущается иначе

Большинство похожих инструментов заточены под терминал и отдельные API-ключи. У Secondary LANE другой подход:

- **использовать ChatGPT как главный интерфейс**
- **выполнять всё локально**
- **держать проект рядом с машиной**
- **сделать удалённый доступ достаточно простым, чтобы работать даже с телефона**

Поэтому Secondary LANE полезен не только как запасной путь, когда другой агент упёрся в лимит, но и как основной рабочий сценарий.

## Типовые сценарии

- **Сделать ChatGPT своим основным coding-agent** для локальных проектов
- **Продолжить работу после лимитов** или потери контекста у другого агента
- **Запустить задачу с телефона** через приложение ChatGPT
- **Оставить код локально** для приватности, клиентских проектов и внутренних инструментов
- **Работать с любым стеком**, не привязываясь к одному редактору
- **Помогать студентам учиться** на реальных проектах через знакомый интерфейс
- **Дать команде один понятный UI**, а не учить всех CLI-инструментам

## Secondary LANE и альтернативы

| Возможность | Инструменты вроде Open Interpreter / Aider | Secondary LANE |
| --- | --- | --- |
| Основной интерфейс | CLI | ChatGPT |
| Типичный старт | Отдельные API-ключи и биллинг моделей | ChatGPT Plus + локальный сервер |
| Работа на своей машине | Да | Да |
| Доступ через приложение ChatGPT на телефоне | Обычно нет | Да |
| Память проекта между сессиями | Частично или по-своему | Встроено через `.ai_context/` |
| Любой язык и стек | Да | Да |
| Для кого особенно удобно | Тем, кто любит терминал | Тем, кто хочет работать через ChatGPT |

## Быстрый старт (Windows)

До начала надо **три вещи** (настраиваются один раз):

1. **Python 3.13** для Windows — [python.org/downloads/windows](https://www.python.org/downloads/windows/) (поставь галку «Add python.exe to PATH» при установке)
2. **Аккаунт ngrok** + зарезервированный бесплатный домен — [dashboard.ngrok.com](https://dashboard.ngrok.com) (бесплатный тариф подходит)
3. **ChatGPT Plus** (или любой тариф с поддержкой Custom GPTs и Actions)

Дальше выбирай один из двух путей.

### Путь А — агент делает всё сам (Codex / Claude Code)

Если у тебя уже установлен **Codex или Claude Code** — это самый быстрый способ.

Передай агенту файл:

`codex-skills/gpts-windows-autopilot/SKILL.md`

И скажи:

```text
Разверни мне Secondary LANE.
```

Агент сам проверит Python, поможет с ngrok, заполнит `.env`, запустит панель, проверит туннель и проведёт тебя через создание GPT. Тебе нужно вмешаться только там, где без человека никак: логин, капча, подтверждение почты, оплата.

### Путь Б — ручная установка (без агента)

Если **Codex/Claude Code нет** — открой пошаговый гайд для новичков:

**[docs/WINDOWS_FIRST_START.md](WINDOWS_FIRST_START.md)** — полная инструкция со скриншотами и пояснениями.

Короткая версия для тех, кто уверенно работает в терминале:

```powershell
# 1. Создай конфиг из шаблона и отредактируй его
Copy-Item .env.example .env
notepad .env
# В .env задай AGENT_TOKEN (длинный случайный секрет) и NGROK_DOMAIN
# (твой зарезервированный домен из dashboard.ngrok.com, БЕЗ "https://")

# 2. Поставь зависимости
py -3.13 -m venv .venv
.venv\Scripts\pip install -r requirements.txt

# 3. Запусти панель управления
py -3.13 gpts_agent_control.py
```

Или просто **дважды нажми `Запустить GPTS Agent.bat`** — он сам выполнит шаг запуска.

> Сгенерировать надёжный `AGENT_TOKEN` можно так:
> `py -3.13 -c "import secrets; print(secrets.token_urlsafe(48))"`

## Как подключить GPT

После того как панель управления запущена и туннель ngrok поднялся:

1. Открой ChatGPT → **Create a GPT** → перейди на вкладку **Configure**
2. **Instructions** — вставь содержимое [`gpts/system_instructions.txt`](../gpts/system_instructions.txt)
3. **Knowledge** — загрузи все файлы из [`gpts/knowledge/`](../gpts/knowledge/)
4. **Actions** → **Create new action** → вставь содержимое [`openapi.gpts.yaml`](../openapi.gpts.yaml)
5. **Authentication** → выбери **API Key**, тип **Bearer**, вставь чистое значение `AGENT_TOKEN` из `.env` (БЕЗ слова `Bearer`)
6. В preview прогони первые проверки: `getCapabilities` → `inspectProject` → `runTest`

Подробный гайд со скриншотами: [gpts/ACTIONS_SETUP.md](../gpts/ACTIONS_SETUP.md).

## Что GPT реально умеет через Secondary LANE

| Action | Что делает |
| --- | --- |
| `inspectProject` | Смотрит структуру проекта, определяет тип, ищет ключевые файлы |
| `readFile` / `writeFile` | Читает и записывает файлы в рабочей папке |
| `searchWorkspace` | Ищет текст по проекту |
| `applyPatch` | Делает безопасную правку с контрольной точкой |
| `safePatchAndVerifyProjectFile` | Правка -> проверка -> откат при ошибке |
| `multiFilePatchAndVerify` | Координированные правки нескольких файлов |
| `runTest` | Автоматически выбирает и запускает тесты |
| `runProjectServiceAndSmokeCheck` | Поднимает сервис, ждёт готовность, проверяет, останавливает |
| `analyzeProjectBuildFailure` | Запускает сборку и помогает понять тип ошибки |
| `runCommand` / `startCommand` | Выполняет любые команды в проекте |
| `gitStatus` / `gitDiff` | Базовые git-операции |
| `finalizeProjectWork` | Сохраняет состояние сессии и handoff |

## Структура проекта

```text
app/main.py              # FastAPI-сервер и API-маршруты
app/core/                # Конфиг, безопасность, утилиты, память проекта
gpts/                    # Системная инструкция и knowledge-pack для GPT
gpts_agent_control.py    # Панель управления (daemon + ngrok tunnel)
openapi.gpts.yaml        # Схема API для GPT Actions
tests/                   # Регрессионные и smoke-тесты
.env.example             # Шаблон конфигурации
```

## Безопасность

- все маршруты требуют bearer token
- доступ к файлам ограничен `WORKSPACE_ROOTS`
- SSH ограничен списком разрешённых хостов и сетей
- слабые токены отклоняются уже при запуске
- ключевые действия пишутся в SQLite-аудит

## Локальная проверка

```powershell
# Полная проверка: компиляция + тесты
powershell -ExecutionPolicy Bypass -File scripts\verify_local.ps1

# Только тесты
powershell -ExecutionPolicy Bypass -File scripts\run_local_pytest.ps1

# Smoke-check: запуск сервера, проверка health, остановка
powershell -ExecutionPolicy Bypass -File scripts\smoke_local.ps1
```

## Требования

- **Python 3.13** для Windows (3.12 работает как fallback; 3.14 пока не тестировался с pinned `pydantic 2.9.2`)
- **`ngrok`** с бесплатным аккаунтом — до первого запуска создай **authtoken** и **зарезервированный домен** в [dashboard.ngrok.com](https://dashboard.ngrok.com)
- **ChatGPT Plus** или любой план с поддержкой Custom GPTs и Actions

## Лицензия

Apache License 2.0. Подробности в [../LICENSE](../LICENSE) и [../NOTICE](../NOTICE).
