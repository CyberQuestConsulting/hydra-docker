# 
# Copyright 2022 Stephen Owens (Cyberquest Consulting).  All rights reserved.
# Use of this software is restricted by proprietary license. 
# Contact steveo98501@gmail.com for license info.

WD=`pwd`

if [ -d "${WD}/postgres-data" ]; then
  echo "'"${WD}/postgres-data" ' directory found.  Aborting script. To run this script delete '."${WD}/postgres-data" '"
  return 1
fi

mkdir "${WD}/postgres-data"

docker run --network=hydraguide -v "${WD}/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d" \
	-v "${WD}/postgres-data:/var/lib/postgresql/data" \
	--name=hydra-postgres -p 5432:5432 --env-file=postgres.env -d postgres:14.2
	
	
docker run -d --platform=linux/amd64 --name=hydra-migrate --network=hydraguide --env-file hydra.env \
   -p 4445:4445 -p 4444:4444 --rm hydra-all /app/hydra migrate sql -e -y
 