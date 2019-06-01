#!/bin/sh

config_file="/etc/carbonapi/carbonapi.yaml" 

run() {

 /usr/bin/carbonapi \
  -config  "${config_file}" 
}

run
