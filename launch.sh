#!/bin/sh

envsubst < nginx.template > /etc/nginx/sites-enabled/default
nginx -g 'daemon off;'
