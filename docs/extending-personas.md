# Extending the companions (omp)

Each companion is two files:

```text
.omp/agents/<name>.md          identity, tool grant, autoloaded skills (dispatch name)
.omp/skills/<name>/SKILL.md    the workflow omp loads on demand / autoloads into the subagent
```

## Rename or re-tune

Edit the identity paragraph in `.omp/agents/<name>.md` and the matching skill. The dispatch name (`name:` frontmatter and the filename) is the omp-facing key — changing it renames `/skill:<name>` and the task agent. Display emoji live in the `description:` frontmatter. Restart omp after edits.

## Add a skill to a companion

1. Create `.omp/skills/<skill-name>/SKILL.md` with `name:` + `description:` frontmatter (lowercase, hyphenated, self-contained, one capability).
2. For subagent use, add it to the agent's `autoloadSkills:` list. For main-session use it's discovered automatically — no wiring.
3. Run `bash scripts/check.sh` to validate frontmatter and autoload references.

## Add a fifth companion

Copy an existing agent + skill pair, rename both, write the identity and workflow. No code sites to update — omp discovers `.omp/agents/*.md` and `.omp/skills/*/SKILL.md` at startup. Decide its session style: conversational companions work best primarily as skills in the main session; job-style companions as subagents. Most should ship both, like the built-in four.
