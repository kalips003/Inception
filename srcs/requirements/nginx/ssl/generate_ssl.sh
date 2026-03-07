#!/bin/bash

openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout $NGINX_SSL_PRIVATE \
    -out $NGINX_SSL_PUBLIC \
    -subj "/C=FR/L=Paris/O=42/OU=student/CN=$DOMAIN_NAME"

# make private key not readable
chmod 600 $NGINX_SSL_PRIVATE

# Tells OpenSSL you want to create a certificate signing request (CSR) or self-signed cert
# openssl req

    # -x509
# Generates a self-signed certificate instead of a CSR
# x509 = the standard certificate format used by HTTPS

    # -nodes
# Stands for “no DES”
# Means don’t encrypt the private key with a passphrase
# Important for Docker/nginx: nginx needs to read the key automatically without asking for a password

    # -days 365
# Sets certificate validity

    # -newkey rsa:2048
# Creates a new RSA key at 2048-bit strength
# Generates both the private key and the certificate in one step

    # -keyout ssl/nginx-selfsigned.key
# Specifies where to save the private key
# Keep this file secret — nginx will use it to decrypt HTTPS traffic

    # -out ssl/nginx.crt
# Specifies where to save the certificate (public key)
# nginx serves this to clients for HTTPS handshake

    # -subj "/C=FR/L=Paris/O=42/OU=student/CN=agallon.42.fr"
# Sets the subject / common name (CN) in the certificate
# CN= → this is the hostname the certificate is valid for
# C= → country
# L= → Locality (City)
# O= → Organization (Company name, school...)
# OU= → Organizational Unit (IT department, Security department...)
# You can replace with your domain for production, e.g. CN=www.agallon.fr

echo "
user www-data;
worker_processes auto; 
pid /run/nginx.pid;

events {
	worker_connections 768; 
	
}

http {

	sendfile on; 
	tcp_nopush on; 
	types_hash_max_size 2048; 
	
	include /etc/nginx/mime.types; 
	default_type application/octet-stream; 

	ssl_protocols TLSv1.2 TLSv1.3; 
	
	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	server {
		listen 443 ssl;
		listen [::]:443 ssl; 

		ssl_certificate $NGINX_SSL_PUBLIC;
		ssl_certificate_key $NGINX_SSL_PRIVATE;
		
		server_name $DOMAIN_NAME www.$DOMAIN_NAME;" > /etc/nginx/conf.d/default.conf

echo '
		root /var/www/html;
		index index.php;

		location / {
			try_files $uri $uri/ /index.php?$args; 
		}

		location ~ [^/]\.php(/|$) {
			try_files $uri =404;
			include fastcgi_params; 
			fastcgi_pass wordpress:9000; 
			fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		}

	}

	server {
		listen 80;
		listen [::]:80;
		return 301 https://$host$request_uri;
	}
}
' >> /etc/nginx/conf.d/default.conf
