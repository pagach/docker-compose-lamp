#!/usr/bin/bash
DEFAULT_PROJECT_NAME=${PWD##*/}
cd "$(dirname "$0")"

rm -rf .git

C='\033[1;33m'
NC='\033[0m' # No Color

if [ ! -f "./.env" ]; then
  printf "Welcome to docker-compose-lamp setup!\n\n"

  read -p "Set admin email [webmaster@localhost]: " ADMIN_EMAIL
  ADMIN_EMAIL=${ADMIN_EMAIL:-webmaster@localhost}
  printf "Admin email set to ${C}$ADMIN_EMAIL${NC}\n\n"

  read -p "Set project name [${DEFAULT_PROJECT_NAME}]: " PROJECT_NAME
  PROJECT_NAME=${PROJECT_NAME:-${DEFAULT_PROJECT_NAME}}
  printf "Project name set to ${C}$PROJECT_NAME${NC}\n\n"

  read -p "Set folder as document root or . to use current folder [web]: " DOCUMENT_ROOT
  DOCUMENT_ROOT=${DOCUMENT_ROOT:-web}
  printf "Folder used as document root: ${C}$DOCUMENT_ROOT${NC}\n\n"

  printf "Generating .env file...\n\n"
  echo "PROJECT_NAME=$PROJECT_NAME" >> .env
  echo "DATABASE_NAME=devsetup_db" >> .env
  echo "DATABASE_USER=devsetup_db" >> .env
  echo "DATABASE_PASSWORD=devsetup_db" >> .env

  USER_ID=$(id -u)
  echo "USER_ID=$USER_ID" >> .env

  GROUP_ID=$(id -g)
  echo "GROUP_ID=$GROUP_ID" >> .env

  printf "Generating vhost...\n\n"
  cat > lamp/config/vhosts/default.conf << EOL
<VirtualHost *:80>
    ServerAdmin ${ADMIN_EMAIL}
    DocumentRoot "/var/www/html/${DOCUMENT_ROOT}"
    ServerName ${PROJECT_NAME}.localhost
	<Directory "/var/www/html/${DOCUMENT_ROOT}">
		Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Order allow,deny
    allow from all
    Require all granted
	</Directory>
</VirtualHost>
EOL

  cd ..

  if ! grep -q "/devsetup" .gitignore;
  then
    printf "Git ignoring...\n\n"
    echo "" >> .gitignore #add new line
    echo "/devsetup" >> .gitignore
  fi

  printf "Server created.\n\n"
else
  printf "Server already initialized..."
fi

printf "Available commands (execute from project root folder):\n"
printf "Start server: ${C}./devsetup/scripts/server-start.sh${NC}\n"
printf "SSH to container: ${C}./devsetup/scripts/server-ssh.sh${NC}\n"
printf "Remove: ${C}./devsetup/scripts/server-remove.sh${NC}\n"

printf "\nDrupal 8 commands (execute from project root folder):\n"
printf "Dump database: ${C}./devsetup/scripts/drush-dump.sh${NC}\n"
printf "Import database dump: ${C}./devsetup/scripts/drush-importdump.sh${NC}\n"
