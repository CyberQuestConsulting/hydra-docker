#!/bin/bash

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

