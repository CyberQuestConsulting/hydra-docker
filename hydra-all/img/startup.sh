#!/bin/bash

# Copyright 2022 Stephen Owens (Cyberquest Consulting).  All rights reserved.
# Use of this software is restricted by proprietary license. 
# Contact steveo98501@gmail.com for license info.

if [ -z "${HOST_HOSTNAME}" ]; then
   echo "Using defalt hostname"
   HOST_HOSTNAME=`hostname`
fi

echo "HOST_HOSTNAME=$HOST_HOSTNAME"

/app/generate-cert --host "${HOST_HOSTNAME}" --ed25519 --ecdsa-curve P521

echo "Certificates generated."
echo "Startup environment: "
env

echo "Starting application:"
#exec /bin/bash

exec /app/hydra serve all 

