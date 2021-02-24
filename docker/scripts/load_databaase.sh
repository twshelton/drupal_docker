#!/bin/bash
set -e

mysql -D skillpointe <<EOF
SOURCE $1
EOF
