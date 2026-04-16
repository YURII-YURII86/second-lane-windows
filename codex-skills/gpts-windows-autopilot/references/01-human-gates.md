# Human Gates

## Why this file exists

Autonomous does not mean pretending.

Some steps are truly human-only. The agent should stop only for those, and for nothing else.

## Closed list of valid human gates

If a step is not on this list, the agent should try to do it itself.

### 1. Account registration

Examples:

- creating an `ngrok` account
- creating or entering a ChatGPT account

### 2. Login

Examples:

- entering account password
- entering one-time code
- approving email sign-in

### 3. Captcha or anti-bot challenge

If the site asks the human to prove they are human, the agent stops and waits.

### 4. Payment or tariff upgrade

Examples:

- paying for a plan
- upgrading ChatGPT to a plan that allows GPT creation

### 5. Sensitive system permission

Examples:

- Windows asks to approve app installation
- browser asks for a permission the agent cannot safely bypass

## How to phrase a stop

A good stop message is:

- short
- calm
- one next action only
- clear about how work resumes

Good example:

- `Я уже открыл страницу входа ChatGPT. Тебе нужно только войти в аккаунт. Как закончишь, напиши "готово", и я сразу продолжу с созданием GPT.`

Bad example:

- `Там дальше надо руками что-то поделать, потом вернись.`

## What must happen after the user returns

The agent must:

1. not restart from scratch
2. inspect the actual current state
3. continue from the nearest unfinished step

## What is not a valid human gate

These are not valid reasons to push work onto the user:

- asking the user to inspect `.env`
- asking the user to decide which project files to upload
- asking the user to compare URLs
- asking the user to debug the tunnel
- asking the user to decide whether `openapi.gpts.yaml` updated
- asking the user to understand `Bearer`
