#!/bin/bash
apt install isc-dhcp-server -y
vim /etc/default/isc-dhcp-server |
| INTERFACESv4="SET"
vim /etc/dhcp/dhcpd.conf |
| option domain-name "";
| option domain-name-servers DNS1, DNS2;
| @FIND SUBNET AND SET IT IS@;
systemctl restart isc-dhcp-server
dhcp-lease-list