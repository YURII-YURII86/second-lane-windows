# Runbook: Local side works, GPT not built yet

Use this when the Windows panel and tunnel are already working.

## Entry conditions

- panel opens
- tunnel is active
- `openapi.gpts.yaml` already contains the real URL
- GPT may not exist yet

## Fast path

1. verify panel still alive
2. verify tunnel still active
3. verify `openapi.gpts.yaml` still has the real URL
4. collect GPT builder materials
5. open GPT editor
6. assemble GPT
7. configure auth
8. run preview test
9. run final saved-GPT test

## Main dangers

- panel is closed too early
- user pastes knowledge or schema into the wrong GPT section
- auth token is pasted with `AGENT_TOKEN=` instead of raw value
