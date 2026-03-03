# Nginx binary (installed via apt)
# A valid configuration file
# A listening port
# Foreground execution (daemon off)
# (Inception) SSL certificate

FROM debian:bullseye

RUN apt update && \
    apt install -y nginx && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]