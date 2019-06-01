FROM golang:1.12.5

ENV GIT_REPO=https://github.com/go-graphite/carbonapi.git

WORKDIR /go/src/github.com/go-graphite

RUN git clone ${GIT_REPO} && \
    cd carbonapi && \
    make nocairo

RUN mkdir -p /go/bin && \
    mv /go/src/github.com/go-graphite/carbonapi/carbonapi /go/bin/carbonapi && \
    chmod 775 /go/bin/carbonapi


# Add default config
ADD ./conf/carbonapi.yaml /etc/carbonapi/carbonapi.yaml

RUN mkdir /init
COPY ./conf/run.sh /init

EXPOSE 8081

#ENTRYPOINT ["/go/bin/carbonapi", "-config=/etc/carbonapi/carbonapi.yaml"]

CMD ["/init/run.sh"] 
