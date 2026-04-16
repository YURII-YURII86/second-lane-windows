---
name: gpts-windows-autopilot
description: Autonomously deploy the Windows GPTS project from a near-clean beginner PC: verify or install Python 3.13 and ngrok, guide human-only ngrok and ChatGPT sign-in steps, fill .env, launch the local agent, verify the ngrok tunnel and openapi.gpts.yaml update, then walk the user through creating and testing the GPT with Actions. Use when the user wants Codex to do as much of the Windows setup as possible by itself, while pausing only for true human-only steps such as registration, login, email verification, captcha, or payment.
---

# GPTS Windows Autopilot

Use this skill when the user wants a near-fully-automated Windows setup of the GPTS project for a beginner.

## Mandatory start

Before doing substantial work, **always** run the adaptive project
detector first so you do not waste a turn guessing paths or assume the
project is broken because a folder was renamed:

1. run `scripts/discover_secondarylane_layout.py` to find the real
   Windows branch root (do not rely on the literal name
   `Версия для Виндовс` — it may have been renamed, translated, or
   unpacked into a different parent folder)
2. if the branch root is known but artifacts seem missing, run
   `scripts/discover_secondarylane_artifacts.py`

Then load the **minimum** bootstrap to take the first concrete action:

3. open `ENTRYPOINT.md`
4. open `references/01-human-gates.md`
5. open `references/03-state-machine.md`

Load the rest **on demand**, only when the situation calls for it:

- `references/02-browser-protocol.md` — before you open any browser URL
- `references/04-gpt-builder-map.md` — before step S8 (GPT builder)
- `references/05-verification-checklist.md` — at the final S12/S13 pass
- `references/07-scripted-mode.md` — when you have PowerShell access on the host
- `references/08-master-prompt.md` — if you need the full master prompt
- `references/13-adaptive-project-detection.md` — if the detector in step 1 returned nothing
- `references/14-adaptive-artifact-detection.md` — if artifacts look out of place
- the closest runbook from `references/09…12` — after you have determined the current state (S0)
- `references/06-recovery-playbook.md` — **only** if the flow broke or the user is resuming after an interruption

Do not replace this with a broad repository review.

The main idea:

- the agent does everything it can itself
- the user is interrupted only at true human-only gates
- every step is verified before moving forward
- comments to the user must sound like a helpful friend, not a system manual

## What this skill is for

This skill is specifically for the Windows branch of the GPTS project where the final goal is:

1. prepare the local project on Windows
2. install or verify Python 3.13
3. install or verify `ngrok`
4. help the user complete `ngrok` account steps
5. generate and save `.env`
6. launch the Windows panel
7. verify the local daemon and public tunnel
8. verify `openapi.gpts.yaml` now contains the real tunnel URL
9. help the user create the GPT in ChatGPT
10. help the user connect `Actions`
11. help the user test the GPT end to end

## Autonomy contract

The agent should do directly:

- inspect the project files
- check whether required files already exist
- run local commands
- create or update `.env`
- generate `AGENT_TOKEN`
- open URLs and local files when useful
- launch the Windows panel or helper scripts
- verify the tunnel and OpenAPI file
- extract text from local project files for the GPT builder
- guide the user through the GPT builder with very explicit small steps

The agent should pause only for true human-only gates:

- account registration
- login to `ngrok`
- login to ChatGPT
- email verification
- captcha
- payment or plan upgrade
- browser permission that the agent cannot safely bypass

Everything else should be done by the agent unless blocked by missing tooling.

## Communication style

While using this skill:

- explain every step in plain Russian unless the user clearly wants another language
- avoid jargon, or explain it immediately in simple words
- keep updates short and practical
- after each important action, say what was done and what happens next
- when pausing for a human gate, say exactly what the user must do and how the agent will continue after that

Good pause example:

- `Я уже открыл страницу регистрации ngrok. Тебе сейчас нужно самому зарегистрироваться и войти в аккаунт. Как только закончишь, напиши мне "готово", и я продолжу с токеном и доменом.`

Bad pause example:

- `Тут дальше надо немного руками доделать, разберись и возвращайся.`

## Required local context to inspect first

Before doing large actions, inspect the real project state.

Prefer `scripts/inspect_windows_gpts.py` for the first factual pass.
If the expected Windows branch is missing or renamed, use `references/13-adaptive-project-detection.md` and `scripts/discover_secondarylane_layout.py` before declaring the structure broken.
If the branch root is known but important files moved, use `references/14-adaptive-artifact-detection.md` and `scripts/discover_secondarylane_artifacts.py` before declaring those roles missing.

Prioritize these files if they exist:

- `Версия для Виндовс/Запустить GPTS Agent.bat`
- `Версия для Виндовс/.env.example`
- `Версия для Виндовс/gpts_agent_control.py`
- `Версия для Виндовс/openapi.gpts.yaml`
- `Версия для Виндовс/gpts/system_instructions.txt`
- `Версия для Виндовс/gpts/knowledge/`
- `Версия для Виндовс/docs/WINDOWS_FIRST_START.md`

Do not assume paths blindly if the real project path is already known from the current workspace.
Do not overfit to one folder name if the marker files clearly point to a slightly moved or renamed branch.
Do not overfit to one filename if the artifact role can still be recovered safely.

## Operating rules

### 1. Action-first

Do not begin with a broad code review.
If a runbook clearly matches the situation, follow that runbook instead of improvising a new high-level flow.
If the expected layout is missing, switch into adaptive detection before assuming the project is broken.

Start by discovering the real current setup state:

1. does the Windows project folder exist
2. is `.env` already present
3. is Python 3.13 callable
4. is `ngrok` callable
5. is the panel already running
6. does `openapi.gpts.yaml` still have a template URL or already a real one

### 2. Verify before asking

Never ask the user for something that can be discovered locally.

Examples:

- do not ask whether `.env` exists before checking
- do not ask whether Python is installed before checking
- do not ask whether the tunnel is up before reading panel/log state

### 2.5 Resume, do not restart

If the user returns after a pause:

- do not restart from the beginning
- determine the last completed factual state
- continue from the nearest unfinished step

This is especially important after:

- `ngrok` registration
- ChatGPT login
- tariff upgrade
- email verification
- captcha

### 3. One safe default path

If the user has not chosen a custom Windows path, prefer:

- `C:\SecondLane`

When discussing project location with a beginner, explain that this is simply the main project folder on drive `C:`.

### 4. Do not hand-edit generated project files unless required

The user may edit:

- `.env`
- ChatGPT GPT-builder fields

Do not tell the user to manually rewrite:

- `openapi.gpts.yaml`
- Python source files
- tests

If `openapi.gpts.yaml` still has a placeholder URL, treat that as a launch/tunnel problem, not a YAML-editing task.

### 5. Browser assistance

If local browser/UI control exists in the current environment, use it.

If it does not:

- open the correct URL with a shell command when possible
- tell the user exactly what page was opened
- tell them exactly what one human action is needed
- resume immediately after the user confirms completion

When opening URLs from shell:

- on macOS, prefer `open "<url>"`
- on Windows, prefer `start "" "<url>"`

### 6. Never skip the sequence

Always enforce this order:

1. project path
2. Python
3. `ngrok`
4. `ngrok` account token
5. `ngrok` domain
6. `.env`
7. panel launch
8. tunnel verification
9. OpenAPI verification
10. GPT builder
11. `Actions`
12. auth token in GPT
13. preview test
14. final GPT test

Do not jump to GPT creation before the tunnel and `openapi.gpts.yaml` are verified.

## State machine

Work through these states in order.

### S0. Detect current reality

Check:

- project root
- Windows branch root
- existence of `.env`
- existence of `.env.example`
- whether `openapi.gpts.yaml` exists
- whether `gpts/system_instructions.txt` exists
- whether `gpts/knowledge/` exists

Then check available commands relevant to the host environment.

If the current environment is not a Windows machine, the agent may still prepare files and documentation, but must say clearly that the actual Windows install/run steps need a Windows session.
On a real Windows machine, prefer the native check path from `references/07-scripted-mode.md`, especially `scripts/inspect_windows_host.ps1`.

### S1. Prepare the project folder

Goal:

- confirm the Windows project path the user will use on the target PC

If the agent can manipulate files on the target Windows machine, prefer a short path such as `C:\SecondLane`.

If the project is still zipped or misplaced, help move or unpack it.

Verify that the folder contains:

- `.env.example`
- `Запустить GPTS Agent.bat`
- `openapi.gpts.yaml`

### S2. Verify or install Python 3.13

Check first:

- `py -3.13 --version`

If it works:

- report success and continue

If not:

- open the official Python for Windows page
- instruct the user to install exactly Python 3.13
- tell them to enable `Add Python to PATH`
- after they finish, rerun the version check yourself

Do not accept fallback to random `python` versions.

### S3. Verify or install ngrok

Check first:

- `ngrok version`

If missing:

- open the official Windows download page, preferably via `scripts/open_setup_pages.py ngrok-download`
- prefer the normal installer route for beginners
- after the user finishes, rerun `ngrok version`

Do not assume that a downloaded `.exe` means installation is complete.

### S4. Complete ngrok human gate

Open the correct `ngrok` pages for the user:

1. sign up or log in
2. `authtoken` page
3. domain-management area

The agent should then:

- wait for confirmation from the user
- ask for no extra theory
- continue immediately to local configuration

After the user is done, the agent should:

1. run `ngrok config add-authtoken ...` with the real token if the token is available locally
2. verify the command succeeded
3. record the real chosen domain

For exact wording and stop behavior, follow `references/01-human-gates.md`.

If the user only copied the token/domain into chat, remind them not to publish those secrets elsewhere.

### S5. Generate `.env`

If `.env` does not exist:

- create it from `.env.example`

Generate a strong `AGENT_TOKEN` yourself.

Prefer `scripts/build_env.py` for this step.
If running outside the target Windows machine, do not guess the future Windows folder path. Require the real Windows path explicitly.

Then fill or update at least:

- `AGENT_TOKEN`
- `NGROK_DOMAIN`
- `WORKSPACE_ROOTS`

Rules:

- `WORKSPACE_ROOTS` must begin with the real project folder
- `NGROK_DOMAIN` must be just the domain, without `https://`
- `AGENT_TOKEN` must be the raw token value without quotes unless the file format explicitly requires them
- if the work is being prepared from a non-Windows host, path-based values must be built from the real future Windows folder, not from the current macOS or Linux path

Verify `.env` contents after writing.

### S6. Launch the Windows panel

Use the normal project launcher when possible:

- `Запустить GPTS Agent.bat`

Prefer the project's intended startup path rather than rebuilding the launch sequence manually.

Then confirm:

- panel opens
- local daemon becomes healthy
- no unsafe reuse of an unknown process on port `8787`
- tunnel becomes active
- public URL appears

### S7. Verify `openapi.gpts.yaml`

Check the file after tunnel startup.

Success condition:

- `servers -> url` contains the real public `https://...` tunnel URL

Failure condition:

- the placeholder remains

If failure:

- do not patch YAML manually
- debug launch or tunnel state instead

### S8. Prepare GPT builder materials

Collect and open for the user:

- `gpts/system_instructions.txt`
- relevant files from `gpts/knowledge/`
- `openapi.gpts.yaml`

If useful, summarize exactly:

- what text goes into `Instructions`
- which files go into `Knowledge`
- which schema text goes into `Actions`

But prefer opening the exact files and guiding the user through copy/paste if direct UI automation is unavailable.

Use `references/04-gpt-builder-map.md` for the exact “what goes where” map.
Prefer `scripts/export_gpt_materials.py` to gather the exact source files first.

### S9. Complete ChatGPT human gate

Open the GPT editor page for the user.

If ChatGPT login or plan access is missing:

- explain this in one simple sentence
- wait for the user to finish login or upgrade

Do not continue as if GPT creation is available when it is not.

### S10. Guide GPT creation

Walk the user through:

1. create GPT
2. open `Configure`
3. fill `Name`
4. fill `Description`
5. paste `Instructions`
6. upload `Knowledge`
7. open `Actions`
8. create new action
9. paste `openapi.gpts.yaml`
10. configure auth token
11. test in preview
12. save GPT

At this stage, be extremely concrete.

Do not say:

- `настрой Actions как обычно`
- `вставь схему`

Say instead:

- what exact file to open
- what exact text to copy
- what exact button or area to look for
- what success looks like

### S11. Configure auth correctly

Primary rule:

- if the ChatGPT UI already shows `Bearer`, the user usually pastes only the raw token value from `.env`

Fallback only if the UI explicitly asks for a full header:

- `Bearer <token>`

Never tell the user to paste:

- `AGENT_TOKEN=<token>`

### S12. Test before declaring success

Require at least these checks:

1. preview or test chat can call a simple action like `getCapabilities`
2. the GPT does not fail auth
3. the panel remains open
4. tunnel remains active
5. `openapi.gpts.yaml` still contains the real URL

For the final pass, follow `references/05-verification-checklist.md`.

### S13. Final handoff

Leave the user with a tiny plain-language summary:

- where the project folder is
- where `.env` is
- what must stay open during use
- how to relaunch the panel
- what to do if the GPT suddenly stops reaching the agent

## Guardrails

- Do not invent URLs when opening official pages.
- Prefer official pages for Python, `ngrok`, and ChatGPT help.
- Do not expose secrets unnecessarily in chat.
- Do not tell the user to manually edit generated YAML unless the user explicitly asked for deep debugging.
- Do not claim the setup is complete without testing both tunnel and GPT action call.
- If you are blocked by missing GUI/browser control, say so briefly and switch to the best available assisted mode.
- Do not pretend a human-only step was completed if you did not observe the completed state.
- Do not ask the user to choose between many unclear buttons when the page can be inspected directly.
- Do not leave the user after opening a site; always say what exact single action is needed next.

## Success definition

This skill succeeds only when all of the following are true:

1. Windows project folder is ready
2. Python 3.13 works
3. `ngrok` works
4. `.env` is filled correctly
5. panel launches
6. tunnel is live
7. `openapi.gpts.yaml` contains the real public URL
8. GPT is created
9. `Actions` are configured
10. auth works
11. a simple action call succeeds

If any item is not verified, report the exact remaining blocker in one short beginner-friendly sentence.
