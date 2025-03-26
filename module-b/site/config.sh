#!/bin/bash
server {
    listen 443 ssl;
    server_name example.atomskills.local;
    ssl_certificate /etc/ssl/certs/<cert>
    ssl_certificate_key /etc/ssl/certs/<key>

    location / {
        root /var/www/html;
        index index.html;
    }

    location /admin {
        auth_basic "Admin Area";
        auth_basic_user_file /etc/nginx/adminpasswd;
        alias /var/www/html/admin;
        index index.html;
    }

    location /worker {
        auth_basic "Admin Area";
        auth_basic_user_file /etc/nginx/workerpasswd;
        alias /var/www/html/worker;
        index index.html;
    }

}
apt install apache2-utils
htpasswd -c /etc/nginx/.htpasswd1 ssl_admin
htpasswd -c /etc/nginx/.htpasswwd2 ssl_worker
mkdir /var/www/admin;mkdir /var/www/worker
<html>
    <body>
        <a href="/worker" class="button">Click here for worker</a>
        <a href="/admin" class="button">Click here for admin</a>
    </body>
</html>