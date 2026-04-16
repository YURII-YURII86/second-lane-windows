#!/usr/bin/env python3
import argparse
import json
from pathlib import Path


MARKERS = {
    "env_example": ".env.example",
    "launcher": "Запустить GPTS Agent.bat",
    "openapi": "openapi.gpts.yaml",
    "system_instructions": "gpts/system_instructions.txt",
    "knowledge_dir": "gpts/knowledge",
    "control": "gpts_agent_control.py",
}

PATH_PENALTIES = {
    "бэкап": 3,
    "backup": 3,
    ".ai_context": 4,
    "checkpoints": 4,
    "__pycache__": 5,
    ".git": 5,
}


def score_candidate(path: Path):
    found = {}
    score = 0
    for key, relative in MARKERS.items():
        exists = (path / relative).exists()
        found[key] = {
            "relative": relative,
            "exists": exists,
            "path": str(path / relative),
        }
        if exists:
            score += 1
    lowered_path = str(path).lower()
    penalty = 0
    penalty_hits = []
    for token, value in PATH_PENALTIES.items():
        if token in lowered_path:
            penalty += value
            penalty_hits.append(token)
    effective_score = score - penalty
    return score, effective_score, penalty, penalty_hits, found


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("search_root", help="Root folder to scan")
    parser.add_argument("--max-depth", type=int, default=4, help="Max folder depth to scan")
    args = parser.parse_args()

    root = Path(args.search_root).expanduser().resolve()
    results = []

    candidate_dirs = [root]
    for path in root.rglob("*"):
        if not path.is_dir():
            continue
        try:
            depth = len(path.relative_to(root).parts)
        except ValueError:
            continue
        if depth <= args.max_depth:
            candidate_dirs.append(path)

    seen = set()
    for candidate in candidate_dirs:
        if candidate in seen:
            continue
        seen.add(candidate)
        score, effective_score, penalty, penalty_hits, found = score_candidate(candidate)
        if score == 0:
            continue
        results.append({
            "candidate_root": str(candidate),
            "score": score,
            "effective_score": effective_score,
            "path_penalty": penalty,
            "path_penalty_hits": penalty_hits,
            "markers": found,
        })

    results.sort(key=lambda item: (-item["effective_score"], -item["score"], item["candidate_root"]))

    best = results[0] if results else None
    print(json.dumps({
        "search_root": str(root),
        "max_depth": args.max_depth,
        "best_match": best,
        "candidates": results,
    }, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
