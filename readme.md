# OpenVPN inside docker container
- Simple
- Lightweight
- Open source
- Only one Dockerfile and 3 bash scripts

## Features
Two deployment roles:
- OpenVPN server;
- OpenVPN client.

Two base images:
- alpine;
- debian.

### Supports HashiCorp Vault PKI on server role
- Auto renew CRL via http requests every 5 min

## Build
### Server
```shell
docker build -t docker-openvpn -f Dockerfile.alpine-server
```
or 
```shell
docker build -t docker-openvpn -f Dockerfile.debian-server
```

### Client
```shell
docker build -t docker-openvpn -f Dockerfile.alpine-client
```

## Deploy
```shell
docker run -d --name openvpn-server \
  -p 1194:1194 --cap-add NET_ADMIN \
  -v ./server.conf:/etc/openvpn/server/server.conf \
  docker-openvpn
```
or 
```shell
services:
  server:
    image: docker-openvpn
    volumes:
      - ./server.conf:/etc/openvpn/server/server.conf
    ports:
      - 1194:1194
    cap_add:
      - NET_ADMIN
```

## Scripts
In the `scripts` folder you can find useful scripts for OpenVPN.
### gen-config.sh
Generates client config by provided 'zone' and 'username' variables.
Requires this file structure:
```shell
- config.ovpn.template
- get-config.sh
- {zone}
  - ca.pem
  - ta.key
  - clients
    - {username}.pem
    - {username}.key
```

`config.ovpn.template` should be modified before generating configs. Change `${IP}`, `${PORT}` or any other information.