#!/bin/bash

cd "$(dirname "$0")" || exit

source "../.env"
cd ..
docker exec -it $PROJECT_NAME-webserver mysqldump -h mysql -u root -proot devsetup_db > dump.sql