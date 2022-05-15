# Copyright Steve Owens (Cyberquest Consulting)

# The system secret can only be set against a fresh database. Key rotation is not supported. This
# secret is used to encrypt the database and needs to be set to the same value every time the process (re-)starts.
# You can use /dev/urandom to generate a secret. But make sure that the secret must be the same anytime you define it.
# You could, for example, store the value somewhere.

docker rm -f hydra-all


docker run -d --platform=linux/amd64 --name=hydra-all --network=hydraguide --env-file hydra.env \
   -p 4445:4445 -p 4444:4444 hydra-all
  
