# Dependency Graph

## Core Runtime

- `app/main.py`
  Main FastAPI entrypoint that exposes the GPT-facing and operator-facing routes.
- `app/core/config.py`
  Loads runtime settings from `.env` and process environment; process environment wins when both define the same key.
- `app/core/security.py`
  Enforces bearer token authentication.
- `app/core/utils.py`
  Shared path resolution, subprocess execution, directory listing, search, and diff helpers.
- `app/core/project_memory.py`
  Creates and updates `.ai_context/`, manages checkpoints, and produces memory snapshots.
- `app/core/providers.py`
  Loads optional provider manifests from disk.

## Operator Entry Points

- `gpts_agent_control.py`
  Local control panel for daemon startup, ngrok tunnel management, health checks, and OpenAPI URL sync.
- `Запустить GPTS Agent.bat`
  Main Windows double-click launcher.
- `Запустить GPTS Agent.command`
  Convenience launcher for non-Windows operator use.

## GPT Surface

- `openapi.gpts.yaml`
  Curated GPT Actions schema imported into ChatGPT.
- `gpts/system_instructions.txt`
  Primary Custom GPT instructions.
- `gpts/knowledge/*`
  Supporting knowledge pack for the GPT.

## Verification Paths

- `scripts/verify_local.ps1` / `scripts/verify_local.sh`
  Full local verify flow.
- `scripts/run_local_pytest.ps1` / `scripts/run_local_pytest.sh`
  Tests-only local path.
- `scripts/smoke_local.ps1` / `scripts/smoke_local.sh` / `scripts/smoke_local.py`
  Bounded runtime smoke-check path.
- `tests/test_smoke.py`
  Basic API smoke coverage.
- `tests/test_project_memory_smoke.py`
  Project memory smoke coverage.
- `tests/test_super_actions.py`
  Coverage for the stronger workflow actions.

## Optional Container Path

- `Dockerfile`
  Optional container image build using Python 3.13.
- `docker-compose.yml`
  Optional repo-local compose path using `./data` and `./workspace` mounts instead of machine-specific host paths.

## State And Memory

- `.ai_context/system_state.json`
  Current verified project state for this folder.
- `.ai_context/project_brief.md`
  Short project intent summary.
- `.ai_context/handoff.md`
  Current resumable next-step state.
- `.ai_context/active_tasks.json`
  Current blockers and resume hint.
- `data/agent.db`
  Runtime SQLite state when the daemon runs locally.
