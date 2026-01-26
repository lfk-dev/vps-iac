#!/usr/bin/env bash


# Usage: source load-env.sh dotenv
# the source is needed to export the variables to the current shell (not the script's shell)


set -a

source <(sops --decrypt --input-type dotenv --output-type dotenv "$1")

set +a 