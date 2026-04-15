# Implementation Plan — Current Truth

## Current position

This folder should now be treated as a standalone Windows-focused branch of the project rather than a copy that still inherits operational truth from another folder.

## Confirmed supported path

1. Copy `.env.example` to `.env`.
2. Fill `AGENT_TOKEN`, `NGROK_DOMAIN`, and `WORKSPACE_ROOTS`.
3. Launch via `Запустить GPTS Agent.bat` or `py -3.13 gpts_agent_control.py`.
4. Import `openapi.gpts.yaml` into GPT Actions.
5. Verify with the local scripts and the first GPT-side calls.

## Verified local checks in this folder

- `bash scripts/verify_local.sh`
- `bash scripts/smoke_local.sh`

## Optional path

- `docker-compose.yml` is optional and now intended as a repo-local portable example, not as the primary Windows onboarding path.

## Next recommended hardening work

1. Run a real Windows-host validation pass for the `.ps1` and `.bat` path on an actual Windows machine.
2. Do one authenticated end-to-end GPT Actions smoke run after importing `openapi.gpts.yaml`.
3. If the repository is about to be published, initialize git and create the first clean commit for this branch.
