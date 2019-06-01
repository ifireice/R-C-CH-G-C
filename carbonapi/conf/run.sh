#!/bin/sh

config_file="/etc/carbonapi/carbonapi.yaml" 

run() {

 /go/bin/carbonapi \
  -config  "${config_file}" 
}

run
