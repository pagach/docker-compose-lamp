#!/bin/bash

cd "$(dirname "$0")" || exit

if [ ! -f "../../dumps/init.sql.gz" ]; then
  echo "Dump file not found."
  exit 0
fi

read -p "Are you sure you want to import database? This will remove all you current changes! " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  source "../.env"
  cd ..
  docker exec -it $PROJECT_NAME-webserver mysql -h mysql -u root -proot devsetup_db < dump.sql
fi
