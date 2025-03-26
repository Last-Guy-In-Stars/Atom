#!/bin/bash
# ON YEKT-BILLING/DB
vim /etc/rsyslog.conf |
| *.* @192.168.2.200
systemctl restart rsyslog
logger -p err PRIVET
# ON SERVER YEKT-WORKER
vim /etc/rsyslog.conf |
| # Uncomment UDP block on MODULES
| module(load="immark")
| -
| module(load="imudp")
| input(type="imudp" port="514")
| # GLOBAL DIRECTIVES
| if $hostname contains 'YEKT-DB' or $fromhost-ip contains "192.168.2.150" then {
|    *.* /opt/logs/YEKT-DB/logs.log
| }
| if $hostname contains 'YEKT-BILLING' or $fromhost-ip contains "192.168.2.100" then {
|    *.* /opt/logs/YEKT-BILLING/logs.log
| } 