#!/bin/sh

export DOLLAR='$'
echo 1234 | sudo -S /bin/sh -c 'envsubst < nginx.template > /etc/nginx/sites-enabled/default'
echo 1234 | sudo -S nginx -g 'daemon off;'
