# Windows First Start

## RU

### Что это

Это самая короткая инструкция первого запуска Windows-версии Second Lane.

Если по-простому, тебе нужно сделать 5 вещей:

1. поставить Python 3.13
2. поставить `ngrok`
3. заполнить `.env`
4. запустить `Запустить GPTS Agent.bat`
5. импортировать `openapi.gpts.yaml` в GPT Actions

### Шаг 1. Поставь Python 3.13

Нужен именно `Python 3.13`.

Проверь в PowerShell:

```powershell
py -3.13 --version
```

Если команды нет, сначала установи Python 3.13.

### Шаг 2. Поставь ngrok

Нужен установленный `ngrok` и добавленный `authtoken`.

После установки проверь:

```powershell
ngrok version
```

Потом добавь токен:

```powershell
ngrok config add-authtoken YOUR_TOKEN
```

### Шаг 3. Подготовь `.env`

Скопируй шаблон:

```powershell
Copy-Item .env.example .env
```

Открой `.env` и обязательно заполни:

- `AGENT_TOKEN`
- `NGROK_DOMAIN`
- `WORKSPACE_ROOTS`

Пример:

```env
AGENT_TOKEN=your-long-random-token
NGROK_DOMAIN=your-domain.ngrok-free.dev
WORKSPACE_ROOTS=C:\Projects;D:\Workspace
```

### Шаг 4. Первый запуск

Самый простой путь:

- дважды кликнуть `Запустить GPTS Agent.bat`

или из PowerShell:

```powershell
py -3.13 gpts_agent_control.py
```

Это основной и рекомендуемый путь для Windows. Docker для первого запуска не нужен.

Панель сама:

- поднимет локальный daemon
- проверит конфиг
- попробует поднять `ngrok`
- покажет публичный URL

### Шаг 5. Подключи GPT

В ChatGPT / GPT Actions:

1. импортируй `openapi.gpts.yaml`
2. вставь bearer token из `.env`
3. вставь `gpts/system_instructions.txt`
4. загрузи `gpts/knowledge/`

Если писать совсем прямо, токен вставляется в виде:

```text
Bearer ТВОЙ_AGENT_TOKEN
```

### Что проверить сразу

После первого подключения проверь вызовы:

- `getCapabilities`
- `inspectProject`
- `runTest`

### Если не заводится

Проверь по порядку:

1. `py -3.13 --version`
2. `ngrok version`
3. заполнен ли `.env`
4. не занят ли порт `8787`
5. не ругается ли панель на токен, домен или tunnel

### Полезные команды

Поднять окружение руками:

```powershell
py -3.13 -m venv .venv
.venv\Scripts\pip install -r requirements.txt
```

Полная локальная проверка:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\verify_local.ps1
```

Только тесты:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\run_local_pytest.ps1
```

Smoke-проверка runtime:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\smoke_local.ps1
```

## EN

### What This Is

This is the shortest first-start guide for the Windows build of Second Lane.

In simple terms, you need to do 5 things:

1. install Python 3.13
2. install `ngrok`
3. fill in `.env`
4. run `Запустить GPTS Agent.bat`
5. import `openapi.gpts.yaml` into GPT Actions

### Step 1. Install Python 3.13

You need `Python 3.13`.

Check in PowerShell:

```powershell
py -3.13 --version
```

If that command is missing, install Python 3.13 first.

### Step 2. Install ngrok

You need `ngrok` installed and your `authtoken` configured.

Check:

```powershell
ngrok version
```

Then add your token:

```powershell
ngrok config add-authtoken YOUR_TOKEN
```

### Step 3. Prepare `.env`

Copy the template:

```powershell
Copy-Item .env.example .env
```

Open `.env` and make sure these are filled in:

- `AGENT_TOKEN`
- `NGROK_DOMAIN`
- `WORKSPACE_ROOTS`

Example:

```env
AGENT_TOKEN=your-long-random-token
NGROK_DOMAIN=your-domain.ngrok-free.dev
WORKSPACE_ROOTS=C:\Projects;D:\Workspace
```

### Step 4. First Launch

The simplest path:

- double-click `Запустить GPTS Agent.bat`

or from PowerShell:

```powershell
py -3.13 gpts_agent_control.py
```

This is the main recommended Windows path. Docker is optional and not required for first setup.

The control panel will:

- start the local daemon
- validate config
- try to start `ngrok`
- show the public URL

### Step 5. Connect Your GPT

In ChatGPT / GPT Actions:

1. import `openapi.gpts.yaml`
2. set the bearer token from `.env`
3. paste `gpts/system_instructions.txt`
4. upload `gpts/knowledge/`

In the simplest form, that token is used like this:

```text
Bearer YOUR_AGENT_TOKEN
```

### What To Check First

After the first connection, verify:

- `getCapabilities`
- `inspectProject`
- `runTest`

### If It Does Not Start

Check in this order:

1. `py -3.13 --version`
2. `ngrok version`
3. whether `.env` is filled in
4. whether port `8787` is already occupied
5. whether the control panel reports a token, domain, or tunnel problem

### Useful Commands

Prepare the environment manually:

```powershell
py -3.13 -m venv .venv
.venv\Scripts\pip install -r requirements.txt
```

Full local verification:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\verify_local.ps1
```

Tests only:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\run_local_pytest.ps1
```

Runtime smoke check:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\smoke_local.ps1
```
