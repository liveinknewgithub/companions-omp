#!/usr/bin/env bash
# Install the companions pack into omp's user dirs via symlinks, so repo edits
# propagate live. Project-local use needs none of this — just run `omp` here.
#
#   scripts/install.sh              link agents + skills into ~/.omp/agent/
#   scripts/install.sh --uninstall  remove only symlinks pointing at this repo
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
agents_dir="$HOME/.omp/agent/agents"
skills_dir="$HOME/.omp/agent/skills"

uninstall=0
if [ "${1:-}" = "--uninstall" ]; then uninstall=1; fi

link_one() { # src dst
  if [ -L "$2" ] && [ "$(readlink "$2")" = "$1" ]; then
    if [ "$uninstall" = 1 ]; then rm "$2"; echo "removed $2"; fi
    return
  fi
  if [ "$uninstall" = 1 ]; then return; fi
  if [ -e "$2" ] || [ -L "$2" ]; then
    echo "SKIP $2 (exists, not ours)"; return
  fi
  ln -s "$1" "$2"; echo "linked $2 -> $1"
}

mkdir -p "$agents_dir" "$skills_dir"
for f in "$root"/.omp/agents/*.md; do
  link_one "$f" "$agents_dir/$(basename "$f")"
done
for d in "$root"/.omp/skills/*/; do
  link_one "${d%/}" "$skills_dir/$(basename "$d")"
done
if [ "$uninstall" = 0 ]; then echo "Done. Restart omp (or open a new session) to pick up the companions."; fi
