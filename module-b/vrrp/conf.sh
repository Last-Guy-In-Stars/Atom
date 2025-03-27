#!/bin/bash
cp /etc/keepalived/*.conf.example /etc/keepalived/keepalived.conf
# ON MASTER 
vim /etc/keepalived/keepalived.conf |
global_defs {
    enable_script_security
    script_user root
}
vrrp_script health_check {
    script "/opt/check.sh"
    interval 4
    timeout 3
    rise 3
    fall 3
}

vrrp_instance router_dc {
    state MASTER
    interface enp6s0
    virtual_router_id 80
    advert_int 1
    priority 100
    virtual_ipaddress {
        10.15.10.1/24
    }
    track_interface {
        enp6s0
    }
    track_script {
        health_check
    }
}
#Middle
check.sh < ping -W 2 -c 1 77.88.8.8 > /dev/null 2>&1
# ON SLAVE
vim /etc/keepalived/keepalived.conf |
global_defs {
    enable_script_security
    script_user root
}
vrrp_script health_check {
    script "/opt/check.sh"
    interval 4
    timeout 3
    rise 3
    fall 3
}

vrrp_instance router_dc {
    state BACKUP
    interface enp6s0
    virtual_router_id 80
    advert_int 1
    priority 100
    virtual_ipaddress {
        10.15.10.1/24
    }
    track_interface {
        enp6s0
    }
    track_script {
        health_check
    }
}

# Test
ip link set <nameif> down