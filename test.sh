#!/bin/sh
set -euf

mkdir -p test_results
chmod 777 test_results

docker-compose down --volumes --remove-orphans
docker-compose pull || true
docker-compose build --force-rm
docker-compose run --rm tester
