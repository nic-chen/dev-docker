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
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

ENV PATH="${PATH}:${HOME}/go/bin"
