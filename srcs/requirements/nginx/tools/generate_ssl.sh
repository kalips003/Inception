#!/bin/bash

openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/nginx.crt \
    -subj "/C=MO/L=KH/O=1337/OU=student/CN=sahafid.42.ma"

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

    -subj "/CN=localhost"
# Sets the subject / common name (CN) in the certificate
# CN= → this is the hostname the certificate is valid for
# C= → country
# L= → Locality (City)
# O= → Organization (Company name, school...)
# OU= → Organizational Unit (IT department, Security department...)
# You can replace with your domain for production, e.g. CN=www.agallon.fr
