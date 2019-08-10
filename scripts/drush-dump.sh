#!/bin/bash

cd "$(dirname "$0")"

source "../.env"
cd ..
docker exec -it $PROJECT_NAME-webserver ./vendor/bin/drush sql-dump --gzip --debug --result-file=../dumps/init.sql

