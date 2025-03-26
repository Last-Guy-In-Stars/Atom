apt-get install lvm2
apt-get install cryptsetup
# Encrypted
cryptsetup luksFormat /dev/sdb
cryptsetup luksFormat /dev/sdc
crypsetup open /dev/sdb cryptlvm
crypsetup open /dev/sdc cryptlvm2
pvcreate /dev/mapper/cryptlvm
pvcreate /dev/mapper/cryptlvm2
vgcreate "Vol2" /dev/mapper/cryptlvm /dev/mapper/cryptlvm2
lvcreate -l 100%FREE -n crypto_lvm Vol2
mkfs.ext4 /dev/mapper/Vol2-crypto_lvm
# Gen key secret
dd if=/dev/urandom of=secretkey bs=512 count=4
cp secretkey /etc/
cryptsetup luksAddKey /dev/sdb /etc/secretkey
cryptsetup luksAddKey /dev/sdc /etc/secretkey
nano /etc/crypttab |
| cryptlvm /dev/vdb /etc/secretkey luks,discard 
| cryptlvm2 /dev/vdc /etc/secretkey luks,discard 
nano /etc/fstab |
| /dev/mapper/Vol2-crypto_lvm /storage ext4 defaults 0 0
