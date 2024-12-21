FROM openresty/openresty:1.21.4.4-0-buster-fat
    
RUN tee /etc/apt/sources.list.d/ddebs.list << EOF
    deb http://ddebs.ubuntu.com/ $(lsb_release -cs) main restricted universe multiverse
    deb http://ddebs.ubuntu.com/ $(lsb_release -cs)-updates  main restricted universe multiverse
    deb http://ddebs.ubuntu.com/ $(lsb_release -cs)-proposed main restricted universe multiverse
EOF

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
