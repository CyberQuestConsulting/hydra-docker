# Copyright 2022 Steve Owens (Cyberquest Consulting)
# Use of this software is restricted by proprietary license. 
# Contact steveo98501@gmail.com for license info.

# Build stage
FROM --platform=linux/amd64 debian:11-slim AS builder

RUN apt-get update -y
RUN apt-get install -y curl unzip build-essential checkinstall zlib1g-dev

RUN mkdir /src
WORKDIR /src
COPY bin-src/go1.18.2.linux-amd64.tar.gz ./
RUN tar -xzvf go1.18.2.linux-amd64.tar.gz
RUN chown root:root ./go
RUN mv go /usr/local

ENV PATH=$PATH:/usr/local/go/bin

COPY bin-src/hydra-master.zip ./

RUN unzip hydra-master.zip
WORKDIR /src/hydra-master
RUN go build

RUN mkdir /src/gen-cert
COPY bin-src/generate-cert.go /src/gen-cert/
WORKDIR /src/gen-cert/
RUN go build generate-cert.go


# Final Stage
FROM --platform=linux/amd64 debian:11-slim

RUN mkdir /app

COPY --from=builder /src/hydra-master/hydra /app/
COPY --from=builder /src/gen-cert/generate-cert /app/

ENV PATH=$PATH:/app

RUN useradd -r hydra
RUN chown -R hydra:hydra /app

COPY img/config.yaml /app/
COPY img/startup.sh /app/
RUN chmod +x /app/startup.sh

EXPOSE 4445

USER hydra
WORKDIR /app

CMD /app/startup.sh
