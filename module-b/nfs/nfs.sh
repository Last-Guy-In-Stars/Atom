#!/bin/bash
nano /etc/security/pam_mount.conf.xml
<volume
    fstype="nfs"
    server="IP"
    path="/storage/shared/it"
    mountpoint="~/Desktops/Desktop1/it"
    sgrp="it"
    options="rw"/>
<volume
    fstype="nfs"
    server="IP"
    path="/storage/shared/office"
    mountpoint="~/Desktops/Desktop1/office"
    sgrp="office"
    options="rw"/>
    