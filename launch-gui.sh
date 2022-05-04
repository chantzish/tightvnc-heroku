#!/bin/sh

export HOME=/home/user
export USER=`whoami`
export LANG=en_US.UTF-8
export PATH="$PATH:/home/user/.local/bin:/usr/games:/usr/local/games"
export SHELL=/usr/bin/bash

printf "%s\n" "$LAUNCH_RUNTIME" > launch-runtime.sh
chmod +x launch-runtime.sh
./launch-runtime.sh
