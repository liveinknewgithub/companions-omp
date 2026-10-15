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
[ "${1:-}" = "--uninstall" ] && uninstall=1

link_one() { # src dst
  if [ -L "$2" ] && [ "$(readlink "$2")" = "$1" ]; then
    [ "$uninstall" = 1 ] && { rm "$2"; echo "removed $2"; }
    return
  fi
  [ "$uninstall" = 1 ] && return
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
[ "$uninstall" = 0 ] && echo "Done. Restart omp (or open a new session) to pick up the companions."
