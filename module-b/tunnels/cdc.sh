#!/bin/bash OLDMSK 
ip link set tun3 down
ip link delete tun3
# /etc/tunnel/script_sh1.sh
# /etc/tunnel/script_sh2.sh
ip link set tun2 up
ip link set tun1 up
# cp /etc/frr/frr.conf.original /etc/frr/frr.conf
systemctl restart frr
ssh root@88.8.8.27 "/etc/tunnel/reback_connect_MSK.sh"