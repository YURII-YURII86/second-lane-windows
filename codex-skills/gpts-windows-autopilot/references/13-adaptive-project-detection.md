# Adaptive Project Detection

Use this when the project layout may have drifted.

## Why this file exists

The project may evolve:

- the Windows folder may be renamed
- helper files may move a little
- the repository may gain extra wrapper folders

The agent should adapt instead of failing too early.

## Main rule

Do not trust one fixed folder name.

First try to identify the Windows branch by a combination of markers.

## Strong markers

The best markers are:

- `.env.example`
- `Запустить GPTS Agent.bat`
- `openapi.gpts.yaml`
- `gpts/system_instructions.txt`
- `gpts/knowledge/`
- `gpts_agent_control.py`

If several of these are found together in one folder, that folder is probably the real Windows branch root.

## Detection strategy

### Level 1. Exact known path

If the expected Windows branch path already exists and contains the expected markers, use it.

### Level 2. Marker-based discovery

If the exact path is missing or partly broken, run:

```bash
python scripts/discover_secondarylane_layout.py "<search-root>"
```

Then prefer the highest-scoring candidate.

### Level 3. Manual confirmation only if ambiguous

Ask the user only if:

- several candidates have similar strong scores
- the agent cannot confidently pick one safe root

When asking, ask for one simple thing only:

- `Покажи, в какой папке лежит файл Запустить GPTS Agent.bat.`

## What counts as slight drift

The skill should still adapt if:

- the parent folder changed
- the Windows branch folder changed name
- `docs/` moved
- extra folders were added above the branch
- some non-critical files were removed

## What does not count as slight drift

The skill should not pretend full confidence if:

- launcher is gone and startup method changed completely
- `.env` keys were renamed
- `openapi.gpts.yaml` was replaced by another schema system
- GPT materials no longer live under `gpts/`

In those cases, the agent should say the project structure changed materially and switch into careful recovery mode.
