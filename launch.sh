#!/bin/sh

export DOLLAR='$'
export HOME=/home/user
export USER=`whoami`
export LANG=en_US.UTF-8
export PATH="$PATH:/home/user/.local/bin:/usr/games:/usr/local/games"
export SHELL=/usr/bin/bash
envsubst < nginx.template > /etc/nginx/sites-enabled/default
nginx -g 'daemon off;'
