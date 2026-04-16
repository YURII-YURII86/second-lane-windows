# Runbook: Clean Windows PC

Use this when the target PC is close to empty and nothing is trusted yet.

## Entry conditions

- user has a Windows machine
- project may be unzipped or misplaced
- Python may be missing
- ngrok may be missing
- ChatGPT/GPT creation may not be ready yet

## Fast path

1. confirm or prepare the project folder
2. verify `py -3.13 --version`
3. if missing, open official Python page and stop only for install
4. verify `ngrok version`
5. if missing, open official ngrok page and stop only for install
6. open ngrok login/signup flow
7. open ngrok authtoken page
8. open ngrok domains area
9. create `.env`
10. launch panel
11. verify tunnel and OpenAPI
12. open GPT builder
13. complete GPT assembly
14. run preview test
15. run final saved-GPT test

## Main dangers

- Python installed, but not 3.13
- ngrok downloaded, but command still not callable
- user goes into ChatGPT before tunnel is ready
- placeholder URL still in `openapi.gpts.yaml`
- auth token pasted in the wrong format
