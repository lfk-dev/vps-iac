#!/usr/bin/env bash

# assumes single file in dotenv style, with key=value pairs, no parentesis or comments

if [ -z "$1" ]; then
    echo "Usage: $0 <file>, while in git repo"
    exit 1
fi

while IFS= read -r line; do
  [[ -z "$line" || "$line" =~ ^# ]] && continue
  key="${line%%=*}" #key is before the first =
  value="${line#*=}" # value after the first =
  echo "$value" | gh secret set "$key"
done < $1