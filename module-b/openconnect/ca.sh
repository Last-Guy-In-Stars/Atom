#!/bin/bash
openssl genrsa -aes256 -out vpn.key 2048
openssl req -config openssl.cnf -key vpn.key -new -sha256 -out vpn.req.pem -addext "subjectAltName = DNS:vpn.atomskills.local"
openssl ca -config openssl.cnf -extensions server_cert -days 375 -notext -md sha256 -in vpn.req.pem -out vpn.crt
cat vpn.req.crt private/ca.cert.pem > vpn.pem