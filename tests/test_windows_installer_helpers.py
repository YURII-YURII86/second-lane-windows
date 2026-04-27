from __future__ import annotations

from second_lane_installer import (
    merge_workspace_roots,
    normalize_ngrok_domain,
    normalize_ngrok_token,
    normalize_workspace_root,
    set_env_value,
    token_is_safe,
)


def test_normalize_ngrok_token_strips_command_and_quotes() -> None:
    raw = 'ngrok config add-authtoken "abc123token"'
    assert normalize_ngrok_token(raw) == "abc123token"


def test_normalize_ngrok_domain_strips_protocol_and_trailing_slash() -> None:
    assert normalize_ngrok_domain("https://Demo-Team.ngrok-free.dev/") == "demo-team.ngrok-free.dev"


def test_token_is_safe_rejects_placeholders_and_accepts_long_random_token() -> None:
    assert token_is_safe("replace-this-with-a-long-random-secret-token") is False
    assert token_is_safe("xYz_1234567890abcdefghijklmnopqrstuvwxyz.-~") is True


def test_set_env_value_replaces_existing_key_and_appends_missing_one() -> None:
    text = "AGENT_TOKEN=old\nNGROK_DOMAIN=old.ngrok-free.dev\n"
    updated = set_env_value(text, "NGROK_DOMAIN", "new.ngrok-free.dev")
    updated = set_env_value(updated, "WORKSPACE_ROOTS", r"C:\SecondLane")
    assert "NGROK_DOMAIN=new.ngrok-free.dev" in updated
    assert "WORKSPACE_ROOTS=C:\\SecondLane" in updated


def test_normalize_workspace_root_strips_quotes() -> None:
    assert normalize_workspace_root('"C:\\SecondLane"') == r"C:\SecondLane"


def test_merge_workspace_roots_keeps_primary_first_and_deduplicates() -> None:
    merged = merge_workspace_roots(r"C:\SecondLane", r"C:\Projects;C:\SecondLane;D:\Workspace")
    assert merged == r"C:\SecondLane;C:\Projects;D:\Workspace"
