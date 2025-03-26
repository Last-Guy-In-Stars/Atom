#!/bin/bash
mkdir /root/ca
cd /root/ca
mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
----# SUBJECTALTNAME ON OPENSSL.CONF #-----
[ server_cert ]
subjectAltName = @alt_names
[ alt_names ]
DNS.1 = *.atomskills.local
----# ON ROOT FOLDER #-----
openssl genrsa -aes256 -out private/ca.key.pem 4096
openssl req -config openssl.cnf -key private/ca.key.pem -new -x509 \
    -days 7300 -sha256 -extensions v3_ca -out certs/ca.cert.pem
## Verify cert agetr created intermediate
openssl x509 -noout -text -in certs/ca.cert.pem
----# SING REQ FROM SUB CA #----
openssl ca -config openssl.cnf -extensions v3_intermediate_ca -days 3700 -notext -md sha256 -in intermediatereq.pem -out intermediatecert.pem
scp to sub ca