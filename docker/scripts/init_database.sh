#!/bin/bash
set -e

service mysql start
mysql <<EOF
CREATE DATABASE skillpointe;
CREATE USER 'skillpointe'@'localhost' IDENTIFIED BY 'skillpointe';
GRANT ALL PRIVILEGES ON * . * TO 'skillpointe'@'localhost';
FLUSH PRIVILEGES;
EOF
