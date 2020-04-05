#!/bin/sh

#touch /tmp/X11-unix
export DOLLAR='$'
export HOME=/home/user
export USER=`whoami`
export LANG=en_IL
envsubst < nginx.template > /etc/nginx/sites-enabled/default
touch /opt/noVNC/`whoami`
cd /opt/noVNC && ./utils/launch.sh --listen 6080 --vnc localhost:5901 &
/opt/noVNC/utils/websockify/run 6090 localhost:2200 --heartbeat=45 &
printf "%s" "$AUTH_KEYS" > .ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
/usr/sbin/sshd -p 2200 -o AuthorizedKeysFile=/home/user/.ssh/authorized_keys &
nginx -g 'daemon off;'
