FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig miner
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
      git \
      cmake \
      libuv-dev \
      libmicrohttpd-dev \
      build-base
RUN mkdir ./xmrigb && cd ./xmrigbuild && \
      git clone https://github.com/xmrig/xmrig && \
      cmake -DCMAKE_BUILD_TYPE=Release . && \
      make && \
      apk del \
      build-base \
      cmake \
      git
USER miner
WORKDIR    /xmrig
ENTRYPOINT ["./xmrig"]
