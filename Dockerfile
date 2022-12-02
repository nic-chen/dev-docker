FROM ubuntu:latest

ARG DOCKER_CHANNEL=stable
ARG DOCKER_VERSION=20.10.8

RUN apt update -y \
    && apt install -y software-properties-common \
    && add-apt-repository -y ppa:longsleep/golang-backports \
    && apt update -y \
    && apt install -y --no-install-recommends \
    curl \
    ca-certificates \
    golang-go \
    openssh-client \
    sudo \
    telnet \
    time \
    tzdata \
    unzip \
    wget \
    zip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

RUN set -vx; \
    curl -f -L -o docker.tgz https://download.docker.com/linux/static/${DOCKER_CHANNEL}/${ARCH}/docker-${DOCKER_VERSION}.tgz \
    && tar zxvf docker.tgz \
    && install -o root -g root -m 755 docker/docker /usr/local/bin/docker \
    && rm -rf docker docker.tgz

ENV PATH="${PATH}:${HOME}/go/bin"
