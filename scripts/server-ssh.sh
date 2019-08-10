#!/bin/bash

cd "$(dirname "$0")"

source "../.env"
docker exec -it $PROJECT_NAME-webserver /bin/bash

