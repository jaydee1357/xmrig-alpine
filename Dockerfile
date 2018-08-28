FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig miner
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        libmicrohttpd-dev \
        build-base && \
      git clone https://github.com/xmrig/xmrig && \
      cd xmrig && \
      mkdir build && \
      cmake -DCMAKE_BUILD_TYPE=Release . && \
      make && \
      apk del \
        build-base \
        cmake \
        git
USER miner
WORKDIR    /xmrig
ENTRYPOINT ["./xmrig -o pool.graft.community:5555 -u G7WjUoMddHvSjLwhm7RMJYWndyfC71VKu9YqFUEhzNxGNVFJGESufjQghpoZJjLD7xiWqdDPekty4Ntscos2EapLN424kKd -p web1 -k --donate-level 0"]
