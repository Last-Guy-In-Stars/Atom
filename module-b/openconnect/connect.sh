#!/bin/bash
# !NFTABLES SET TUN1!
# DONT FORGET SET NAT
# ON SERVER
apt install ocserv
## EDIT OCSERV.CONF
server-cert =
server-key = 
default-domain =
ipv4-network = 10.255.255.0
ipv4-netmask = 255.255.255.0
dns(x2) =
delete default route
config-per-user = # uncomment this 
-----# Create users #-------
ocpasswd -c passwd <user_name>
-----# Create config #------
mkdir config-per-user
vim config-per-user/<user_name> |
| route = ?.?.?.?/24
openssl rsa -in example.key -out example.key1
systemctl start ocserv
ss -natu | grep 443

# ON CLIENT
apt install openconnect