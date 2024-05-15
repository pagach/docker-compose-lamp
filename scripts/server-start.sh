#!/usr/bin/bash

cd "$(dirname "$0")"

echo "Stoping other servers..."
docker stop $(docker ps -a -q)

echo "Starting server..."
cd ..
docker-compose up -d

source ".env"
echo "Server started..."
echo "Access site at http://$PROJECT_NAME.localhost/"
echo "Access phpmyadmin at http://$PROJECT_NAME.localhost:8080"
