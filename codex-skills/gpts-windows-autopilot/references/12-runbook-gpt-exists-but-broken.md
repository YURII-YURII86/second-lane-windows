# Runbook: GPT already exists but does not work

Use this when the user says the GPT was already created, but actions fail.

## Entry conditions

- GPT already exists
- preview or normal chat may fail
- issue may be auth, tunnel, YAML URL, or closed panel

## Fast path

1. verify panel is open
2. verify tunnel is active
3. verify `openapi.gpts.yaml` still has the real URL
4. compare GPT auth token with `.env`
5. verify the auth format rule
6. retry a simple preview action like `getCapabilities`
7. if schema import is suspect, rebuild the action from fresh `openapi.gpts.yaml`

## Main dangers

- panel not open
- tunnel dead
- placeholder URL returned
- old token still stored in GPT
- duplicated `Bearer`
