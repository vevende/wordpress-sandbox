#!/bin/sh

su - wordpress -c "/bin/wp-cli.phar --path=/var/www/html $*"
