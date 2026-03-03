
FROM debian:bullseye

RUN apt update && apt install -y \
        php-fpm \
        php-mysql \
        php-xml \
        php-mbstring \
        php-curl \
        php-zip \
        unzip \
        curl \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]