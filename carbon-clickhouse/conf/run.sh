#!/bin/sh

#GOMAXPROCS=${GOMAXPROCS:-2}
#UPLOADS_GRAPHITE_THREADS=${UPLOADS_GRAPHITE_THREADS:-2}

config_file="/etc/carbon-clickhouse/config.conf" 

#create_config() {
#  sed -i \
#    -e "s/%GOMAXPROCS%/${GOMAXPROCS}/" \
#    -e "s/%UPLOADS_GRAPHITE_THREADS%/${UPLOADS_GRAPHITE_THREADS}/" \
#    "${config_file}"
#}

run() {

#  create_config

 /usr/bin/carbon-clickhouse \
  -config  "${config_file}" 
}

run
