# Recovery Playbook

Use this file only if the happy path breaks.

## Case 1. Python check fails

Symptoms:

- `py -3.13 --version` does not work

Response:

1. confirm the user installed exactly Python 3.13
2. remind them about `Add Python to PATH`
3. rerun the version check

## Case 2. ngrok command fails

Symptoms:

- `ngrok version` does not work

Response:

1. confirm the user used the official Windows install path
2. rerun `ngrok version`
3. if still broken, guide reinstall rather than inventing a fragile workaround

## Case 3. Tunnel does not appear

Symptoms:

- panel does not show a public URL
- tunnel status stays bad

Response:

1. inspect `.env`
2. verify `NGROK_DOMAIN`
3. verify `ngrok` is callable
4. inspect panel logs

## Case 4. YAML still has placeholder URL

Symptoms:

- `openapi.gpts.yaml` still shows the template URL

Response:

1. do not edit YAML manually
2. go back to tunnel diagnosis
3. confirm panel launch really succeeded

## Case 5. ChatGPT cannot import the schema

Symptoms:

- schema rejected in `Actions`

Response:

1. confirm the whole file was copied
2. confirm `openapi.gpts.yaml` already has the real URL
3. retry a fresh action setup

## Case 6. Auth fails

Symptoms:

- action exists but test says unauthorized

Response:

1. compare GPT token with `.env`
2. if UI already shows `Bearer`, paste only raw token
3. use full `Bearer <token>` only if the UI explicitly asks for it

## Case 7. User returns after interruption

Response:

1. determine actual current state
2. resume from the nearest unfinished state from `03-state-machine.md`
3. do not replay verified steps unless they need to be rechecked
