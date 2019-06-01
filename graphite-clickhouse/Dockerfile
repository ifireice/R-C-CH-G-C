FROM golang:1.12.5 as builder

ENV GIT_REPO=https://github.com/lomik/graphite-clickhouse.git
ENV GIT_TAG=v0.9.0

WORKDIR /go/src/github.com/lomik

RUN git clone ${GIT_REPO} && \
    cd graphite-clickhouse && \
    git checkout tags/${GIT_TAG} && \
    make


FROM alpine:3.9

RUN mkdir -p /data/graphite-clickhouse && \
    mkdir -p /etc/graphite-clickhouse

COPY --from=builder /go/src/github.com/lomik/graphite-clickhouse/graphite-clickhouse /usr/bin/graphite-clickhouse

# Add configs
ADD ./conf/graphite-clickhouse.conf /etc/graphite-clickhouse/graphite-clickhouse.conf
ADD ./conf/rollup.xml /etc/graphite-clickhouse/rollup.xml			
ADD ./conf/users.xml /etc/graphite-clickhouse/users.xml

RUN mkdir /init
COPY ./conf/run.sh /init

EXPOSE 9090

VOLUME /data/graphite-clickhouse

CMD ["/init/run.sh"] 