FROM golang:1.12.5 as builder

ENV GIT_REPO=https://github.com/go-graphite/carbonapi.git

WORKDIR /go/src/github.com/go-graphite

RUN git clone ${GIT_REPO} && \
    cd carbonapi && \
    make nocairo


FROM alpine:3.9

COPY --from=builder /go/src/github.com/go-graphite/carbonapi/carbonapi /usr/bin/carbonapi

# Add config
ADD ./conf/carbonapi.yaml /etc/carbonapi/carbonapi.yaml

RUN mkdir /init
COPY ./conf/run.sh /init

EXPOSE 8081

CMD ["/init/run.sh"] 
