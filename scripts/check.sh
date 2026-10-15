#!/usr/bin/env bash
# Validate the pack: every agent/skill has name+description frontmatter,
# autoloadSkills resolve, and the vault template is complete.
set -uo pipefail
cd "$(dirname "$0")/.."
fail=0

check_fm() { # file
  head -20 "$1" | grep -q '^name:' || { echo "MISSING name: $1"; fail=1; }
  head -20 "$1" | grep -q '^description:' || { echo "MISSING description: $1"; fail=1; }
}
for f in .omp/agents/*.md .omp/skills/*/SKILL.md; do check_fm "$f"; done

# autoloadSkills referenced by agents must exist as skills
for s in $(grep -A4 '^autoloadSkills:' .omp/agents/*.md | grep -oE '^.*- [a-z-]+' | grep -oE '[a-z-]+$' | sort -u); do
  [ -f ".omp/skills/$s/SKILL.md" ] || { echo "MISSING autoloaded skill: $s"; fail=1; }
done

# vault template: 12 MOCs + core state files
for c in 01-identity 02-knowledge 03-projects 04-areas 05-relationships 06-creativity 07-systems 08-resources 09-media 10-events 11-questions 99-archive; do
  [ -f "vault-template/wiki/$c.md" ] && [ -d "vault-template/wiki/$c" ] || { echo "MISSING wiki template: $c"; fail=1; }
done
for f in tasks/inbox.md tasks/rhythms.json tracker/week.md wiki/_index.md wiki/log.md; do
  [ -f "vault-template/$f" ] || { echo "MISSING template file: $f"; fail=1; }
done

[ "$fail" = 0 ] && echo "Pack OK: agents, skills, autoloads, vault template."
exit "$fail"
