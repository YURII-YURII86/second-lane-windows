# DEPLOY

## Windows-first local mode

В этой папке основной и рекомендуемый путь — нативный Windows-запуск.

Главный локальный путь здесь:

- `py -3.13 gpts_agent_control.py`
- или двойной клик по `Запустить GPTS Agent.bat`

### Требования

- Python 3.13
- `ngrok`
- заполненный `.env`
- для repo-local verify/test/smoke-скриптов основной путь окружения — `.venv`

### Минимальный запуск

```powershell
py -3.13 gpts_agent_control.py
```

Или двойным кликом по `Запустить GPTS Agent.bat`.

### Что делает панель

- поднимает локальный daemon на `127.0.0.1:8787`
- поднимает туннель ngrok
- обновляет URL в `openapi.gpts.yaml`
- даёт операторский UI для статуса и проверки
- умеет перезапускать daemon текущего проекта

## После изменения action-set

Если менялся GPT-facing action-set или `openapi.gpts.yaml`, операторский порядок такой:

1. перезапустить daemon
2. убедиться, что поднялся именно текущий проект
3. заново импортировать `openapi.gpts.yaml` в GPT Actions
4. прогнать smoke-check ключевых actions

## Optional Docker path

`docker-compose.yml` в этой ветке теперь использует только repo-local mounts:

- `./data:/app/data`
- `./workspace:/workspace`

Это сделано, чтобы compose-файл не зависел от старых Linux host paths и был переносимее между машинами.

Важно: для первого запуска Windows-пользователя Docker не нужен. Основной и лучше проверенный путь — нативный Python/PowerShell flow.

## Server mode

В проекте остаются шаблоны для `systemd` и `nginx`:

- `deploy/systemd/universal-flex-agent.service`
- `deploy/nginx/default.conf`

Их нужно адаптировать под фактический путь установки на сервере.

## Важно

- для `pydantic==2.9.2` локальная установка на Python 3.14 не считается надёжной
- если нужен чистый setup, создавай `.venv` на Python 3.13
- старую `.venv313` verify/test/smoke-скрипты пока ещё понимают автоматически
- для Windows-проверок добавлены `scripts/*.ps1` и `Запустить GPTS Agent.bat`
