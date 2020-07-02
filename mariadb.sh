#!/usr/bin/bash

sed -i "s/user='mysql'/user='$USER'/" /usr/bin/mysqld_safe
sed -i "s/user                    = mysql/user                    = $USER/" /etc/mysql/mariadb.conf.d/50-server.cnf
#rm -r /var/lib/mysql/*
#touch /var/lib/mysql/debian-10.3.flag
find /var/lib/mysql -mindepth 1 -not -name *flag -delete
bash /usr/bin/mysql_install_db --auth-root-authentication-method=normal --rpm --cross-bootstrap --user=$USER --disable-log-bin
# bash /usr/bin/mysql_install_db --auth-root-authentication-method=normal --rpm --cross-bootstrap --user=$USER --disable-log-bin  --skip-test-db
service mysql start
