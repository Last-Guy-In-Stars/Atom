Install Modsecurity on a NGINX Reverse Proxy
Install Modsecurity NGINX connector
Install OWASP CRS

*******************************************************************
Install modsecurity


apt-get install -y apt-utils autoconf automake build-essential git libcurl4-openssl-dev libgeoip-dev liblmdb-dev libpcre3-dev libtool libxml2-dev libyajl-dev pkgconf wget zlib1g-dev


git clone --depth 1 -b v3/master --single-branch https://github.com/owasp-modsecurity/ModSecurity

cd ModSecurity

git submodule init

git submodule update

./build.sh

./configure

make

make install

cd ..


************************************************************************
Download and install the modsecurity-nginx connector


git clone --depth 1 https://github.com/owasp-modsecurity/ModSecurity-nginx

nginx -v
apt install nginx

wget wget https://nginx.org/download/nginx-1.22.1.tar.gz

tar zxvf nginx-1.22.0.tar.gz

cd nginx-1.22.0

./configure --with-compat --add-dynamic-module=../ModSecurity-nginx

make modules

cp objs/ngx_http_modsecurity_module.so /etc/nginx/modules

cd ..

nano etc/nginx/nginx.conf
load_module modules/ngx_http_modsecurity_module.so;

mkdir /etc/nginx/modsec

wget -P /etc/nginx/modsec/ https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/modsecurity.conf-recommended # https://www.youtube.com/watch?v=xAIpFwdA02s

mv /etc/nginx/modsec/modsecurity.conf-recommended /etc/nginx/modsec/modsecurity.conf

cp ModSecurity/unicode.mapping /etc/nginx/modsec

sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine On/' /etc/nginx/modsec/modsecurity.conf

nano etc/nginx/conf.d/[your domain or sub domain].conf |

server {
#	add_header X-Frame-Options "SAMEORIGIN" always;
#	add_headed Pragma "no-cache";
	
	listen 5000;
	server_name _ default_server;
	modsecurity on;
	modsecurity_rules_file /etc/nginx/modsec/main.conf;

# If you have proxy
#	error_page 403 =200 @custom_403
	location / {    	
    		proxy_pass http://172.24.0.3:5000;
    	}
	error_page 400 =400 /400; # bad request
	error_page 401 =401 /401; # unauthorized
	error_page 403 =200 /403; # forbidden
	error_page 404 =404 /404; # not found
	error_page 408 =408 /408; # timeout
	error_page 500 502 503 504 =500 /500; # error
}
#stream {
#server {
#  listen 3306;
  #server_name _ default_server;
#  proxy_pass 172.19.0.2:3306; 
#  location / {	proxy_pass 172.19.0.2:3306;
#  }
#}
#}
|

**************************************************************
Install Owasp CRS

wget https://github.com/coreruleset/coreruleset/archive/refs/tags/v4.2.0.tar.gz

tar -xzvf v4.2.0.tar.gz

mv coreruleset-4.2.0 /usr/local

cd /usr/local/coreruleset-4.2.0

cp crs-setup.conf.example crs-setup.conf

cd /

nano /etc/nginx/modsec/main.conf

************************************************************************
Add the following to the main.conf:
Include the recommended configuration
Include /etc/nginx/modsec/modsecurity.conf

#OWASP CRS
Include /usr/local/coreruleset-4.2.0/crs-setup.conf
#Include /usr/local/coreruleset-4.2.0/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-901-INITIALIZATION.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-905-COMMON-EXCEPTIONS.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-911-METHOD-ENFORCEMENT.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-913-SCANNER-DETECTION.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-921-PROTOCOL-ATTACK.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-922-MULTIPART-ATTACK.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-930-APPLICATION-ATTACK-LFI.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-931-APPLICATION-ATTACK-RFI.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-932-APPLICATION-ATTACK-RCE.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-933-APPLICATION-ATTACK-PHP.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-934-APPLICATION-ATTACK-GENERIC.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-944-APPLICATION-ATTACK-JAVA.conf
Include /usr/local/coreruleset-4.2.0/rules/REQUEST-949-BLOCKING-EVALUATION.conf
Include /usr/local/coreruleset-4.2.0/rules/RESPONSE-950-DATA-LEAKAGES.conf
Include /usr/local/coreruleset-4.2.0/rules/RESPONSE-951-DATA-LEAKAGES-SQL.conf
Include /usr/local/coreruleset-4.2.0/rules/RESPONSE-952-DATA-LEAKAGES-JAVA.conf
Include /usr/local/coreruleset-4.2.0/rules/RESPONSE-953-DATA-LEAKAGES-PHP.conf
Include /usr/local/coreruleset-4.2.0/rules/RESPONSE-954-DATA-LEAKAGES-IIS.conf
Include /usr/local/coreruleset-4.2.0/rules/RESPONSE-955-WEB-SHELLS.conf
Include /usr/local/coreruleset-4.2.0/rules/RESPONSE-959-BLOCKING-EVALUATION.conf
Include /usr/local/coreruleset-4.2.0/rules/RESPONSE-980-CORRELATION.conf
#Include /usr/local/coreruleset-4.2.0/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf


systemctl restart nginx

Check logs:
watch tail -n 100 /var/log/modsec_audit.log
----------
cd /usr/local/coreruleset-4.2.0/rules
nano REQUEST-905-COMMON-EXCEPTIONS.conf |
| #finde id:920350 and add
|   deny,\
|   status:403,\