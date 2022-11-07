FROM ubuntu:latest

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

ENV PATH="${PATH}:${HOME}/go/bin"
