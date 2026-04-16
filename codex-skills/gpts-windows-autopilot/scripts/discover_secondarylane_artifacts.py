#!/usr/bin/env python3
import argparse
import json
from pathlib import Path


ROLE_PATTERNS = {
    "launcher": [
        ("Запустить GPTS Agent.bat", 10),
        ("*.bat", 3),
        ("*.cmd", 2),
    ],
    "env_example": [
        (".env.example", 10),
        ("*.env.example", 8),
        (".env*", 2),
    ],
    "openapi_schema": [
        ("openapi.gpts.yaml", 10),
        ("openapi*.yaml", 8),
        ("openapi*.yml", 8),
        ("*.yaml", 1),
        ("*.yml", 1),
    ],
    "system_instructions": [
        ("gpts/system_instructions.txt", 10),
        ("**/system_instructions.txt", 8),
        ("**/*instructions*.txt", 6),
        ("**/*system*.txt", 3),
        ("**/*instructions*.md", 2),
    ],
    "knowledge_root": [
        ("gpts/knowledge", 10),
        ("**/knowledge", 6),
        ("**/knowledge*", 4),
    ],
    "control_script": [
        ("gpts_agent_control.py", 10),
        ("*agent*control*.py", 8),
        ("*control*.py", 3),
    ],
}

PATH_PENALTIES = {
    "бэкап": 3,
    "backup": 3,
    ".ai_context": 4,
    "checkpoints": 4,
    "__pycache__": 5,
    ".git": 5,
}


def penalty_for(path: Path):
    lowered = str(path).lower()
    penalty = 0
    hits = []
    for token, value in PATH_PENALTIES.items():
        if token in lowered:
            penalty += value
            hits.append(token)
    return penalty, hits


def iter_matches(root: Path, pattern: str):
    if "**/" in pattern:
        yield from root.glob(pattern)
    else:
        candidate = root / pattern
        if candidate.exists():
            yield candidate
        else:
            yield from root.glob(pattern)


def discover_role(root: Path, role: str, patterns):
    candidates = []
    seen = set()
    for pattern, base_score in patterns:
        for path in iter_matches(root, pattern):
            resolved = path.resolve()
            if resolved in seen:
                continue
            seen.add(resolved)
            penalty, hits = penalty_for(resolved)
            score = base_score - penalty
            candidates.append({
                "path": str(resolved),
                "is_dir": resolved.is_dir(),
                "matched_pattern": pattern,
                "base_score": base_score,
                "path_penalty": penalty,
                "path_penalty_hits": hits,
                "effective_score": score,
            })
    candidates.sort(key=lambda item: (-item["effective_score"], -item["base_score"], item["path"]))
    return {
        "role": role,
        "best_match": candidates[0] if candidates else None,
        "candidates": candidates[:20],
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("branch_root", help="Candidate project branch root")
    args = parser.parse_args()

    root = Path(args.branch_root).expanduser().resolve()
    results = {}
    for role, patterns in ROLE_PATTERNS.items():
        results[role] = discover_role(root, role, patterns)

    print(json.dumps({
        "branch_root": str(root),
        "roles": results,
    }, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
