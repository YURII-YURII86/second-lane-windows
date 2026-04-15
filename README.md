# Second Lane

> Windows-focused build of the project. This folder is meant to be adapted and tested separately from the main macOS-first version.

**Когда Claude Code, Codex или другой AI coding-agent упирается в лимиты, Second Lane позволяет не остановиться, а добить задачу внутри ChatGPT.**

**When Claude Code, Codex, or another AI coding agent hits its limits, Second Lane keeps the work moving inside ChatGPT.**

**Second Lane даёт ChatGPT реальные руки на твоей машине: читать проект, править код, запускать команды, гонять тесты, проверять результат и продолжать задачу там, где другой агент остановился.**

**Second Lane gives ChatGPT real hands on your machine: inspect the project, change code, run commands, run tests, verify results, and continue the task where another agent stopped.**

## Current Status

- this folder is the Windows-focused branch prepared for native Windows setup
- Python `3.13` is the supported local runtime path
- repo-local verification scripts use `.venv` as the main path
- native Windows path (`.bat` / `PowerShell` / `gpts_agent_control.py`) is the primary supported path
- local daemon + `ngrok` + GPT Actions path is the confirmed operator flow
- `docker-compose.yml` is optional and now uses repo-local mounts instead of machine-specific Linux paths
- the main folder remains the stable macOS-first branch

---

## RU

### Что это такое

Second Lane нужен для одной очень конкретной боли:

- coding-agent упёрся в лимиты;
- задача ещё не закончена;
- проект всё ещё надо двигать дальше;
- терять контекст и начинать с нуля не хочется.

Second Lane даёт второй рабочий контур:

- открываешь ChatGPT;
- подключаешь свой Custom GPT через GPT Actions;
- и продолжаешь реальную работу над проектом на своей машине.

Это не просто “чат с подсказками”.  
Это способ превратить ChatGPT в рабочий контур, который реально умеет:

- inspect проекта;
- чтение и правка файлов;
- запуск команд;
- запуск сервисов;
- smoke-check и проверка результата;
- память проекта между сессиями.

### Что значит “дать ChatGPT руки”

Это значит, что ChatGPT через GPT Actions может не только отвечать текстом, но и реально двигать проект вперёд:

- читать проект;
- искать нужный код;
- вносить правки;
- запускать тесты и команды;
- поднимать сервисы;
- проверять результат;
- сохранять состояние проекта между сессиями.

### Почему это вообще важно

Claude Code, Codex и другие AI coding tools сильны, пока:

- не закончился лимит;
- не развалился контекст;
- не стало неудобно продолжать задачу в том же интерфейсе.

Но реальная боль начинается в момент, когда:

- лимит закончился;
- сессия умерла;
- контекст стал неудобным;
- а проект всё ещё надо дожать.

Second Lane нужен именно для этого сценария:

- основной агент остановился;
- задача всё ещё живая;
- ты переходишь в ChatGPT;
- и продолжаешь работу над тем же проектом на своей машине.

То есть это не “ещё один IDE-агент”.  
Это **второй рабочий контур**, когда первый перестал быть доступным, удобным или просто закончился.

### Быстрое сравнение

| Ситуация | Claude Code / Codex | Second Lane |
| --- | --- | --- |
| Пока лимиты и сессия в порядке | Отлично | Не обязан быть первым выбором |
| Агент упёрся в лимит | Работа стопорится | Можно продолжить в ChatGPT |
| Нужно быстро подхватить задачу в другом интерфейсе | Не всегда удобно | Это основной сценарий |
| Нужны реальные действия на своей машине через ChatGPT | Обычно не про это | Это и есть суть |
| Нужна память проекта между сессиями | Часто частично или через чат | Встроено через `.ai_context/` |

### Пример живого сценария

Например, ты делал багфикс в Claude Code:

1. Агент уже нашёл подозрительное место в коде.
2. Потом упёрся в лимит до завершения.
3. Ты открываешь ChatGPT.
4. GPT через Second Lane делает `inspectProject`, читает нужные файлы, вносит правку, запускает тест или команду и проверяет результат.
5. Работа не умирает вместе с лимитом.

### Use cases

- добить багфикс после лимита Claude Code;
- продолжить задачу в ChatGPT с того места, где остановился Codex;
- быстро прогнать inspect, patch, test и smoke-check в одном контуре;
- оставить структурированный handoff, чтобы не потерять контекст между сессиями;
- использовать ChatGPT как реальный execution layer, а не только как чат.

### Для кого это

- для разработчиков, которые уже пользуются Claude Code, Codex или похожими агентами;
- для тех, кто не хочет терять темп после лимитов;
- для тех, кто хочет продолжать работу в ChatGPT, но с реальными действиями над проектом;
- для тех, кому важна память проекта между сессиями.

### Для кого это не надо

- если тебе нужен hosted SaaS без локального запуска;
- если ты ищешь полную замену IDE;
- если тебе не нужен ChatGPT / GPT Actions как рабочий интерфейс;
- если ты не хочешь вообще ничего поднимать на своей машине.

### Простой flow

```text
Claude Code / Codex stopped
        ->
Move task into ChatGPT
        ->
GPT Actions call Second Lane
        ->
Inspect / patch / test / run / verify / continue
```

### Что умеет проект сейчас

Подтверждённый рабочий контур:

- daemon поднимается локально на `127.0.0.1:8787`;
- `ngrok` публикует текущий daemon наружу;
- `openapi.gpts.yaml` импортируется в GPT Actions;
- GPT может вызывать curated actions для работы с проектом;
- проект хранит `.ai_context/` как долговечную память между сессиями.

### GPT schema

В проекте рабочей схемой для GPT Actions считается одна схема:

- `openapi.gpts.yaml` — curated compact schema для GPT Actions.

Именно её нужно импортировать в GPT Actions и держать синхронизированной с актуальным GPT-facing action-set.

### Сильные workflow actions в GPT schema

Текущий compact action-set специально включает более сильные операции:

- `safePatchAndVerifyProjectFile`
- `applyPatch`
- `multiFilePatchAndVerify`
- `runTest`
- `analyzeProjectBuildFailure`
- `runProjectServiceAndSmokeCheck`

И сознательно **не включает** в GPT schema слабые или лишние слоты вроде browser-open и размытых GUI-actions.

### Что реально делает GPT через этот runtime

- смотрит структуру проекта;
- ищет нужные файлы и фрагменты;
- читает код;
- правит файлы точечно или координированно через несколько файлов;
- запускает команды и тесты;
- поднимает сервис и проверяет, что он действительно стартовал;
- анализирует ошибки сборки и запуска;
- оставляет handoff для следующей сессии.

### Быстрый запуск

Если нужен самый короткий путь без блужданий, открой:

- `docs/WINDOWS_FIRST_START.md`

```powershell
Copy-Item .env.example .env
# заполни AGENT_TOKEN
# заполни NGROK_DOMAIN
py -3.13 gpts_agent_control.py
```

или двойным кликом по `Запустить GPTS Agent.bat`.

Если хочешь поднять окружение руками, используй именно этот путь:

```powershell
py -3.13 -m venv .venv
.venv\Scripts\pip install -r requirements.txt
```

### Локальная проверка

Для локальной проверки в проекте теперь есть три repo-local пути:

Полный verify-цикл:

```bash
bash scripts/verify_local.sh
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\verify_local.ps1
```

Эта команда:

- использует `.venv` как основной repo-local путь окружения;
- ставит зависимости из `requirements.txt`, если окружение ещё не подготовлено или файл зависимостей изменился;
- прогоняет `py_compile` по load-bearing Python-файлам;
- затем запускает `pytest` через локальное окружение проекта.

Только тесты:

```bash
bash scripts/run_local_pytest.sh
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\run_local_pytest.ps1
```

Bounded runtime smoke-check:

```bash
bash scripts/smoke_local.sh
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\smoke_local.ps1
```

Эта команда:

- использует тот же repo-local `.venv`;
- поднимает локальный uvicorn на временном свободном порту;
- запускает его с временными smoke-env значениями, без зависимости от рабочего `.env`;
- проверяет `/health` и `/v1/capabilities` с bearer token;
- сама останавливает процесс после проверки.

Можно передать свои target-файлы в verify/test-скрипты:

```bash
bash scripts/verify_local.sh tests/test_super_actions.py
bash scripts/run_local_pytest.sh tests/test_super_actions.py
```

### Как подключить GPT

1. Импортируй `openapi.gpts.yaml` в GPT Actions.
2. Укажи bearer token из `.env`.
3. Вставь `gpts/system_instructions.txt` в instructions GPT.
4. Загрузи `gpts/knowledge/` в knowledge GPT.
5. Проверь первые вызовы `getCapabilities`, `inspectProject`, `runTest`.

### Что лежит в проекте

- `app/main.py` — API и маршруты actions
- `app/core/` — конфиг, безопасность, utils, project memory, providers
- `gpts/` — системная инструкция и knowledge-pack
- `gpts_agent_control.py` — панель запуска daemon и tunnel
- `openapi.gpts.yaml` — curated compact schema для GPT Actions
- `.ai_context/` — память проекта
- `.env` / `.env.example` — runtime config
- `requirements.txt` — зависимости Python
- `data/agent.db` — runtime state
- `tests/` — smoke и regression tests для ключевых actions

### Технические ограничения

- рабочий локальный путь сейчас ориентирован на Python `3.13`;
- локальная установка на Python `3.14` не считается поддержанной для этого набора зависимостей;
- практическая причина простая: текущий `pydantic-core` для этого проекта ставится и тестируется на `3.13`, а на `3.14` ломает setup;
- основной repo-local путь окружения теперь `.venv`, но старую `.venv313` verify/test-скрипты ещё понимают автоматически;
- все маршруты защищены bearer auth;
- доступ к файлам ограничен `WORKSPACE_ROOTS`.

---

## EN

### What It Is

Second Lane exists for one specific pain:

- your coding agent hit a usage limit;
- the task is not done;
- the project still has to move forward;
- and you don’t want to lose context or restart from scratch.

Second Lane gives you a second execution lane:

- open ChatGPT;
- connect your Custom GPT through GPT Actions;
- keep working on the real project on your machine.

This is not just “chat with suggestions.”  
It gives ChatGPT real execution:

- project inspection;
- file reading and editing;
- command execution;
- service startup;
- smoke checks and result verification;
- durable project memory across sessions.

### What It Means To Give ChatGPT Hands

It means ChatGPT can do more than generate text through GPT Actions:

- inspect the project;
- search relevant code;
- make changes;
- run tests and commands;
- start services;
- verify results;
- preserve project state across sessions.

### Why Not Just Use Claude Code or Codex

Claude Code, Codex, and other AI coding tools are strong while:

- limits are still available;
- context has not fallen apart;
- and the task is still convenient to continue in the same interface.

Second Lane exists for a different scenario:

- the primary agent stopped;
- the task is still alive;
- you move into ChatGPT;
- and keep working on the same project on your own machine.

So this is not “another IDE agent.”  
It is a **second execution lane** when the first one stops being available or convenient.

### Quick Comparison

| Situation | Claude Code / Codex | Second Lane |
| --- | --- | --- |
| Limits and session are healthy | Excellent | Not necessarily the first choice |
| The agent hits a cap | Work stalls | You can continue in ChatGPT |
| You need to pick up the task from another interface fast | Not always convenient | This is the primary use case |
| You want real actions on your machine through ChatGPT | Usually not the point | That is the whole point |
| You need project memory across sessions | Often partial or chat-bound | Built in through `.ai_context/` |

### Real-World Scenario

Imagine you were fixing a bug in Claude Code:

1. The agent already found the likely problem area.
2. Then it hit a limit before the task was complete.
3. You open ChatGPT.
4. GPT uses Second Lane to call `inspectProject`, read files, apply a change, run a test or command, and verify the result.
5. The work does not die with the limit.

### Use Cases

- finish a bugfix after Claude Code hits its limit;
- continue a task in ChatGPT from the point where Codex stopped;
- run inspect, patch, test, and smoke-check in one lane;
- leave structured handoff so context survives across sessions;
- use ChatGPT as a real execution layer, not just a chat box.

### Who This Is For

- developers already using Claude Code, Codex, or similar agents;
- people who do not want to lose momentum after usage limits;
- people who want to keep building in ChatGPT with real project actions;
- people who care about project memory across sessions.

### Who This Is Not For

- people looking for a hosted SaaS with no local setup;
- people looking for a full IDE replacement;
- people who do not want ChatGPT / GPT Actions as a working interface;
- people who do not want anything running on their own machine.

### Simple Flow

```text
Claude Code / Codex stopped
        ->
Move task into ChatGPT
        ->
GPT Actions call Second Lane
        ->
Inspect / patch / test / run / verify / continue
```

### GPT schema

This project uses one working schema for GPT Actions:

- `openapi.gpts.yaml` — the curated compact schema for GPT Actions.

This is the schema that should be imported into GPT Actions and kept aligned with the current GPT-facing action set.

### Strong workflow actions exposed to GPT

The current compact GPT schema deliberately exposes stronger workflow operations such as:

- `safePatchAndVerifyProjectFile`
- `applyPatch`
- `multiFilePatchAndVerify`
- `runTest`
- `analyzeProjectBuildFailure`
- `runProjectServiceAndSmokeCheck`

And it deliberately avoids weaker browser/GUI convenience actions in the GPT-facing schema.

### What Works Today

Confirmed working path:

- the daemon runs locally on `127.0.0.1:8787`;
- `ngrok` exposes the current daemon over the internet;
- `openapi.gpts.yaml` can be imported into GPT Actions;
- GPT can call curated actions against the project;
- `.ai_context/` stores durable project memory across sessions.

### What GPT Can Actually Do Through It

- inspect a project;
- find relevant files and code fragments;
- read code;
- patch one file or coordinate changes across multiple files;
- run commands and tests;
- start a service and verify it really started;
- analyze build and runtime failures;
- leave structured handoff for the next session.

### Quick Start

If you want the shortest no-guesswork onboarding path, open:

- `docs/WINDOWS_FIRST_START.md`

For Windows users, this native path is the main supported flow. The Docker path is optional and is not required for first setup.

```powershell
Copy-Item .env.example .env
# fill AGENT_TOKEN
# fill NGROK_DOMAIN
py -3.13 gpts_agent_control.py
```

Or double-click `Запустить GPTS Agent.bat` on Windows.

If you want to prepare the local environment manually, use this exact path:

```powershell
py -3.13 -m venv .venv
.venv\Scripts\pip install -r requirements.txt
```

### Local Verification

The repository now includes three repo-local verification paths:

Full verify loop:

```bash
bash scripts/verify_local.sh
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\verify_local.ps1
```

This command:

- uses `.venv` as the main repo-local environment path;
- installs dependencies from `requirements.txt` when the environment is missing or stale;
- runs `py_compile` across the load-bearing Python files;
- then runs `pytest` through the project-local virtual environment.

`Python 3.14` is not considered a supported local setup path for this dependency set at the moment.

Tests only:

```bash
bash scripts/run_local_pytest.sh
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\run_local_pytest.ps1
```

Bounded runtime smoke-check:

```bash
bash scripts/smoke_local.sh
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\smoke_local.ps1
```

This command:

- uses the same repo-local `.venv`;
- starts local uvicorn on a temporary free port;
- runs it with temporary smoke-check env values instead of depending on the working `.env`;
- verifies `/health` and `/v1/capabilities` with bearer auth;
- stops the process automatically after the check.

You can also pass explicit targets to the verify/test scripts:

```bash
bash scripts/verify_local.sh tests/test_super_actions.py
bash scripts/run_local_pytest.sh tests/test_super_actions.py
```

### Connect Your GPT

1. Import `openapi.gpts.yaml` into GPT Actions.
2. Set the bearer token from `.env`.
3. Paste `gpts/system_instructions.txt` into your GPT instructions.
4. Upload `gpts/knowledge/` into GPT knowledge.
5. Verify the first `getCapabilities`, `inspectProject`, and `runTest` calls.
