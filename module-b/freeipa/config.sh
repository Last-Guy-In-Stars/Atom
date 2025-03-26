#!/bin/bash
set FQDN in hostname
apt install astra-freeipa-server -y
vim /etc/apache2/apache2.conf |
| Astra mode off
| Astra audit off
apt install libastraevents -y
systemctl restart apache2
astra-freeipa-server -d domain.name
## CREATE CSV FILE
vim user.csv
LastName,FirstName,Groups
name1,name2,groupname
-----
kinit admin
./execute_scripts.sh
## ON CLIENT PC !SYNC TIME!
apt install astra-freeipa-client -y
astra-freeipa-client -d company.cool -y