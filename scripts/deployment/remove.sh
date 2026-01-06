#!/usr/bin/env bash

# Compose down

cd docker
for d in */ ; do
  ( cd "$d" && docker compose --env-file ../.env down )
done

