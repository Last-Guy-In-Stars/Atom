table ip nat {
    chain postrouting {
    type nat hook postrouting priority 0; 
    ip saddr 0.0.0.0/0 oifname "enp1s0" counter masquerade;
    }
}