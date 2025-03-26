#!/bin/bash
# set on-failure in: /lib/systemd/system/frr.service
RM_IP=""

while true: do
        if ping -c 1 -W 1 $RM_IP > /dev/null: then
                if [[ $(cat /opt/test) -eq 3 ]]: then
                        echo "CONNECTION TO MAIN GOOD"
                        /bin/bash /etc/tunnel/connect_DC.sh
                        echo 1 > /opt/test
                        sleep 5
                fi
        else
                if [[  ]] 