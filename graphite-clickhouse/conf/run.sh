#!/bin/sh

config_file="/etc/graphite-clickhouse/graphite-clickhouse.conf" 

run() {

 /usr/bin/graphite-clickhouse \
  -config  "${config_file}" 
}

run
