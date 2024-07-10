#!/bin/bash

function read_file() {
  local path=$1

  content=$(<"${path}")  

  echo "${content}" | awk 1 ORS='\\n'
}

zone=${1}
name=${2}

client_cert_file=${zone}/clients/${name}.pem
client_key_file=${zone}/clients/${name}.key

ca_cert_file=${zone}/ssl/ca.pem
server_ta_file=${zone}/ssl/ta.key

config=$(sed \
  -e "s|\${CERT}|$(read_file ${client_cert_file})|g" \
  -e "s|\${KEY}|$(read_file ${client_key_file})|g" \
  -e "s|\${CA}|$(read_file ${ca_cert_file})|g" \
  -e "s|\${TA}|$(read_file ${server_ta_file})|g" \
  config.ovpn.template)

echo "${config}" > ${zone}/${name}.ovpn
