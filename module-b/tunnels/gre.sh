#!bin/bash
ip tunnel add tun1 mode gre local <IP> remote <IP> ttl 64
ip addr add <VIP> dev tun1
ip link set tun1 up
# add to crontab: @reboot root <path/to/script>