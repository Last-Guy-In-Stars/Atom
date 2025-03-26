#!/bin/bash
cd /root/ca/intermediate
mkdir certs crl csr newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
------
openssl genrsa -aes256 -out private/intermediate.key.pem 4096
openssl req -config openssl.cnf -new -sha256 -key private/intermediate.key.pem -out intermediatereq.pem
scp to root ca
------# Generate certs #------
openssl genrsa -aes256 -out example.key 2048
openssl req -config openssl.cnf -key example.key -new -sha256 -out examplereq.pem -addext "subjectAltName = DNS:*.atomskills.local"
openssl ca -config openssl.cnf -extensions server_cert -days 375 -notext -md sha256 -in examplereq.pem -out example.crt