#!/bin/bash

cd "$(dirname "$0")"

if [ ! -d "../../dumps/init.sql" ]; then
  echo "Dump file not found."
  exit 0
fi

read -p "Are you sure you want to import database? This will remove all you current changes! " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  source "../.env"
  cd ..
  docker exec -it $PROJECT_NAME-webserver sh -c './vendor/bin/drush sql-drop -y &&
    echo "Importing init dump..." &&
    zcat ./dumps/init.sql.gz | ./vendor/bin/drush sqlc'
fi
