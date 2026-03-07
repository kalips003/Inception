
FROM debian:bullseye

RUN apt update && apt install -y \
        php-fpm \
        php-mysql \
        php-xml \
        php-mbstring \
        php-curl \
        curl \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/www/html \
    && chmod -R 755 /var/www/html

WORKDIR /var/www/html

RUN rm -rf * \
    && curl -o latest.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm -f latest.tar.gz \
    && chown -R www-data:www-data /var/www/html

EXPOSE 9000
EXPOSE 3306

CMD ["bash"]