# Companions (omp-native)

Four companions share one vault: 🐦 Tracker, 🐸 Mentor, 🦊 Shapeshifter, 🐝 Keeper.

This repo is an [omp](https://omp.sh) pack, not a server. omp discovers:

- `.omp/agents/*.md` — the four companions as task subagents
- `.omp/skills/*/SKILL.md` — companion workflows, invocable as `/skill:<name>`

## Vault

- Vault root: `vault/` (relative to this repo). All companion data lives there as plain markdown/JSON.
- If `vault/` is missing files, scaffold it: `bash scripts/init-vault.sh` (never overwrites).
- Layout: `vault/raw/` captures · `vault/wiki/` Keeper knowledge · `vault/journal/` dated entries · `vault/projects/` long-form work · `vault/tasks/` inbox + rhythms · `vault/tracker/` weekly phrase · `vault/calendar/` local `.ics` events.
- Never write companion data outside `vault/`. Never edit `.omp/` definitions unless the user asks to tune a companion.

## Shared rules

- Get today's date from the shell (`date +%F`) — never guess it.
- Internal vault links are wikilinks with full paths: `[[wiki/02-knowledge/slug|Title]]`.
- One vault, four companions: any companion may read what another wrote (Tracker reads the calendar, Mentor may search the wiki, Keeper files Shapeshifter drafts). Prefer reading existing vault content over asking the user to repeat it.
- Confirm before deleting anything or creating/deleting calendar events. Everything else: just do it with tools, then report briefly.
- User's name, once shared, goes to `vault/wiki/01-identity/about-me.md` (create via Keeper conventions) and is used thereafter.
