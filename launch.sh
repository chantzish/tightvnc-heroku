#!/bin/sh

export DOLLAR='$'
envsubst < nginx.template > /etc/nginx/sites-enabled/default
echo 1234 | sudo -S nginx -g 'daemon off;'
