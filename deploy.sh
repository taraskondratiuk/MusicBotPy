#!/bin/bash
set -euo pipefail

docker compose build --no-cache
docker compose up -d
docker image prune -f
