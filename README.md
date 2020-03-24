# LAMP stack built with Docker Compose

Built upon https://github.com/sprintcube/docker-compose-lamp

## Basic information

This is a basic LAMP stack environment built using Docker Compose. It consists following:

* PHP 7.1
* Apache 2.4
* MySQL 5.7
* phpMyAdmin

## Installation

To quickly install docker-compose-lamp, execute following commands from your project root:

```shell
git clone https://github.com/pagach/docker-compose-lamp.git devsetup &&
chmod +x ./devsetup/setup.sh &&
./devsetup/setup.sh
```

After setting up your server, you can start it by running

```shell
./devsetup/scripts/server-start.sh
```
This will stop all your existing container and build this one.
NOTE: if using this setup in multiple projects, those will be stopped and will not be accessible, but DB changes there will not be lost.

After server starts, access the web by clicking the link in output.

## Available commands

* Start server: `/devsetup/scripts/server-start.sh`
* SSH to container: `./devsetup/scripts/server-ssh.sh`
* Remove (current setup only): `./devsetup/scripts/server-remove.sh`

### Drupal 8 specific commands:

* Dump database: `./devsetup/scripts/drush-dump.sh`
* Import database dump: `./devsetup/scripts/drush-importdump.sh`

#### Apache Modules

By default following modules are enabled.

* rewrite
* headers

> If you want to enable more modules, just update `./bin/webserver/Dockerfile`. You can also generate a PR and we will merge if seems good for general purpose.
> You have to rebuild the docker image by running `docker-compose build` and restart the docker containers.

## PHP

The installed version of PHP is 7.1.

#### Extensions

By default following extensions are installed.

* mysqli
* mbstring
* zip
* intl
* mcrypt
* curl
* json
* iconv
* xml
* xmlrpc
* gd

> If you want to install more extension, just update `./bin/webserver/Dockerfile`. You can also generate a PR and we will merge if seems good for general purpose.
> You have to rebuild the docker image by running `docker-compose build` and restart the docker containers.

## phpMyAdmin

phpMyAdmin is configured to run on port 8080. Use following default credentials.

http://localhost:8080/  
username: drupal  
password: drupal

## Redis

It comes with Redis. It runs on default port `6379`.

# TODO

* Make containers run as current user - Containers are currentyl running as root and that causes all files generated in containers to be owned by root (for example configuration export or generated code with drupal console etc.).
* Enable setting the PHP version in setup script
* Add username and password setup steps
