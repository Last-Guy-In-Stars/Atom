# Enable on daemon OSPFD
# Don`t forget about IP FORWARDING ON OSPF CONFIG!
# Then:
vtysh
~conf t
~router ospf ?1
~network <Local Network/24> area 0
~network <VIP-1/30> area 0
~network <VIP-2/30> area 0
~do wr
~exit
~show run
~area 0 aunthentication 
~exit
~interface enp1s0 
    ip ospf passive
~interface tun*
   ip ospf authenticaion-key PASS 
# Check neib
~do sh ip ospf nei
# Check route 
~do sh ip route