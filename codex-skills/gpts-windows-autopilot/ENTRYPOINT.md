# GPTS Windows Autopilot Entrypoint

Use this file at the start of every run.

## Mission

Get a beginner Windows user from “project not set up” to “working GPT with Actions” while doing everything possible autonomously.

## First-run load order

**Always run adaptive detection first**, do not assume paths:

1. run `scripts/discover_secondarylane_layout.py` (find the Windows branch root even if the folder was renamed or moved)
2. if something looks off after that, run `scripts/discover_secondarylane_artifacts.py`

Then load the **minimum** bootstrap:

3. `SKILL.md`
4. `references/01-human-gates.md`
5. `references/03-state-machine.md`

Load the rest **on demand**, only when the current step actually needs it:

- `references/02-browser-protocol.md` — before opening any browser URL
- `references/04-gpt-builder-map.md` — before S8 (GPT builder)
- `references/05-verification-checklist.md` — at the S12/S13 final pass
- `references/07-scripted-mode.md` — when PowerShell is available on the host
- `references/08-master-prompt.md` — if the full master prompt is needed
- `references/13-adaptive-project-detection.md` — if step 1 returned nothing
- `references/14-adaptive-artifact-detection.md` — if artifacts look out of place
- one of `references/09-runbook-clean-windows.md`, `references/10-runbook-existing-python-ngrok.md`, `references/11-runbook-panel-ok-gpt-not-built.md`, `references/12-runbook-gpt-exists-but-broken.md` — after state detection (S0)
- `references/06-recovery-playbook.md` — only if the flow broke or the user is resuming after an interruption

## First reply rule

The first reply should be short, practical, and action-first.

Good example:

- `Сначала проверю, что уже готово на компьютере: проект, Python 3.13, ngrok и .env. Потом либо быстро продолжу, либо остановлюсь только там, где без твоего логина реально нельзя.`

Bad example:

- `Сейчас я проведу глубокий анализ проекта и предложу план.`

## Non-negotiable sequence

Never skip this order:

1. project folder
2. Python 3.13
3. ngrok installed
4. ngrok account gate
5. `.env`
6. panel launch
7. tunnel verification
8. `openapi.gpts.yaml` verification
9. ChatGPT gate
10. GPT builder
11. Actions
12. auth
13. preview test
14. final test

## Success definition

The task is not complete until:

- the panel is working
- the tunnel is live
- `openapi.gpts.yaml` has the real public URL
- the GPT exists
- the GPT can successfully call an action
