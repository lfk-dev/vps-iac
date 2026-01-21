#!/usr/bin/env bash
set -euo pipefail

# Templates every file under ./configs
# Ran by the GHA runner, assumes working dir is the root of the repo

REPO_ROOT=$(pwd)
DEST_DIR="${REPO_ROOT}/tmp"

# check if i can make the tmp dir
mkdir -p "${DEST_DIR}" || { echo "Could not make tmp dir" >&2; exit 1; }

# this structure avoids subshell issue with runnig loop as pipe of find output
# IFS= prevents trimming leading/trailing whitespace
# -r prevents backslash escaping
# -d '' uses null character as delimiter (safe for filenames with spaces)

while IFS= read -r -d '' file; do
    # preserve directory structure (so ./tmp can be copied to /etc/srv/ on host)
    
    # ${file#...} removes the prefix of ${REPO_ROOT}/configs/ from the path, outputning
    # clear structure that can be copied to /etc/srv/ on host (for example prometheus/prometheus.yml)
    # IMPORTANT: dirname here would produce the dirpath from the root dir `/`, not repo root
    relative_path="${file#"${REPO_ROOT}/configs/"}"
    output_file="${DEST_DIR}/${relative_path}"
    
    mkdir -p "$(dirname "$output_file")"
    envsubst < "$file" > "$output_file"
    echo "Templated $file -> $output_file"
done < <(find "${REPO_ROOT}/configs" -type f -print0)