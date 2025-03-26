#!/bin/bash
cat example.crt certs/intermediate.cert.pem /root/ca.cert.pem > \
    /etc/ssl/certs/newcert.pem
openssl rsa -in example.key -out example.key1
cp example.key1 /etc/ssl/certs/newkey.pem