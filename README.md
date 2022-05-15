# hydra-docker

This project contains docker build scripts and files for various hydra components.

### Copyright 2022 Steve Owens (Cyberquest Consulting)
**Use of this software is restricted by proprietary license.** 
**Contact steveo98501@gmail.com for license info.**


## hydra-all

This subfolder contains a docker file to build an optimized docker image running hydra server.  The subdirectory
docker-host contains setup scripts to be executed after the image is built using the **hydra-all/buildimage.sh** file.

Using the scripts in this folder enables you to stand up a local postgresql database with a persistent volume and a local docker container running hydra serve all which connects to the postgresql database.

1. **setup-env.sh** - creates postgres password, and hydra password.  Also creates the hydra.env and the postgres.env files.   It is important to ensure that this script is only run once per database setup. 

3. **setup-db.sh** - runs hydra-postgres container which must be run once after **setup-env.sh**, and before **setup-migrate.sh**.  

2. **setup-migrate.sh** - runs the database initialization which must be run once after **setup-db.sh** and before **setup-hydra.sh**

4. **setup-hydra.sh** - runs the hydra-all container which must happen after **setup-db.sh**. You can re-run this as many times as you want without having to re-run the previous files in the list.