#!/usr/bin/env bash

# Compose down

cd docker
for d in */ ; do
    echo "Removing $d"
    ( cd "$d" && docker compose --env-file ../.env down )
done
cd ..
