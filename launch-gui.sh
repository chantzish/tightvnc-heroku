#!/bin/sh

env

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-user}:x:$(id -u):$(id -g)::${HOME:-/home/user}:/bin/sh" >> /etc/passwd
  fi
fi

if ! groups &> /dev/null; then
  if [ -w /etc/group ]; then
    echo "${GROUP_NAME:-user}:x:$(id -u):" >> /etc/group
  fi
fi

export HOME=/home/user
export USER=`whoami`
export LANG=en_IL
#export JAVA_HOME=/usr/lib/jvm/default-java

# fix according to site
echo '#!/bin/sh\n\nwhile :; do wget '$APP_NAME'.herokuapp.com -q -O /dev/null -o /dev/null; sleep 4m; done &' | tee /usr/local/sbin/stop.sh
chmod +x /usr/local/sbin/stop.sh

#mkdir -m 1777 /tmp/.X11-unix
#mkdir .vnc
printf "%s" "$VNC_PASS" | vncpasswd -f > /home/user/.vnc/passwd
printf "%s\n" "$HEROKU_LOGIN" > .netrc
printf "%s" "$IDENTITY" > .ssh/id_rsa
printf "%s" "$GDRIVE_TOKEN" > .gdrive/token_v2.json
gdrive download $TELEGRAM_LOCAL
tar zxf telegram.local.tar.gz
git config --global user.email "chantzish@gmail.com"
git config --global user.name "chantzish"
git config --global credential.helper store
printf "%s\n" "$GIT_CREDENTIALS" > .git-credentials

vncserver -geometry 1536x754 :1
