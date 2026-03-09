#!/bin/bash
set -e  # stop script if any command fails

# create the wp-config.php
/tmp/script_wp_conf.sh
echo -e $C_430 "----- wp-config.php -----" $RESET
echo -e $C_104
cat ./wp-config.php
echo -e $C_430 "-------------------------" $RESET

# initialize the wordpress
/tmp/script_wp_setup.sh

echo -e $C_430 "-4-----------------------" $RESET
grep "^user" /etc/php/7.4/fpm/pool.d/www.conf
echo -e $C_430 "-5-----------------------" $RESET

exec /usr/sbin/php-fpm7.4 -F