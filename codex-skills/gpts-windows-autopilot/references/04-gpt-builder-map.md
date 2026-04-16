# GPT Builder Map

Use this when guiding the user through ChatGPT.

## Main mapping

### Instructions

Source:

- `Версия для Виндовс/gpts/system_instructions.txt`

Destination in ChatGPT:

- `Instructions`

### Knowledge

Source:

- all `.md` files from `Версия для Виндовс/gpts/knowledge/` and its subfolders

Destination in ChatGPT:

- `Knowledge`

### Actions schema

Source:

- `Версия для Виндовс/openapi.gpts.yaml`

Destination in ChatGPT:

- `Actions`

## Important do-not-confuse rules

- `Instructions` is for text from `system_instructions.txt`
- `Knowledge` is for uploading knowledge files
- `Actions` is for the schema from `openapi.gpts.yaml`

Do not tell the user to:

- paste knowledge files into `Instructions`
- upload the YAML into `Knowledge`
- edit the YAML manually

## Auth map

Source:

- the value part of `AGENT_TOKEN=...` from `.env`

Destination:

- the auth/token field in the ChatGPT action setup

Primary rule:

- if ChatGPT already shows `Bearer`, paste only the raw token value

Fallback only if the UI explicitly asks for a full header:

- `Bearer <token>`

Never paste:

- `AGENT_TOKEN=<token>`

## Preview test suggestion

Preferred simple test:

- ask the GPT to call `getCapabilities`

This is safer than starting with a destructive or complex action.
