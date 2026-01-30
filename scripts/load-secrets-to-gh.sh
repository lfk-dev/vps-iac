#!/usr/bin/env bash

# Uploads secrets from a dotenv file (plain or SOPS-encrypted) to GitHub
# Assumes dotenv style: key=value pairs, no quotes or comments

set -euo pipefail

if [ -z "${1:-}" ]; then
    echo "Usage: $0 <file> (plain text or sops encrypted dotenv)"
    exit 1
fi

FILE="$1"

if [[ ! -f "$FILE" ]]; then
    echo "ERR: File not found: $FILE"
    exit 1
fi

# Decrypt if SOPS-encrypted, otherwise read plain
# Assume the default path to keys.txt
if [[ "$FILE" == *.enc.env ]] || [[ "$FILE" == *.enc ]]; then
    CONTENT=$(sops -d "$FILE")
else
    CONTENT=$(cat "$FILE")
fi

while IFS= read -r line; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    key="${line%%=*}"
    value="${line#*=}"
    echo "Setting secret: $key"
    echo "$value" | gh secret set "$key"
done <<< "$CONTENT"

echo "===FINISHED==="