
FROM debian:bullseye

RUN apt update \
	&& apt install -y mariadb-server \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/*

# MariaDB stores all databases in /var/lib/mysql by default.

COPY entry.sh /tmp/entry.sh
RUN chmod +x /tmp/entry.sh

EXPOSE 3306

CMD ["/tmp/entry.sh"]