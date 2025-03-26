# GROUP AUTH ON PASSWD| ON MSK-ADMINPC
vim /etc/login.group.allow |
| it
| astra-admin
| astra-console
vim /etc/pam.d/common-auth |
| auth required pam_listfile.so onerr=fail item=group sense=allow file=/etc/login.group.allow

# suricata -T -c /etc/suricata/suricata.yaml