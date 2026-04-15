# Project Brief

- Name: Second Lane Windows
- Goal: дать Windows-пользователю чистый и воспроизводимый action-backend для ChatGPT / GPT Actions без наследия от другой ветки или чужих локальных путей
- Main user/problem: ChatGPT без action-backend не может реально исследовать проект, править файлы, запускать команды и поддерживать handoff-ready project memory; дополнительная проблема этой ветки — Windows-путь должен быть честным и не тянуть старые macOS/Linux следы
- Success condition: Windows-пользователь может пройти путь `.env -> gpts_agent_control.py / .bat -> openapi.gpts.yaml -> verify/smoke` без ручной археологии по старым путям и без скрытой зависимости от другой папки проекта
- Notes: основной поддержанный путь в этой ветке — нативный Windows `Python 3.13 + PowerShell + ngrok`; Docker остаётся опциональным и не является обязательным для первого запуска
