---
name: companions
description: Shared vault protocol for the four omp companions (Tracker, Mentor, Shapeshifter, Keeper) — vault layout, wikilinks, dates, cross-companion reads. Load alongside any companion skill.
---

# Companions — shared vault protocol

Four companions, one vault. You are working from the pack root; the vault is `vault/` beneath it.

## Layout

| Path | Owner | Contents |
|---|---|---|
| `vault/raw/` | Keeper | Quick captures: `YYYY-MM-DD-HHmm-dump.md` |
| `vault/wiki/` | Keeper | Linked knowledge, Johnny Decimal (below) |
| `vault/journal/` | Tracker | `YYYY-MM-DD.md` — haiku + reflection |
| `vault/projects/<slug>/` | Shapeshifter/Mentor | Long-form work, README-first |
| `vault/tasks/inbox.md` | Tracker | Prioritised task list |
| `vault/tasks/rhythms.json` | Tracker | Recurring commitments |
| `vault/tracker/week.md` | Tracker | Phrase for the week |
| `vault/calendar/` | Tracker | Local `.ics` files (see companions-calendar) |

If a needed file is missing, run `bash scripts/init-vault.sh` — it scaffolds from `vault-template/` without overwriting anything.

## Conventions

- **Dates:** always `date +%F` (and `date +%u` for weekday) from bash. Never infer today.
- **Wikilinks:** `[[wiki/XX-folder/slug|Title]]` — full path, always. Never bare `[[Title]]`, never `[text](path)` for internal links.
- **Wiki categories (only these 12):** `01-identity` self/values/goals · `02-knowledge` concepts/frameworks/lessons · `03-projects` active projects · `04-areas` routines/responsibilities · `05-relationships` people · `06-creativity` writing/art/music · `07-systems` tools/workflows · `08-resources` links/reading · `09-media` books/films/podcasts/recipes · `10-events` dated memories · `11-questions` open questions · `99-archive` deprecated.
- **Cross-reads:** before asking the user for context, check the vault: `grep` `vault/wiki`, read `vault/wiki/_index.md`, today's journal, `vault/tasks/inbox.md`.
- **Writes:** do them with tools, then say what changed in one or two lines. Never paste commands for the user to run.
- **Confirm first:** deletions, calendar create/delete. Nothing else needs permission.
