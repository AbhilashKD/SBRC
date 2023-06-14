#!/bin/bash

docker-compose up -d

sleep 5

docker exec local_keycloak /opt/jboss/keycloak/bin/add-user-keycloak.sh -u admin -p admin && docker restart local_keycloak


sleep 30

docker exec local_keycloak /opt/jboss/keycloak/bin/kcadm.sh config credentials --server  http://local_keycloak:8080/auth  --realm master --user admin --password admin

docker exec local_keycloak /opt/jboss/keycloak/bin/kcadm.sh create realms --set "realm=sunbird-rc"  --set "enabled=true"

docker exec local_keycloak /opt/jboss/keycloak/bin/add-user-keycloak.sh  -r sunbird-rc -u admin-app -p admin  && docker restart local_keycloak

sleep 30

docker exec local_keycloak /opt/jboss/keycloak/bin/kcreg.sh config credentials --server  http://local_keycloak:8080/auth  --realm sunbird-rc --user admin-app --password admin

#docker exec local_keycloak /opt/jboss/keycloak/bin/kcreg.sh create -s clientId=admin-api

docker exec local_keycloak /opt/jboss/keycloak/bin/kcreg.sh create -s clientId=registry-frontend

docker exec local_keycloak /opt/jboss/keycloak/bin/kcadm.sh config credentials --server  http://local_keycloak:8080/auth  --realm master --user admin --password admin

docker exec local_keycloak /opt/jboss/keycloak/bin/kcadm.sh create clients -r sunbird-rc -s clientId=admin-api -s enabled=true -s clientAuthenticatorType=client-secret -s secret=d0b8122f-8dfb-46b7-b68a-f5cc4e25d000



