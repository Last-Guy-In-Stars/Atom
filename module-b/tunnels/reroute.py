import subprocess
import time

DC_IP = "200.100.100.20"
COUNT = "1"
WAIT_SEC = "1"
CHEK_STATUS = 2

# Enable Forwarding
subprocess.call(["sysctl", "-p"], shell=False, stdout=subprocess.DEVNULL) 

def checkDc() -> int:
    global CHEK_STATUS
    cmd = f"ping -c {COUNT} -W {WAIT_SEC} {DC_IP}".split(' ')
    frr_gre_dc = "/etc/tunnel/connect_DC.sh"
    time.sleep(5)
    if subprocess.call(cmd) == 0:
        if CHEK_STATUS == 0:
            subprocess.call(["/bin/bash", frr_gre_dc], stdout=subprocess.DEVNULL)
            print("CONNECTION TO DC SUCCESS!")
            CHEK_STATUS = 1
        else:
            print("CONNECTION STABLE ON DC.")
        return 0
    else:
        return 1    

def connectYekt() -> int:
    global CHEK_STATUS
    if CHEK_STATUS == 0:
        print("ON CONNECTION YEKT!")
    else:
       print("CONNECT TO YEKT.")
       frr_gre_yekt = "/etc/tunnel/connect_YEKT.sh"
       subprocess.call(["/bin/bash", frr_gre_yekt], stdout=subprocess.DEVNULL)
       CHEK_STATUS = 0  

def main():
    while True:
        if checkDc() == 1:
            connectYekt()
        
main()