#!/usr/bin/bash

sed -i "s/user='mysql'/user='$USER'/" /usr/bin/mysqld_safe
sed -i "s/user                    = mysql/user                    = $USER/" /etc/mysql/mariadb.conf.d/50-server.cnf
service mysql start
