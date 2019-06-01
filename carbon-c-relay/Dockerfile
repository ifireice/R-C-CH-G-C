FROM alpine:3.9 as builder

ENV GIT_REPO=https://github.com/grobian/carbon-c-relay.git \
    GIT_TAG=v3.5 

RUN apk add --quiet --no-cache \
    git \
    make \
    gcc \
    g++ \
    flex \
    musl-dev \
    openssl-dev \
    zlib-dev \
    lz4-dev

WORKDIR /tmp

RUN git clone ${GIT_REPO} && \
    cd carbon-c-relay && \ 
    git checkout tags/${GIT_TAG}

WORKDIR /tmp/carbon-c-relay

RUN ./configure && \
  make && make install

FROM alpine:3.9

ENV TZ='Asia/Yekaterinburg'

RUN apk update --quiet --no-cache && \
    apk add    --quiet --no-cache \
    shadow \
    lz4-libs \
    zlib \
    openssl \
    tzdata && \
    cp "/usr/share/zoneinfo/${TZ}" /etc/localtime && \
    echo "${TZ}" > /etc/timezone 

COPY --from=builder /usr/local/bin/relay /usr/bin/

# Add config
ADD ./conf/carbon-c-relay.conf /etc/carbon-c-relay/carbon-c-relay.conf

RUN mkdir /init
COPY ./conf/run.sh /init

EXPOSE 2003

CMD ["/init/run.sh"]
