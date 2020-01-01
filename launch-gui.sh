#!/bin/sh

export HOME=/home/user
export USER=`whoami`
export LANG=en_IL
#export JAVA_HOME=/usr/lib/jvm/default-java

# fix according to site
echo '#!/bin/sh\n\nwhile :; do wget '$APP_NAME'.herokuapp.com -q -O /dev/null -o /dev/null; sleep 4m; done &' | tee /usr/local/sbin/stop.sh
chmod +x /usr/local/sbin/stop.sh

#mkdir -m 1777 /tmp/.X11-unix
mkdir .vnc
printf "%s" "$VNC_PASS" | vncpasswd -f > /home/user/.vnc/passwd
printf "%s\n" "$HEROKU_LOGIN" > .netrc
printf "%s" "$IDENTITY" > .ssh/id_rsa
printf "%s" "$GDRIVE_TOKEN" > .gdrive/token_v2.json
git config --global user.email "chantzish@gmail.com"
git config --global user.name "chantzish"
git config --global credential.helper store
printf "%s\n" "$GIT_CREDENTIALS" > .git-credentials

vncserver -geometry 1536x754 :1
