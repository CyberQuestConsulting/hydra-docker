#!/bin/bash

SECRETS_SYSTEM=`head -c 32 /dev/urandom | base64`
SECRETS_SYSTEM=${SECRETS_SYSTEM/\//%}
SECRETS_SYSTEM=${SECRETS_SYSTEM/\=/}

docker secret create system_secret <<< "$SECRETS_SYSTEM"
