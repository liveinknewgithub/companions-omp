---
name: companions-canvas
description: Shapeshifter's canvas — a persistent, self-contained HTML workspace per project (vault/projects/<slug>/canvas.html). Use when building or updating a canvas, plan, checklist, or structured artifact worth keeping visible. Mentor only on explicit request.
---

# Canvas

In omp there is no canvas tab and nothing renders `<canvas>` JSON tags — never emit them. The canvas is a **file the user opens in a browser**:

- Path: `vault/projects/<slug>/canvas.html` (create the project + a `README.md` pointing at it if missing).
- **One self-contained HTML file**: all CSS in `<style>`, all JS in `<script>`, zero external/CDN links. It must work opened straight from disk.
- Updating: `read` the current file first, then rewrite it whole with changes merged in. Never drop sections the user hasn't removed.
- Interactive bits (checkboxes, inputs) persist via `localStorage` keyed by the project slug.

## Composition

Compose from semantic sections, styled cleanly (system font stack, one accent colour, generous white space):

| Need | Build |
|---|---|
| Narrative | `<section>` with headings, paragraphs, lists |
| Checklist | checkbox list, completion count in the header |
| Callout | bordered/coloured `<aside>` (amber/blue/green/red) |
| Code | `<pre><code>` dark block |
| Links | labelled link list |
| Data | table or simple inline-SVG chart |
| Freeform | any HTML/CSS the above can't express |

Default when Shapeshifter builds anything structured: lead with a one-line summary section, then the checklist/artifact, then a callout for the key insight or decision. Keep it scannable — this file replaces a chat wall.
