#!/bin/bash
cp ca.cert.pem /usr/share/ca-certificates/cool-ca.crt
dpkg-reconfigure ca-certificates