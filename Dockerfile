FROM alpine:latest 

RUN adduser -S -D -H -h /xmrig miner 

RUN   apk --no-cache update && \
      apk --no-cache upgrade && \
      apk --no-cache add git cmake libuv-dev libmicrohttpd-dev bash tzdata \
      build-base && \
      git clone https://github.com/xmrig/xmrig /tmp/xmrig_build && \
      cd /tmp/xmrig_build && \
      sed -i "s/kDefaultDonateLevel = 5/kDefaultDonateLevel = 0/g" /tmp/xmrig_build/src/donate.h && \
      mkdir build && \
      cmake -DCMAKE_BUILD_TYPE=Release . && \
      make && \
      apk del --purge build-base cmake git && \
      mkdir /xmrig && \
      mv /tmp/xmrig_build/xmrig /xmrig && \
      rm -rf /tmp/*

COPY script.sh /xmrig/script.sh 

RUN chmod +x /xmrig/script.sh 

USER miner 

WORKDIR /xmrig 

ENV POOL_URL POOL_URL 
ENV POOL_USER WALLET_ID 
ENV POOL_PW x 
ENV MAX_CPU 100 
ENV USE_SCHEDULER false 
ENV START_TIME 2100 
ENV STOP_TIME 0600 
ENV DAYS Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday

# Set entrypoint
ENTRYPOINT ./script.sh $ALGO_MODE $POOL_URL $POOL_USER $POOL_PW $MAX_CPU $USE_SCHEDULER $START_TIME $STOP_TIME $DAYS
