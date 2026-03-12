
FROM debian:bullseye

RUN apt update \
    && apt install -y --no-install-recommends nginx openssl \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# self-generated ssl public / private key + create default.conf
COPY ssl/generate_ssl.sh /tmp/generate_ssl.sh
COPY ssl/.env /tmp/.env
RUN chmod +x /tmp/generate_ssl.sh \
    && export $(/tmp/.env | xargs) \
    && /tmp/generate_ssl.sh \
    && rm -f /tmp/generate_ssl.sh

EXPOSE 443

# CMD ["nginx", "-g", "daemon off;"]
CMD ["sh", "-c", "cat /var/output && nginx -g 'daemon off;'"]