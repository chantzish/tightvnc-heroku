#!/bin/sh

export HOME=/home/user
export USER=`whoami`
export LANG=en_US.UTF-8
export PATH="$PATH:/home/user/.local/bin:/usr/games:/usr/local/games"
export SHELL=/usr/bin/bash
#export JAVA_HOME=/usr/lib/jvm/default-java

#moved from launch.sh
touch /opt/noVNC/`whoami`
cd /opt/noVNC && ./utils/launch.sh --listen 6080 --vnc localhost:5901 &
/opt/noVNC/utils/websockify/run 6090 localhost:2200 --heartbeat=45 &
printf "%s" "$AUTH_KEYS" > .ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
/usr/sbin/sshd -p 2200 -o AuthorizedKeysFile=/home/user/.ssh/authorized_keys &

cd /home/user
# fix according to site
echo '#!/bin/sh\n\nwhile :; do wget '$APP_NAME'.herokuapp.com -q -O /dev/null -o /dev/null; sleep 4m; done &' | tee /usr/local/sbin/stop.sh
chmod +x /usr/local/sbin/stop.sh

#mkdir -m 1777 /tmp/.X11-unix
#mkdir .vnc
printf "%s" "$VNC_PASS" | vncpasswd -f > /home/user/.vnc/passwd
chmod 600 .vnc/passwd
printf "%s" "$HEROKU_LOGIN" > .netrc
printf "%s" "$IDENTITY" > .ssh/id_rsa

vncserver -geometry 1536x864 :1

cd gdrive
sed -i 's/const ClientId = ".*.apps.googleusercontent.com"/const ClientId = "'"$GDRIVE_CLIENT_ID"'"/' handlers_drive.go
sed -i 's/const ClientSecret = ".*"/const ClientSecret = "'"$GDRIVE_CLIENT_SECRET"'"/' handlers_drive.go
#go get github.com/prasmussen/gdrive
go build -ldflags '-w -s'
cp gdrive /usr/local/sbin/gdrive
cd ..
printf "%s" "$GDRIVE_TOKEN" > .gdrive/token_v2.json
gdrive download $TELEGRAM_LOCAL
tar zxf telegram.local.tar.gz
gdrive download $ZOOM
tar zxf zoom.tar.gz
printf "%s" "$GIT_CONF" > .gitconfig
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"
git config --global credential.helper store
git config --global color.ui auto
printf "%s" "$GIT_CREDENTIALS" > .git-credentials

cd Downloads && utserver -settingspath /opt/utorrent-server-alpha-v3_3/ -daemon
