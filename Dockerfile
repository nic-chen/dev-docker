FROM openresty/openresty:1.21.4.4-0-buster-fat

RUN CODENAME=$(lsb_release -cs) && \
    bash -c 'tee /etc/apt/sources.list.d/ddebs.list << EOF \
deb http://ddebs.ubuntu.com/ '"${CODENAME}"' main restricted universe multiverse \
deb http://ddebs.ubuntu.com/ '"${CODENAME}"'-updates main restricted universe multiverse \
deb http://ddebs.ubuntu.com/ '"${CODENAME}"'-proposed main restricted universe multiverse \
EOF'

RUN apt update -y \
    && apt install -y ubuntu-dbgsym-keyring \
    && apt install -y linux-image-$(uname -r)-dbgsym \
    && apt install -y systemtap gdb procps vim \
    && cd /usr/local \
    && git clone https://github.com/api7/stapxx.git -b luajit-gc64 \
    && git clone https://github.com/openresty/openresty-systemtap-toolkit.git \
    && git clone https://github.com/brendangregg/FlameGraph.git

ENV STAP_PLUS_HOME="/usr/local/stapxx"
ENV PATH="${PATH}:/usr/local/stapxx:/usr/local/stapxx/samples:/usr/local/openresty-systemtap-toolkit:/usr/local/FlameGraph"
