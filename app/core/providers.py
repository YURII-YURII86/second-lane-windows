from __future__ import annotations

import json
from pathlib import Path


def load_providers(manifest_dir: Path) -> list[dict]:
    if not manifest_dir.exists():
        return []
    providers: list[dict] = []
    for manifest in sorted(manifest_dir.glob("*.json")):
        try:
            payload = json.loads(manifest.read_text("utf-8"))
        except Exception:
            continue
        payload.setdefault("manifest_path", str(manifest))
        providers.append(payload)
    return providers
