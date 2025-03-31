#!/bin/bash
ip link set tun1 down
ip link set tun2 down
ip tunnel add tun3 mode gre local <IP> remote <IP> ttl 64
ip addr add <VIP> dev tun3
ip link set tun3 up
cp frr_custom.conf /etc/frr/frr.conf
systemctl restart frr

-------
ip tunnel add tun3 mode gre local <IP> remote <IP> ttl 64
ip addr add <VIP> dev tun3
ip link set tun3 up
cp frr_custom.conf /etc/frr/frr.conf
systemctl restart frr