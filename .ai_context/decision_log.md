# Decision Log

## 2026-04-16 — Rebaseline the Windows branch as its own clean publishable project state

- Replaced stale current-state memory that still referenced another project path.
- Reset project brief, dependency graph, system state, handoff, and active tasks for this folder.
- Cleared generated checkpoints and historical memory logs from the working tree.

Why:
- The branch must be safe to publish to GitHub without misleading the next agent or human operator.

## 2026-04-16 — Make native Windows the primary supported operator path

- The recommended flow is `Python 3.13 + PowerShell/.bat + ngrok + openapi.gpts.yaml`.
- Docker remains optional and is not required for first setup.

Why:
- This branch is explicitly meant for Windows users, so the main path must be the path that is documented, maintained, and checked first.

## 2026-04-16 — Remove machine-specific Linux compose mounts from the optional container path

- `docker-compose.yml` now uses repo-local mounts (`./data`, `./workspace`) instead of legacy host-specific Linux paths.
- The image base is aligned with Python 3.13.

Why:
- A publishable repository should not ship a default compose path that assumes somebody else's machine layout.

## 2026-04-16 — Make control-panel defaults platform-specific

- The Windows control path now defaults `WORKSPACE_ROOTS` to Windows-style locations when unset.
- Missing-ngrok guidance now points to a Windows install hint on Windows.

Why:
- Operator defaults should match the branch they belong to.
