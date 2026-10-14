#!/usr/bin/env bash
# Bumps the contentVersion in manifest.json.
# Usage: ./bump_version.sh [patch|minor|major]   (default: patch)
set -euo pipefail

PART="${1:-patch}"
FILE="$(dirname "$0")/manifest.json"

if [ ! -f "$FILE" ]; then
  echo "manifest.json পাওয়া যায়নি: $FILE" >&2
  exit 1
fi

python3 - "$FILE" "$PART" <<'PY'
import json, sys
from datetime import date

path, part = sys.argv[1], sys.argv[2]
with open(path, encoding="utf-8") as f:
    data = json.load(f)

version = data.get("contentVersion", "1.0.0").split(".")
while len(version) < 3:
    version.append("0")
major, minor, patch = (int(x) for x in version[:3])

if part == "major":
    major, minor, patch = major + 1, 0, 0
elif part == "minor":
    minor, patch = minor + 1, 0
else:
    patch += 1

data["contentVersion"] = f"{major}.{minor}.{patch}"
data["updatedAt"] = date.today().isoformat()

with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
    f.write("\n")

print(f"contentVersion -> {data['contentVersion']} ({part})")
PY
