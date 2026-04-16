#!/usr/bin/env python3
import argparse
import json
import secrets
import sys
from pathlib import Path


def find_branch_root(raw_root: Path) -> Path:
    candidates = [raw_root, raw_root / "Версия для Виндовс"]
    for candidate in candidates:
        if (candidate / ".env.example").exists():
            return candidate
    raise SystemExit("Could not find Windows project root with .env.example")


def parse_env_lines(text):
    return text.splitlines()


def set_key(lines, key, value):
    prefix = f"{key}="
    replaced = False
    new_lines = []
    for line in lines:
        if line.startswith(prefix):
            new_lines.append(f"{prefix}{value}")
            replaced = True
        else:
            new_lines.append(line)
    if not replaced:
        new_lines.append(f"{prefix}{value}")
    return new_lines


def is_windows_style_path(value: str) -> bool:
    return len(value) >= 3 and value[1:3] == ":\\" and value[0].isalpha()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("project_root", help="Workspace root or Windows branch root")
    parser.add_argument("--ngrok-domain", required=True, help="Raw domain only, without https://")
    parser.add_argument("--workspace-root", help="Windows project root to place first in WORKSPACE_ROOTS")
    parser.add_argument("--agent-token", help="Optional pre-generated AGENT_TOKEN")
    args = parser.parse_args()

    branch_root = find_branch_root(Path(args.project_root).expanduser().resolve())
    env_example_path = branch_root / ".env.example"
    env_path = branch_root / ".env"
    base_text = env_path.read_text(encoding="utf-8") if env_path.exists() else env_example_path.read_text(encoding="utf-8")
    lines = parse_env_lines(base_text)

    if args.workspace_root:
        workspace_root = args.workspace_root.strip()
    elif sys.platform.startswith("win"):
        workspace_root = str(branch_root)
    else:
        raise SystemExit(
            "On non-Windows hosts you must pass --workspace-root with the real Windows path, for example C:\\SecondLane"
        )

    project_path_windows = workspace_root.replace("/", "\\")
    if not is_windows_style_path(project_path_windows):
        raise SystemExit(
            f"workspace root must look like a real Windows path, got: {project_path_windows}"
        )

    agent_token = args.agent_token or secrets.token_urlsafe(48)
    ngrok_domain = args.ngrok_domain.replace("https://", "").strip().strip("/")

    lines = set_key(lines, "AGENT_TOKEN", agent_token)
    lines = set_key(lines, "NGROK_DOMAIN", ngrok_domain)
    lines = set_key(lines, "WORKSPACE_ROOTS", f"{project_path_windows};C:\\Projects;D:\\Workspace")
    lines = set_key(lines, "ENABLED_PROVIDER_MANIFESTS", f"{project_path_windows}\\app\\providers")
    lines = set_key(lines, "STATE_DB_PATH", f"{project_path_windows}\\data\\agent.db")

    env_path.write_text("\n".join(lines) + "\n", encoding="utf-8")

    print(json.dumps({
        "env_path": str(env_path),
        "branch_root": str(branch_root),
        "ngrok_domain": ngrok_domain,
        "workspace_root": project_path_windows,
        "agent_token_generated": args.agent_token is None,
        "agent_token_preview": f"{agent_token[:6]}...{agent_token[-4:]}" if len(agent_token) >= 10 else "***",
    }, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
