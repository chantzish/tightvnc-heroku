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
gdrive download `gdrive list -m 200 | grep vmlinuz | awk '{print $1}'`
gdrive download `gdrive list -m 200 | grep initrd | awk '{print $1}'`
gdrive download `gdrive list -m 200 | grep arm.qcow2 | awk '{print $1}'`
qemu-system-arm -M virt -m 512M -kernel vmlinuz-4.9.0-11-armmp-lpae -initrd initrd.img-4.9.0-11-armmp-lpae -append root=/dev/vda2 -drive if=none,file=arm.qcow2,format=qcow2,id=hd -device virtio-blk-device,drive=hd -netdev user,hostfwd=tcp:0.0.0.0:2201-:22,id=mynet -device virtio-net-device,netdev=mynet -serial mon:telnet:0.0.0.0:2300,server,nowait -vga none -display none -daemonize
/opt/noVNC/utils/websockify/run 8081 localhost:2201 --heartbeat=45 &
/opt/noVNC/utils/websockify/run 8082 localhost:2300 --heartbeat=45 &
