# compAnIons — for omp

**Four purpose-built AI helpers for organisation, creativity, and reflection — now native to [omp](https://omp.sh).**

One generic AI can't hold all the roles you need. Reflection needs patience. Creation needs momentum. Knowledge needs structure. Companions gives omp four distinct companions over **one shared, plain-markdown vault** — no server, no web app, no cloud account. If you can run `omp`, you can run this.

> Previously a self-hosted Express/WebSocket + web/mobile app built on the Pi SDK. This is a clean rewrite onto omp's native primitives — skills, task subagents, and context files. See [MIGRATION.md](MIGRATION.md) for what maps where and what was dropped.

## The four companions

| | Companion | Character |
|---|---|---|
| 🐦 | **Tracker** | Precise and grounding. Holds your day's shape — tasks, calendar, rhythms, reflection. |
| 🐸 | **Mentor** | Patient, ADHD-aware. Slows you down. One step, one next action, never a wall of text. |
| 🦊 | **Shapeshifter** | Bold, fast, a little mischievous. Infers intent and acts — already built it. |
| 🐝 | **Keeper** | Organised, quietly curious. Tends the knowledge vault so you don't have to remember everything. |

## Quick start

```sh
git clone https://github.com/sanieldoe/companions.git
cd companions
bash scripts/init-vault.sh   # creates vault/ from vault-template/ (never overwrites)
omp                          # that's it — omp discovers .omp/ automatically
```

Then just talk:

- `🐦 what's on today?` / `/skill:tracker show my day`
- `/skill:mentor teach me how DNS works`
- `/skill:shapeshifter build me a reading-list tracker`
- `/skill:keeper file this: <paste a brain dump>`

Two ways to use each companion (this mirrors the original design — Mentor and Shapeshifter shared one conversation; Tracker and Keeper were tool-driven modes):

| Mode | How | Best for |
|---|---|---|
| **Skill** (in your main session) | `/skill:mentor …` | Conversation. History is shared, so Mentor↔Shapeshifter back-and-forth keeps context — like the original shared chat. |
| **Subagent** (delegated) | ask omp to "have Tracker do X", or via the task tool with `agent: "tracker"` | One-shot jobs: ingest this file, build this canvas, lint the vault. |

Rename or re-tune a companion by editing `.omp/agents/<name>.md` (identity) and `.omp/skills/<name>/SKILL.md` (workflow). Restart omp to reload.

## Use it from anywhere (optional global install)

```sh
bash scripts/install.sh            # symlinks agents+skills into ~/.omp/agent/
bash scripts/install.sh --uninstall
```

Symlinks, so edits in this repo go live. Collisions with files that aren't ours are skipped, never overwritten. Note: the vault still lives in this repo — global agents/skills reference `vault/` relative to wherever omp is running, so for global use keep working from this directory or point the companions at your vault path in the prompt.

## The vault

```text
vault/
  raw/          quick captures — notes, clips, voice transcripts (verbatim, never edited)
  wiki/         linked knowledge — Keeper-maintained, Johnny Decimal 01–11 + 99-archive
  journal/      dated entries — Tracker's haiku + reflections
  projects/     long-form work — plans, drafts, canvases
  tasks/        inbox.md (p1/p2/p3) + rhythms.json (recurring commitments)
  tracker/      week.md — phrase for the week
  calendar/     local .ics events (or a calendar MCP — see .omp/skills/companions-calendar)
```

`vault/` is git-ignored; `vault-template/` is the committed scaffold. Everything is plain files you can read, grep, and back up yourself.

## What each companion does

- **Tracker** — day view (phrase + events + due rhythms + prioritised tasks), task capture with automatic carryover of unfinished work, rhythm tracking (daily → annual cadences), a fresh haiku each morning in `journal/YYYY-MM-DD.md`.
- **Mentor** — clarifies before acting, one step at a time with `Step X of Y`, bolded key idea, one next action per reply, enthusiastic pushback. Canvas only when you ask.
- **Shapeshifter** — asks at most one question (the goal), states its assumption in one line, and builds: projects under `vault/projects/`, canvas-first (a self-contained `canvas.html` you open in a browser — see below).
- **Keeper** — saves brain dumps verbatim to `raw/`, files them into the 12-category wiki with Maps of Content + index + ingest log, extracts todos and recurring commitments, surfaces older/forgotten pages when you ask questions, lints for broken links and orphans.

## Canvas, omp-style

The original canvas was a 10-block JSON format rendered by the app. Nothing renders that in a terminal, so the canvas is now a **single self-contained HTML file** per project (`vault/projects/<slug>/canvas.html`, inline CSS/JS, `localStorage` persistence, no CDN) that you open in any browser. Shapeshifter builds/updates it by default; Mentor only when asked.

## Calendar

No Google connector ships with this pack. If your omp session has a calendar MCP connected, the companions use it; otherwise events are local `.ics` files in `vault/calendar/`. Writes are always confirmed first. Details: `.omp/skills/companions-calendar/SKILL.md`.

## Layout of this repo

```text
.omp/agents/    tracker.md mentor.md shapeshifter.md keeper.md   (task subagents)
.omp/skills/    companions/ (shared vault protocol) + one skill per companion
                + companions-canvas/ + companions-calendar/
AGENTS.md       shared rules omp loads for every session here
vault-template/ committed scaffold for the vault
scripts/        init-vault.sh · install.sh · check.sh (pack validator)
```

## Acknowledgements

- [omp](https://omp.sh) by Stencil Labs — the harness this pack plugs into (itself a fork of Mario Zechner's Pi, the original Companions engine).
- Andrej Karpathy — inspiration for the Keeper wiki model.

MIT — see [LICENSE](LICENSE).
