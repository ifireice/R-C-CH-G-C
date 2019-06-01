FROM golang:1.12.5 as builder

ENV GIT_REPO=https://github.com/lomik/carbon-clickhouse.git
ENV GIT_TAG=v0.10.1

WORKDIR /go/src/github.com/lomik

RUN git clone ${GIT_REPO} && \
    cd carbon-clickhouse && \
    git checkout tags/${GIT_TAG} && \
    make


FROM alpine:3.9

RUN mkdir -p /data/carbon-clickhouse && \
    mkdir -p /etc/carbon-clickhouse

COPY --from=builder /go/src/github.com/lomik/carbon-clickhouse/carbon-clickhouse /usr/bin/carbon-clickhouse

RUN mkdir /init
COPY ./conf/run.sh /init

# Add config
ADD ./conf/config.conf /etc/carbon-clickhouse/config.conf

EXPOSE 2003
EXPOSE 2004
EXPOSE 2005
EXPOSE 7007

VOLUME /data/carbon-clickhouse

CMD ["/init/run.sh"]

