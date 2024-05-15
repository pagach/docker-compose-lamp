#!/usr/bin/bash

cd "$(dirname "$0")" || exit

read -p "Are you sure you want to remove your server? This action can not be reverted! " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Removing server..."
  cd devsetup || exit
  docker-compose down -v --rmi all
  cd ..
  sudo rm -rf ./devsetup
fi
