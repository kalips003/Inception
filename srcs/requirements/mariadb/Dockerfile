
FROM debian:bullseye

RUN apt update \
	&& apt install -y mariadb-server \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /run/mysqld \
	&& chown mysql:mysql /run/mysqld

# MariaDB stores all databases in /var/lib/mysql by default.

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY entry.sh /tmp/entry.sh
RUN chmod +x /tmp/entry.sh

EXPOSE 12345

CMD ["/tmp/entry.sh"]