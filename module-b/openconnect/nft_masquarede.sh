table ip nat {
    chain postrouting {
    type nat hook postrouting priority 0; 
    ip saddr 0.0.0.0/0 oifname "tun1" counter masquerade;
    }
}