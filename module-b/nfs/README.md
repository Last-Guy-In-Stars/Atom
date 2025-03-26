# ON STORAGE
apt install nfs-server -y
nano /etc/exports |
| /storage/it *(rw,sync,no_sub_tree_check)
| /storage/office *(rw,sync,no_sub_tree_check)
## CREATE FOLDERS
chmod 1775 -R /storage/it
chmod 1775 -R /storage/office
# ON CLIENT
apt install nfs-common libpam-mount -y
adduser <UserName>
groupadd <GroupName>
usermod -a -G <GroupName> <UserName>
cat << EOF > /etc/security/pam_mount.conf.xml 
<volume
    ftype="nfs"
    server="Address"
    path="/storage/it"
    mountpoint="~/Desktops/Desktop1/it"
    sgrp="it"
    options="rw"
/>
<volume
    ftype="nfs"
    server="Address"
    path="/storage/office"
    mountpoint="~/Desktops/Desktop1/office"
    sgrp="office"
    options="rw"
/>
EOF
# ON STORAGE
chown root:ID -R /storage/it
chown root:ID -R /storage/office
