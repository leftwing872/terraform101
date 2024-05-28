#!/bin/bash
yum update -y
yum install -y nginx
systemctl enable nginx
systemctl start nginx
echo "<h1>Hello world</h1><h2>This is First Instance</h2>" > /usr/share/nginx/html/index.html
EOF