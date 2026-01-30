#!/usr/bin/env bash

# The goal is to have docker compose up/down for all files in ./docker
# The script should scale with more compose files
# It assumes ./docker, that contains only directories, each with compose.yml
# The env file can be passed as variable, allowing for compatibility with sops


echo "=========================================="
echo "./scripts/deployment/deploy.sh STARTED"
echo "=========================================="

set -euo pipefail
# Required env vars
: "${COMPOSE_ENV_FILES:?Error: COMPOSE_ENV_FILES is not set}"
: "${DC_ACTION:?Error: DC_ACTION is not set}" # ideally it should be parsed into an array, but for now it's a string
: "${DOCKER_HOST:?Error: DOCKER_HOST is not set}"
# NOTE: i think it's safer to pass the compose file path as variable outside of the script.
# Better improvement would be to pass it as argument, but in GHA this workflow is very clean

DOCKER_DIR="./docker"

if [[ ! -d "$DOCKER_DIR" ]]; then
    echo "Error: docker directory not found at $DOCKER_DIR" >&2
    exit 1
fi

deploy_project() {
    local compose_file="$1"
    
    echo "==============START=================="
    echo "Deploying: ${compose_file}"

    # No checks needed, 'find' already returns compose.yml within the DOCKER_DIR
    
    # About project name precedence: https://docs.docker.com/compose/how-tos/project-name/
    # In my case, the "name:" is a good way to manage projects names.
    if ! docker compose -f "$compose_file" $DC_ACTION  ; then
        echo "Error: docker compose failed for ${compose_file}" >&2
        return 1
    fi


    echo "Successfully executed docker compose ${DC_ACTION} on ${compose_file}"
    echo "==============END=================="
    return 0
}

main() {


    # Find all compose.yml in DOCKER_DIR
    while IFS= read -r -d '' file; do
        found=1
        echo "file found=${file}"
        deploy_project "$file"
    done < <(find "${DOCKER_DIR}" -type f -name "compose.yml" -print0 | sort -z) 
    # NOTE: the sort ensures that directories with "NN" like "00-traefik" are deployed first
    # this is a simple way to apply order to deployment, traefik set's up external networks for other containers
    
    # This is a clean way of looping through the 'find' output
    # The process substitution "<(command)" outputs a single file that is redirected (second "<") to the while loop
    # The -print0 uses null character as delimiter (not visible in stdout), and the read -d '' is aware of it
    # This prevents issues with spaces or other special characters in filenames (although here not needed)

    if [[ "$found" -eq 0 ]]; then
        echo "Error: No compose.yml files found in ${DOCKER_DIR}" >&2
        exit 1
    fi
    
    echo "=========================================="
    echo "All deployments completed successfully"
    echo "=========================================="
}

main "$@"