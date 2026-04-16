# Browser Protocol

## Why this file exists

Browser automation fails when the agent clicks by memory instead of by reality.

## Main rule

Never act in the browser by assumption.

Before each important action, verify:

- which page is open
- which site is open
- what the visible text says
- whether there is a blocking dialog or popup

## One action, one check

For every meaningful browser step:

1. identify current page
2. read visible cues
3. perform one action
4. reread the page
5. verify that the expected change actually happened

If it did not happen:

- do not spam clicks
- re-evaluate the new state first

## What to verify after opening a page

### Python page

Confirm that the page is on the official Python download site and clearly about Windows downloads.

### ngrok page

Confirm that the page is on official `ngrok.com`.

### ChatGPT GPT editor

Confirm that the user is in the GPT creation or GPT editing area, not just the normal chat.

## Dialog rule

If a dialog, popup, or blocking modal appears:

- stop and understand it first
- do not click behind it

## Domain page rule for ngrok

The agent should consider the user to be in the right area only if the screen clearly shows one of:

- a list of domains
- a create-domain button
- a domain-management screen

## GPT builder rule

The agent should not say “continue” unless it has confirmed that the user is in the right section:

- `Configure`
- `Knowledge`
- `Actions`
- auth area
- preview/test area

## If direct browser control is not available

Then the agent should:

1. open the target page if possible
2. tell the user exactly what page was opened
3. tell them exactly one action to do
4. wait for `готово`
