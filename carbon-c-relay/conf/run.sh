#!/bin/sh

CLICKHOUSE_HOST=${CLICKHOUSE_HOST:-graphite}
CLICKHOUSE_PORT=${CLICKHOUSE_PORT:-2003}
RELAY_QUEUE_LIMIT=${RELAY_QUEUE_LIMIT:-5000}
RELAY_PORT=${RELAY_PORT:-2003}
RELAY_WORKS_COUNT=${RELAY_WORKS_COUNT:-2}

config_file="/etc/carbon-c-relay/carbon-c-relay.conf" 

create_config() {

  sed -i \
    -e "s/%CLICKHOUSE_HOST%/${CLICKHOUSE_HOST}/" \
    -e "s/%CLICKHOUSE_PORT%/${CLICKHOUSE_PORT}/" \
    "${config_file}"
}

run() {

  create_config

  # -v  print version and exit
  # -f  read <config> for clusters and routes
  # -p  listen on <port> for connections, defaults to 2003
  # -l  write output to <file>, defaults to stdout/stderr
  # -w  use <workers> worker threads, defaults to 8
  # -b  server send batch size, defaults to 2500
  # -q  server queue size, defaults to 25000
  # -L  server max stalls, defaults to 4
  # -C  use CA <cert> to verify SSL connections
  # -B  connection listen backlog, defaults to 32
  # -U  socket receive buffer size, max/min/default values depend on OS
  # -T  IO timeout in milliseconds for server connections, defaults to 600
  # -E  disable disconnecting idle connections after 10 minutes
  # -c  characters to allow next to [A-Za-z0-9], defaults to -_:#
  # -d  debug mode: currently writes statistics to log, prints hash
  #     ring contents and matching position in test mode (-t)
  # -s  submission mode: don't add any metrics to the stream like
  #     statistics, report drop counts and queue pressure to log
  # -t  config test mode: prints rule matches from input on stdin
  # -H  hostname: override hostname (used in statistics)
  # -D  daemonise: run in a background
  # -P  pidfile: write a pid to a specified pidfile
  # -O  minimum number of rules before optimising the ruleset, default: 50
  /usr/bin/relay \
    -f "${config_file}" \
    -q "${RELAY_QUEUE_LIMIT}" \
    -p "${RELAY_PORT}" \
    -w "${RELAY_WORKS_COUNT}" \
    -t  < /dev/null > /dev/null

  /usr/bin/relay \
    -q "${RELAY_QUEUE_LIMIT}" \
    -p "${RELAY_PORT}" \
    -w "${RELAY_WORKS_COUNT}" \
    -f "${config_file}"
}

run


