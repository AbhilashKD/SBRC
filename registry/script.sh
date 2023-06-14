#!/bin/bash

docker exec -it keycloak_postgres_1 psql -U keycloak   -c "CREATE DATABASE registry;"

docker-compose up -d

sleep 10

docker restart registry_registry_1

