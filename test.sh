#!/bin/sh
set -euf

docker-compose down --volumes --remove-orphans
docker-compose pull || true
docker-compose build --force-rm
docker-compose run --rm tester
