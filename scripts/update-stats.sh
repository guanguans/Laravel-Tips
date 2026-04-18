#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

total=0
for file in tips/*.md; do
    count=$(grep -c '^## ' "$file" || true)
    total=$((total + count))
    name=$(basename "$file")
    sed -i.bak -E "s|(\(\./tips/${name}\))[[:space:]]*\([^)]*\)|\1 (${count} tips)|" README.md
    echo "  ${name}: ${count}"
done
rm -f README.md.bak

printf '{"totalTips":%d}\n' "$total" > stats.json
echo "Total tips: ${total}"
