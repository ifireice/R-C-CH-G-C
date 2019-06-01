FROM golang:1.12.5

ENV GIT_REPO=https://github.com/lomik/graphite-clickhouse.git
ENV GIT_TAG=0.9.0

WORKDIR /go/src/github.com/lomik

RUN git clone ${GIT_REPO} && \
    cd graphite-clickhouse && \
    git checkout tags/${GIT_TAG} && \
    make

RUN mkdir -p /go/bin && \
    mv /go/graphite-clickhouse/graphite-clickhouse /go/bin/graphite-clickhouse && \
    chmod 775 /go/bin/graphite-clickhouse

RUN mkdir -p /data/graphite-clickhouse && \
    mkdir -p /etc/graphite-clickhouse

# Add configs
ADD ./conf/graphite-clickhouse.conf /etc/graphite-clickhouse/graphite-clickhouse.conf
ADD ./conf/rollup.xml /etc/graphite-clickhouse/rollup.xml			
ADD ./conf/users.xml /etc/graphite-clickhouse/users.xml

RUN mkdir /init
COPY ./conf/run.sh /init

EXPOSE 9090

VOLUME /data/graphite-clickhouse

#ENTRYPOINT ["/go/bin/graphite-clickhouse", "-config=/etc/graphite-clickhouse/graphite-clickhouse.conf"]

CMD ["/init/run.sh"] 
