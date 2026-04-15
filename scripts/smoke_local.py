from __future__ import annotations

import json
import os
import socket
import subprocess
import sys
import tempfile
import time
import urllib.request
from pathlib import Path


PROJECT_DIR = Path(__file__).resolve().parents[1]
HOST = "127.0.0.1"
TOKEN = os.environ.get("SMOKE_AGENT_TOKEN", "local-smoke-token-1234567890abcdef")
WORKSPACE_ROOTS_VALUE = os.environ.get("SMOKE_WORKSPACE_ROOTS", str(PROJECT_DIR))
STATE_DB_PATH_VALUE = os.environ.get("SMOKE_STATE_DB_PATH", os.path.join(tempfile.gettempdir(), "second-lane-smoke.db"))
STARTUP_TIMEOUT_SEC = float(os.environ.get("SMOKE_STARTUP_TIMEOUT_SEC", "20"))


def free_port() -> int:
    with socket.socket() as sock:
        sock.bind((HOST, 0))
        return sock.getsockname()[1]


def get_json(path: str, port: int) -> tuple[int, dict]:
    req = urllib.request.Request(f"http://{HOST}:{port}{path}")
    req.add_header("Authorization", f"Bearer {TOKEN}")
    with urllib.request.urlopen(req, timeout=5) as resp:
        return resp.status, json.loads(resp.read().decode("utf-8"))


def main() -> int:
    port = free_port()
    log_file = Path(tempfile.mkstemp(prefix="second-lane-smoke-", suffix=".log")[1])
    env = os.environ.copy()
    env.update(
        {
            "AGENT_TOKEN": TOKEN,
            "AGENT_HOST": HOST,
            "AGENT_PORT": str(port),
            "WORKSPACE_ROOTS": WORKSPACE_ROOTS_VALUE,
            "STATE_DB_PATH": STATE_DB_PATH_VALUE,
        }
    )
    proc = subprocess.Popen(
        [sys.executable, "-m", "uvicorn", "app.main:app", "--host", HOST, "--port", str(port)],
        cwd=str(PROJECT_DIR),
        env=env,
        stdout=log_file.open("w", encoding="utf-8"),
        stderr=subprocess.STDOUT,
        text=True,
    )
    try:
        deadline = time.time() + STARTUP_TIMEOUT_SEC
        last_error = "service did not start"
        while time.time() < deadline:
            try:
                status, payload = get_json("/health", port)
            except Exception as exc:  # noqa: BLE001
                last_error = str(exc)
                time.sleep(0.25)
                continue
            if status == 200 and payload.get("ok") is True:
                break
        else:
            print("Smoke startup failed", file=sys.stderr)
            print(last_error, file=sys.stderr)
            print(log_file.read_text("utf-8", errors="replace"), file=sys.stderr)
            return 1

        status, caps = get_json("/v1/capabilities", port)
        if status != 200 or caps.get("workspace") is not True:
            print("Capabilities check failed", file=sys.stderr)
            return 1
        print("Smoke check passed")
        print(json.dumps({"health_ok": True, "capabilities_ok": True, "workspace_roots": caps.get("workspace_roots", [])}, ensure_ascii=False))
        return 0
    finally:
        if proc.poll() is None:
            proc.terminate()
            try:
                proc.wait(timeout=5)
            except subprocess.TimeoutExpired:
                proc.kill()
        try:
            log_file.unlink(missing_ok=True)
        except Exception:
            pass


if __name__ == "__main__":
    raise SystemExit(main())
