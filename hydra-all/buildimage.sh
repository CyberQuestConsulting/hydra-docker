#/bin/bash

if [ -f bin-src/go1.18.2.linux-amd64.tar.gz ]; then
   echo "Already have go binary downloaded. Skipping download."
else
   curl -o bin-src/go1.18.2.linux-amd64.tar.gz https://dl.google.com/go/go1.18.2.linux-amd64.tar.gz
fi

if [ -f bin-src/hydra-master.zip ]; then
   echo "Already have hydra master source code. Skipping download."
else
   curl -o bin-src/hydra-master.zip https://codeload.github.com/ory/hydra/zip/refs/heads/master
fi

docker build --platform=linux/amd64 -t hydra-all .

