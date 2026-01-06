#!/usr/bin/env bash

# Iterate throuh the docker directory and run docker compose with single .env file

# 1. Assumes that the current dir is always the deployment directory at `/srv/deployment` 
# 2. Docker compose `.env` file is in `/srv/deployment/docker`

cd docker

for d in */ ; do
  ( cd "$d" && docker compose --env-file ../.env up -d )
done
