#!/bin/sh

config_file="/etc/graphite-clickhouse/graphite-clickhouse.conf" 

run() {

 /go/bin/graphite-clickhouse \
  -config  "${config_file}" 
}

run
