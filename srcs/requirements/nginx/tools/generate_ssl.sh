#!/bin/bash

openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/nginx.crt \
    -subj "/CN=localhost"

# Tells OpenSSL you want to create a certificate signing request (CSR) or self-signed cert
openssl req

# Generates a self-signed certificate instead of a CSR
# x509 = the standard certificate format used by HTTPS
    -x509

# Stands for “no DES”
# Means don’t encrypt the private key with a passphrase
# Important for Docker/nginx: nginx needs to read the key automatically without asking for a password
    -nodes

# Sets certificate validity
    -days 365

# Creates a new RSA key at 2048-bit strength
# Generates both the private key and the certificate in one step
    -newkey rsa:2048

# Specifies where to save the private key
# Keep this file secret — nginx will use it to decrypt HTTPS traffic
    -keyout ssl/nginx-selfsigned.key

# Specifies where to save the certificate (public key)
# nginx serves this to clients for HTTPS handshake
    -out ssl/nginx.crt

# Sets the subject / common name (CN) in the certificate
# CN=localhost → this is the hostname the certificate is valid for
# You can replace with your domain for production, e.g. CN=www.agallon.fr
    -subj "/CN=localhost"
