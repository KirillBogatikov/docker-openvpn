#!/bin/sh

./init.sh

crond -f -l 8 -d 8 -L /dev/stdout & sh

# log rotation
if [ -f /var/log/openvpn/openvpn.log ]; then
  id=$( (tr -dc 'a-zA-Z0-9' < /dev/urandom) | head -c 6 )
  mv /var/log/openvpn/openvpn.log "/var/log/openvpn/openvpn-${id}.log"
fi

openvpn --config /etc/openvpn/server/server.conf
