#!/bin/sh

#export DOLLAR='$'
#echo 1234 | sudo -E -S /bin/sh -c 'envsubst < nginx.template > /etc/nginx/sites-enabled/default'
#echo 1234 | sudo -S nginx -g 'daemon off;'

printf "%s\n" "$LAUNCH_START" > launch-start.sh
chmod +x launch-start.sh
./launch-start.sh
