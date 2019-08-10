#!/bin/bash

cd "$(dirname "$0")"

read -p "Are you sure you want to remove your server? This action can not be reverted! " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Removing server..."
  cd docker-compose-lamp
  docker-compose down -v --rmi
  cd ..
  sudo rm -rf ./docker-compose-lamp
fi
