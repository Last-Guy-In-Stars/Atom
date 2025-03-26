# Enable on daemon OSPFD
# Don`t forget about IP FORWARDING ON OSPF CONFIG!
# Then:
vtysh
~conf t
~router ospf ?1
~network <Local Network/30> area 0
~do wr
~exit
~show run
# Check neib
~do sh ip ospf nei
# Check route 
~do sh ip route
~sh ip ospf nei
### Check broadcast