#!/bin/sh

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
printf "%s" "$HEROKU_LOGIN" > .netrc
printf "%s" "$IDENTITY" > .ssh/id_rsa
printf "%s" "$GDRIVE_TOKEN" > .gdrive/token_v2.json
gdrive download $TELEGRAM_LOCAL
tar zxf telegram.local.tar.gz
printf "%s" "$GIT_CONFIG" > .gitconfig
printf "%s" "$GIT_CREDENTIALS" > .git-credentials

vncserver -geometry 1536x754 :1
