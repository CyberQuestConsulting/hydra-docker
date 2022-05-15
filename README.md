# hydra-docker

This project contains docker build scripts and files for various hydra components.

## Copyright 2022 Steve Owens (Cyberquest Consulting)
**Use of this software is restricted by proprietary license.** 
**Contact steveo98501@gmail.com for license info.**


## hydra-all

This subfolder contains a docker file to build an optimized docker image running hydra server.  The subdirectory
docker-host contains setup scripts to be executed after the image is built using the **hydra-all/buildimage.sh** file.

1. **setup-env.sh** - creates postgres password, and hydra password.  Also creates the hydra.env and the postgres.env files.   All files in the list after this may be run as many times as you want without running this script again.

3. **setup-db.sh** - runs hydra-postgres container which must happen after **setup-env.sh**, and before **setup-migrate.sh**.  All files in the list after this may be run as many times as you want without running this script again, provided you have not run any files previous to this in the list without running this one again.

2. **setup-migrate.sh** - runs the database initialization which must happen after **setup-db.sh**, and before **setup-db.sh**.  You should only run this script once per brand new database, in other words after execution of
**setup-db.sh** and confirmation that the hydra-postgres container is running.

4. **setup-hydra.sh** - runs the hydra-all container which must happen after **setup-db.sh**. You can re-run this as many times as you want without having to re-run the previous files in the list.