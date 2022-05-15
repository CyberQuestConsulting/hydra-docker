#!/bin/bash

# Copyright 2022 Stephen Owens (Cyberquest Consulting). All rights reserved.  
# Use of this software is restricted by proprietary license. 
# Contact steveo98501@gmail.com for license info.

echo "Setting up $HYDRA_USER@$HYDRA_DB"

PGPASSWORD="$POSTGRES_PASSWORD" psql \
  -v "hydradb=$HYDRA_DB" \
  -v "hydrauser=$HYDRA_USER" \
  -v "hydrapassword=$HYDRA_PASSWORD" \
  -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" \
  --dbname "$POSTGRES_DB" << EOSQL
	  CREATE USER :hydrauser WITH ENCRYPTED PASSWORD :'hydrapassword';
	  CREATE DATABASE :hydradb;
	  GRANT ALL PRIVILEGES ON DATABASE :hydradb TO :hydrauser;
EOSQL