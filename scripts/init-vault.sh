#!/usr/bin/env bash
# Scaffold vault/ from vault-template/. Never overwrites existing files.
set -euo pipefail
cd "$(dirname "$0")/.."

dest="${1:-vault}"
mkdir -p "$dest"
# -n: no-clobber; copies files + .gitkeep placeholders, creates dirs as needed
cp -Rn vault-template/ "$dest/" 2>/dev/null || cp -R -n vault-template/ "$dest/"
find "$dest" -name .gitkeep -delete
echo "Vault ready at $dest/ (existing files untouched)."
