# Runbook: Python and ngrok already exist

Use this when the machine may already be partly prepared.

## Entry conditions

- project folder exists
- Python may already work
- ngrok may already work
- `.env` may exist

## Fast path

1. run the first factual inspection
2. confirm Python is exactly 3.13
3. confirm ngrok command works
4. inspect `.env`
5. repair `.env` if token, domain, or paths are wrong
6. launch panel
7. verify tunnel
8. verify `openapi.gpts.yaml`
9. continue into GPT builder if local side is ready

## Main dangers

- user has Python, but wrong version
- `.env` exists, but contains placeholder or wrong path values
- ngrok works, but chosen domain does not match `.env`
