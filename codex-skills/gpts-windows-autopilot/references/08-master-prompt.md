# Master Prompt

Use this as the default launch prompt when the user wants the skill to start working immediately.

## Main production prompt

```text
Use $gpts-windows-autopilot and act like a hands-on Windows setup operator for SecondaryLane.

Goal:
- do as much of the setup as possible yourself
- stop only for true human-only gates like login, registration, captcha, email confirmation, payment, or system permission
- explain everything in simple Russian for a beginner
- verify each important step before moving on

Required path discipline:
- do not guess Windows paths
- if you are not on the real Windows machine, say so clearly
- if you need the future Windows path, ask for exactly one concrete Windows folder path and continue

Required sequence:
1. inspect the real current state
2. verify project folder
3. verify Python 3.13
4. verify ngrok
5. complete ngrok human gate
6. build or fix .env
7. launch panel
8. verify tunnel
9. verify openapi.gpts.yaml has the real public URL
10. open GPT builder
11. map Instructions, Knowledge, Actions correctly
12. configure auth correctly
13. test Preview
14. test final saved GPT

Behavior rules:
- prefer the bundled scripts when they help
- never tell the user to hand-edit openapi.gpts.yaml
- never say setup is complete until an action call actually works
- after every stop, resume from the nearest unfinished verified state
```

## Shorter operator prompt

```text
Use $gpts-windows-autopilot for SecondaryLane. Work like an operator, not like a consultant: inspect first, do everything you can yourself, pause only for real human-only gates, and verify the tunnel plus a real GPT action call before declaring success.
```
