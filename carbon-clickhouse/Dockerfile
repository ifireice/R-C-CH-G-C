FROM golang:1.12.5

ENV GIT_REPO=https://github.com/lomik/carbon-clickhouse.git
ENV GIT_TAG=v0.10.1

WORKDIR /go/src/github.com/lomik

RUN git clone ${GIT_REPO} && \
    cd carbon-clickhouse && \
    git checkout tags/${GIT_TAG} && \
    make

RUN mkdir -p /go/bin && \
    mv /go/src/github.com/lomik/carbon-clickhouse/carbon-clickhouse /go/bin/carbon-clickhouse && \
    chmod 775 /go/bin/carbon-clickhouse

RUN mkdir -p /data/carbon-clickhouse && \
    mkdir -p /var/log/carbon-clickhouse && \
    mkdir -p /etc/carbon-clickhouse

# Add config
ADD ./conf/config.conf /etc/carbon-clickhouse/config.conf

RUN mkdir /init
COPY ./conf/run.sh /init

EXPOSE 2003
EXPOSE 2004
EXPOSE 2005
EXPOSE 7007

VOLUME /data/carbon-clickhouse

#ENTRYPOINT ["/go/bin/carbon-clickhouse", "-config=/etc/carbon-clickhouse/config.conf"]

CMD ["/init/run.sh"]
