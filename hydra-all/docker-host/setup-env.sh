#!/bin/bash

# Copyright 2022 Stephen Owens (Cyberquest Consulting). All rights reserved.
# Use of this software is restricted by proprietary license. 
# Contact steveo98501@gmail.com for license info.

# The system secret can only be set against a fresh database. Key rotation is not supported. This
# secret is used to encrypt the database and needs to be set to the same value every time the process (re-)starts.
# You can use /dev/urandom to generate a secret. But make sure that the secret must be the same anytime you define it.
# You could, for example, store the value somewhere.

generate_password() {
  result=`head -c 32 /dev/urandom | base64 | tr '/+' '_-' | tr -d '='`
  echo "$result"
}

PG_PASSWORD=$(generate_password)
HYDRA_PASSWORD=$(generate_password)
HYDRA_USER=hydra
HYDRA_DB=hydra

echo "POSTGRES_USER=postgres" > postgres.env
echo "POSTGRES_DB=postgres" >> postgres.env
echo "POSTGRES_PASSWORD=$PG_PASSWORD" >> postgres.env
echo "HYDRA_USER=$HYDRA_USER" >> postgres.env
echo "HYDRA_DB=$HYDRA_DB" >> postgres.env
echo "HYDRA_PASSWORD=$HYDRA_PASSWORD" >> postgres.env
echo "POSTGRES_HOST_AUTH_METHOD=scram-sha-256" >> postgres.env


DSN="postgres://${HYDRA_USER}:${HYDRA_PASSWORD}@hydra-postgres:5432/$HYDRA_DB?sslmode=disable"

echo "SECRETS_SYSTEM=$HYDRA_PASSWORD" > hydra.env
echo "DSN=$DSN" >> hydra.env
echo "URLS_SELF_ISSUER=https://localhost:4444/" >> hydra.env
echo "URLS_CONSENT=http://localhost:9020/consent" >> hydra.env
echo "URLS_LOGIN=http://localhost:9020/login" >> hydra.env


unset NW_EXISTS
docker network ls|grep hydraguide > /dev/null || NW_EXISTS=true
if [ "$NW_EXISTS" ]; then
  docker network create hydraguide
else
  echo "Network 'hydraguide' already exists."
fi
