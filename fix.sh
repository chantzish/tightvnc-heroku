#!/bin/bash

env

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER:-user}:x:$(id -u):$(id -g)::${HOME:-/home/user}:/bin/sh" >> /etc/passwd
  fi
fi

if ! groups &> /dev/null; then
  if [ -w /etc/group ]; then
    echo "${GROUP:-user}:x:$(id -u):" >> /etc/group
  fi
fi

echo fixed.
