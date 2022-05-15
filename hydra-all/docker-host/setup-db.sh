# Copyright Steve Owens (Cyberquest Consulting)


WD=`pwd`

docker run --network=hydraguide -v "${WD}/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d" \
	--name=hydra-postgres -p 5432:5432 --env-file=postgres.env -d postgres:14.2

 
 