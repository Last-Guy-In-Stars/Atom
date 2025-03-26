#!/bin/bash
mkdir /etc/tunnel
vim tunnel_CLOUD.sh |
| ip tunnel add tun1 mode gre local 179.13.219.70 remote 200.100.100.20 ttl 64
| ip addr add 10.100.100.1/30 dev tun1
| ip link set tun1 up 
## On dc-rtr1
vim tunnel_CLOUD.sh |
| ip tunnel add tun4 mode gre local 200.100.100.20 remote 179.13.219.70 ttl 64
| ip addr add 10.100.100.2/30 dev tun4
| ip link set tun4 up 