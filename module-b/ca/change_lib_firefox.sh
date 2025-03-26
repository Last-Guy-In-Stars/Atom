#!/bin/bash
mv /usr/lib/firefox/libnssckbi.so /usr/lib/firefox/libnssckbi.so.bak
ln -s /usr/lib/x86_64-linux-gnu/pkcs11/p11-kit-trust.so /usr/lib/firefox/libnssckbi.so