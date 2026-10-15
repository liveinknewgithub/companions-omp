# Migration: server app → omp-native pack

The original Companions was a self-hosted system: an Express/WebSocket server running personas as Pi SDK (`@mariozechner/pi-coding-agent`) sessions, plus React web and Expo mobile clients. omp is the successor harness to that same Pi engine, so the personas port onto omp's native primitives instead of a bespoke server.

## Mapping

| Original | omp-native |
|---|---|
| `personas/<name>/PERSONA.md` system prompts | `.omp/agents/<name>.md` (identity) + `.omp/skills/<name>/SKILL.md` (workflow) |
| Server skill directory injected into prompts (`skills/*/SKILL.md`) | Native omp skills in `.omp/skills/` — discovered automatically, invoked via `/skill:<name>`, autoloaded into subagents via `autoloadSkills` |
| Mentor + Shapeshifter sharing one Pi session | Use the **skills** in one main omp session — same shared history. Subagents are the stateless, delegated form. |
| `vault/` + server file APIs (Keeper ingest returned JSON write-batches) | `vault/` on disk; companions write directly with omp's `read`/`write`/`edit` tools. Ingest rules (12 Johnny Decimal categories, MOC + `_index.md` + `log.md`, wikilinks, todo/rhythm extraction) preserved in the Keeper skill. |
| Tracker state via REST endpoints | Same files, same formats: `tasks/inbox.md`, `tasks/rhythms.json` (schema unchanged from `server/src/rhythms.ts`), `tracker/week.md`, `journal/YYYY-MM-DD.md`. |
| Shapeshifter canvas (10-block JSON rendered by the app) | `vault/projects/<slug>/canvas.html` — one self-contained HTML file, browser-opened. The `<canvas>` tag protocol is gone; nothing rendered it outside the app. |
| Google Calendar via `<cal_create>` tag interception + OAuth on the server | No interceptor exists in omp. `companions-calendar` skill: calendar MCP if the session has one, else local `.ics` files. The tag protocol is explicitly documented as dead so models don't emit it. |
| Pi SDK auth/model registry in `~/.companion` | omp's own auth, models, and roles (`~/.omp/agent/config.yml`). Nothing companion-specific to configure. |
| Cron jobs (morning haiku, etc.) | No daemon ships with a prompt pack. Ask Tracker in a session, or wire omp/your OS scheduler to `omp -p "/skill:tracker write today's haiku"`. |
| LanceDB + embeddings wiki search | `grep` over the wiki + `_index.md` scan (Keeper skill). Simpler, zero dependencies, fine at personal-vault scale. |
| Web dashboard, mobile app, E2E relay, setup wizard | Dropped. The terminal is the interface; renaming a companion = editing two markdown files. |

## Removed

`server/`, `app/`, `web/`, `scripts/token-*.ts`, the old `install.sh`, `SPEC.md` (described the relay architecture), `companions.config.example.json`, and the server CI/release workflows. Persona and skill content was ported, not deleted — it lives in `.omp/`.

## Kept formats (so old vaults keep working)

- `tasks/rhythms.json` schema and due-date semantics.
- Wiki layout, MOC files (`wiki/XX-name.md`), `_index.md`, `log.md`, full-path wikilinks.
- `raw/YYYY-MM-DD-HHmm-dump.md` capture naming.
