#!/bin/bash
ip link set tun3 down
ip link delete tun3
ip link set tun1 up
ip link set tun2 up
# /etc/tunnel/script_sh1.sh
# /etc/tunnel/script_sh2.sh
# cp /etc/frr/frr.conf.original /etc/frr/frr.conf
systemctl restart frr