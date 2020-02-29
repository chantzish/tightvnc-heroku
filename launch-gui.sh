#!/bin/sh

export HOME=/home/user
export USER=`whoami`
export LANG=en_IL
export PATH=/usr/games:$PATH
#export JAVA_HOME=/usr/lib/jvm/default-java

# fix according to site
echo '#!/bin/sh\n\nwhile :; do wget '$APP_NAME'.herokuapp.com -q -O /dev/null -o /dev/null; sleep 4m; done &' | tee /usr/local/sbin/stop.sh
chmod +x /usr/local/sbin/stop.sh

#mkdir -m 1777 /tmp/.X11-unix
#mkdir .vnc
printf "%s" "$VNC_PASS" | vncpasswd -f > /home/user/.vnc/passwd
printf "%s" "$HEROKU_LOGIN" > .netrc
printf "%s" "$IDENTITY" > .ssh/id_rsa
cd gdrive
sed -i 's/const ClientId = ".*.apps.googleusercontent.com"/const ClientId = "'"$GDRIVE_CLIENT_ID"'"/' handlers_drive.go
sed -i 's/const ClientSecret = ".*"/const ClientSecret = "'"$GDRIVE_CLIENT_SECRET"'"/' handlers_drive.go
go get github.com/prasmussen/gdrive
go build
cp gdrive /usr/local/sbin/gdrive
cd ..
printf "%s" "$GDRIVE_TOKEN" > .gdrive/token_v2.json
gdrive download $TELEGRAM_LOCAL
tar zxf telegram.local.tar.gz
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"
git config --global credential.helper store
git config --global color.ui auto
printf "%s\n" "$GIT_CREDENTIALS" > .git-credentials

vncserver -geometry 1536x754 :1

sed -i 's/TOMCAT8_GROUP=tomcat8/TOMCAT8_GROUP='"`id -gn`"'/' /etc/default/tomcat8
sed -i 's/TOMCAT8_GROUP=tomcat8/TOMCAT8_GROUP='"`id -gn`"'/' /etc/init.d/tomcat8
sed -i 's/TOMCAT8_USER=tomcat8/TOMCAT8_USER='"`whoami`"'/' /etc/default/tomcat8
sed -i 's/TOMCAT8_USER=tomcat8/TOMCAT8_USER='"`whoami`"'/' /etc/init.d/tomcat8
sed -i 's/if \[ `id -u` -ne 0 \]/if false \&\& \[ `id -u` -ne 0 \]/' /etc/init.d/tomcat8
sed -i 's/su $TOMCAT8_USER -s //' /etc/init.d/tomcat8
sed -i 's/usermod/#usermod/' /etc/init.d/tomcat8
sed -i 's/install -o $TOMCAT8_USER -g adm/install -o $TOMCAT8_USER -g '"`id -gn`"'/' /etc/init.d/tomcat8
service tomcat8 start
