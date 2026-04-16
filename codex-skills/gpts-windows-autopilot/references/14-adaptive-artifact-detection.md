# Adaptive Artifact Detection

Use this when the project root is known, but specific files may have drifted.

## Why this file exists

Sometimes the project root is still obvious, but internal filenames are not.

Examples:

- launcher renamed
- `system_instructions.txt` moved
- OpenAPI file renamed
- `knowledge` folder moved or renamed slightly

The agent should try to recover the role of each artifact before declaring the project broken.

## Main rule

Do not overfit to one exact filename if the role can still be recognized safely.

## Roles that matter

The skill should try to recover these roles:

- launcher
- `.env.example`
- OpenAPI schema
- system instructions file
- knowledge root
- control script

## Recovery strategy

### Level 1. Exact expected path

If the exact expected path exists, use it.

### Level 2. Role-based detection

If the exact expected file is missing, run:

```bash
python scripts/discover_secondarylane_artifacts.py "<branch-root>"
```

Then inspect the best match for each role.

### Level 3. Confidence rule

The agent may auto-accept a detected artifact if:

- the role match has a clearly high score
- the path is not in backup/checkpoint/service folders
- the surrounding project still looks like the same Windows branch

If confidence is weak or several candidates are close, ask the user for one concrete confirmation.

## What counts as acceptable drift

- launcher renamed but still a `.bat` file for startup
- instructions file renamed but still clearly the main GPT instructions text
- OpenAPI schema renamed but still clearly the action schema
- knowledge folder renamed slightly but still contains the expected `.md` material

## What does not count as acceptable drift

- startup moved to a completely different runtime with no clear launcher replacement
- schema system replaced by something non-OpenAPI
- GPT assets reorganized so heavily that roles are no longer inferable

In those cases, the skill should switch into careful recovery mode and explain that the project changed materially.
