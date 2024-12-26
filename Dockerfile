FROM api7/api7-ee-3-gateway:3.3.2

USER root

RUN apt update -y \
    && apt install -y build-essential gdb procps vim git elfutils libdw-dev libssl-dev libavahi-client-dev wget librpm-dev libreadline-dev \
    && cd /usr/local \
    && git clone https://github.com/api7/stapxx.git -b luajit-gc64 \
    && git clone https://github.com/openresty/openresty-systemtap-toolkit.git \
    && git clone https://github.com/brendangregg/FlameGraph.git
    
RUN wget http://sourceware.org/systemtap/ftp/releases/systemtap-5.1.tar.gz \
    && tar -zxvf systemtap-5.1.tar.gz && rm systemtap-5.1.tar.gz \
    && mv systemtap-5.1 /usr/local/systemtap \
    && cd /usr/local/systemtap \
    && ./configure && make all && make install && stap --version

ENV STAP_PLUS_HOME="/usr/local/stapxx"
ENV PATH="${PATH}:/usr/local/stapxx:/usr/local/stapxx/samples:/usr/local/openresty-systemtap-toolkit:/usr/local/FlameGraph"
