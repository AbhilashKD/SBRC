#!/bin/bash

docker exec -it keycloak_postgres_1 psql -U keycloak   -c "CREATE DATABASE metabase;"


docker-compose up -d

docker cp clickhouse.metabase-driver.jar  metabase_metabase_1:/plugins/


docker restart metabase_metabase_1

