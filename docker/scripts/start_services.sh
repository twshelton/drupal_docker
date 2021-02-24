#!/bin/bash
set -e

cd /var/www/skillpointe.com/html/
composer update
service php7.2-fpm start
service nginx start
