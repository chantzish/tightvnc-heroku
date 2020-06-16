#!/bin/sh

export HOME=/home/user
export USER=`whoami`
export LANG=en_US.UTF-8
export PATH="/home/user/.local/bin/:/usr/games:$PATH"
#export JAVA_HOME=/usr/lib/jvm/default-java

# fix according to site
echo -e '#!/bin/sh\n\nwhile :; do wget '$APP_NAME'.herokuapp.com -q -O /dev/null -o /dev/null; sleep 4m; done &' | tee /home/user/.local/bin/stop.sh
chmod +x /home/user/.local/bin/stop.sh

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
cp gdrive /home/user/.local/bin/gdrive
cd ..
printf "%s" "$GDRIVE_TOKEN" > .gdrive/token_v2.json
gdrive download $TELEGRAM_LOCAL
tar zxf telegram.local.tar.gz

printf "%s" "$GIT_CONF" > .gitconfig
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"
git config --global credential.helper store
git config --global color.ui auto
printf "%s" "$GIT_CREDENTIALS" > .git-credentials

