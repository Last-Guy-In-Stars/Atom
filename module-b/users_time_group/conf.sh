#!/bin/bash
apt update
apt install libpam-modules
vim etc/X11/fly-dm/fly-dmrc | ShowBoxMEssage = true
vim /etc/pam.d/common-auth |
| account required pam_time.so
| account [success=1 default=ignore] pam_succeed_if.so user ingroup administrator
| account required pam_echo.so "Access Denied"
vim /etc/security/time.conf |
| *;*;!administrator|!root;Al0900-1800