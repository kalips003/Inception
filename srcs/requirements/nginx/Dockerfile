
FROM debian:bullseye

RUN apt update && \
    apt install -y --no-install-recommends nginx && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# copy conf file
COPY nginx.conf /etc/nginx/nginx.conf
# ssl public / private key
COPY ssl/nginx-selfsigned.key /etc/nginx/ssl/nginx-selfsigned.key
COPY ssl/nginx.crt /etc/nginx/ssl/nginx.crt
# make private key not readable
RUN chmod 600 /etc/nginx/ssl/nginx-selfsigned.key

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]