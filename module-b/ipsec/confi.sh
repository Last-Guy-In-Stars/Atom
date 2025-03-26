#!/bin/bash
apt install strongswan -y
vim /etc/ipsec.conf |
conn vpn1 
   left=88.*.*.*
   right=200.*.*.*
   rightprotoport=gre
   leftprotoport=gre
   type=tunnel
   ike=3des-sha1-modp2048
   esp=aes128-sha2_256
   authby=secret
   auto=start
conn vpn2
   left=88.*.*.*
   right=100.*.*.*
   rightprotoport=gre
   leftprotoport=gre
   type=tunnel
   ike=3des-sha1-modp2048
   esp=aes128-sha2_256
   authby=secret
   auto=start
vim /etc/ipsec.secrets |
88.*.*.* 200.*.*.* : PSK "P@ssw0rd"
88.*.*.* 100.*.*.*  : PSK "P@ssw0rd"
# RSTART AND CHECK STATUS
ipsec restart
ipsec status

#### ATTENTION: SET 3 CONFIGURATION VPN ON MSK TO YEKT AND YEKT TO MSK