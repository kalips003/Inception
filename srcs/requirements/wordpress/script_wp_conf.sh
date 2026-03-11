#!/bin/bash
echo -e $C_430 "WE ARE IN" $RESET

set -e  # stop script if any command fails

if [ ! -f wp-config.php ]; then

	export DB_NAME=$(echo $MYSQL_DATABASE)
	export DB_USER=$(echo $MYSQL_USER)
	DB_PWD=$(cat /run/secrets/db_password)

	echo -e $C_430 "--- script_wp_conf.sh ---" $RESET
	echo -e $C_104 "DB_NAME=$DB_NAME" $RESET
	echo -e $C_104 "DB_USER=$DB_USER" $RESET
	echo -e $C_104 "DB_PWD=$DB_PWD" $RESET
	echo -e $C_430 "-------------------------" $RESET

	cp wp-config-sample.php wp-config.php

	# sed [options] 's/pattern/replacement/flags' file
	# Replace DB placeholders with environment variables
	sed -i "s/database_name_here/$DB_NAME/" wp-config.php
	sed -i "s/username_here/$DB_USER/" wp-config.php
	sed -i "s/password_here/$DB_PWD/" wp-config.php
	sed -i "s/localhost/$DB_HOST/" wp-config.php

	# set WP keys/salts dynamically
	# Remove the placeholder lines
	sed -i "/define( 'AUTH_KEY'/,/define( 'NONCE_SALT'/d" wp-config.php
	# Fetch salts from WordPress API and insert BEFORE require_once wp-settings.php
	# (salts must be defined before wp-settings.php loads so wp_salt() uses them
	#  instead of falling back to DB values, preventing HMAC mismatches on auth)
	curl -s https://api.wordpress.org/secret-key/1.1/salt/ > /tmp/wp_salts.php
	php -r "
\$config = file_get_contents('wp-config.php');
\$salts  = file_get_contents('/tmp/wp_salts.php');
\$insert = \$salts
        . \"\\\$_SERVER['HTTPS'] = 'on';\n\"
        . \"define('FORCE_SSL_ADMIN', true);\n\";
\$config = str_replace(
    \"require_once ABSPATH . 'wp-settings.php';\",
    \$insert . \"require_once ABSPATH . 'wp-settings.php';\",
    \$config
);
file_put_contents('wp-config.php', \$config);
"
	echo "define( 'WP_ALLOW_REPAIR', true );" >> wp-config.php
	chown www-data:www-data wp-config.php
	chmod 640 wp-config.php
fi
