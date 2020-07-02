FROM ubuntu
RUN apt update && apt install -y sudo && useradd -D -s /bin/bash && useradd -u 1000 -U -G adm,cdrom,sudo,dip,plugdev -s /bin/bash -m user && yes "1234" | passwd user
USER 1000
WORKDIR /home/user
ENV LANG=en_US.UTF-8
ENV SHELL=/usr/bin/bash
ENV HOME=/home/user
ENV USER=user
ENV PORT=3000
EXPOSE 3000/tcp
COPY apt-xapian-index_999.002_all.deb /home/user/apt-xapian-index_999.002_all.deb
RUN echo 1234 | sudo -S apt update && \
    echo 1234 | sudo -S chown 1000:1000 /home/user/apt-xapian-index_999.002_all.deb && \
    # prevent sudo error message
    echo "Set disable_coredump false" | sudo tee /etc/sudo.conf && \
    # some basic packages and special non interactive
    sudo DEBIAN_FRONTEND=noninteractive apt install -y keyboard-configuration tzdata && \
    sudo apt install -y whiptail apt-utils libterm-readline-gnu-perl locales apt-transport-https curl wget gnupg software-properties-common ./apt-xapian-index_999.002_all.deb && \
    sudo locale-gen en_IL en_US.UTF-8 && \
    sudo update-locale LANG=en_IL && \
    sudo dpkg-reconfigure --frontend=noninteractive locales && \
    echo '# KEYBOARD CONFIGURATION FILE\n\n# Consult the keyboard(5) manual page.\n\nXKBMODEL="pc105"\nXKBLAYOUT="us,il"\nXKBVARIANT=","\nXKBOPTIONS="grp:alt_shift_toggle,grp_led:scroll"\n\nBACKSPACE="guess"' | sudo tee /etc/default/keyboard && \
    echo "Asia/Jerusalem" | sudo tee /etc/timezone && \
    sudo ln -snf /usr/share/zoneinfo/Asia/Jerusalem /etc/localtime && \
    sudo dpkg-reconfigure --frontend=noninteractive keyboard-configuration tzdata && \
    # manual addition packages
    echo "deb https://cli-assets.heroku.com/apt ./" | sudo tee /etc/apt/sources.list.d/heroku.list && \
    curl https://cli-assets.heroku.com/apt/release.key | sudo apt-key add - && \
    wget https://zoom.us/client/latest/zoom_amd64.deb && \
    wget https://mega.nz/linux/MEGAsync/xUbuntu_20.04/amd64/megacmd-xUbuntu_20.04_amd64.deb && \
    wget 'https://launchpad.net/~ubuntu-security-proposed/+archive/ubuntu/ppa/+build/16429988/+files/libssl1.0.0_1.0.2n-1ubuntu6.2_amd64.deb' && \
    wget 'https://launchpad.net/~ubuntu-security-proposed/+archive/ubuntu/ppa/+build/16429988/+files/libssl1.0-dev_1.0.2n-1ubuntu6.2_amd64.deb' && \
    #wget 'https://ftp.hetzner.de/ubuntu/packages/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu6.2_i386.deb' && \
    #wget 'https://ftp.hetzner.de/ubuntu/packages/pool/main/o/openssl1.0/libssl1.0-dev_1.0.2n-1ubuntu6.2_i386.deb' && \
    sudo dpkg --add-architecture i386 && \
    wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
    sudo apt-key add winehq.key && \
    sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' && \
    sudo apt-add-repository universe && \
    # try fix utorrent
    #sudo add-apt-repository ppa:ubuntu-security-proposed/ppa && \
    echo 1234 | sudo -S apt update && \
    echo 1234 | sudo -S apt install -y --install-recommends winehq-devel && \
    # prevent gdm3 from installing as dependency of lubuntu-desktop
    echo 1234 | sudo -S apt install -y lxqt-notificationd && \
    echo 1234 | sudo -S apt install -y \
        heroku \
        #lubuntu-desktop \
        tasksel \
        curl \
        binutils \
        build-essential \
        autoconf \
        fakeroot \
        fakechroot \
        net-tools \
        git \
        gawk \
        telnet \
        python \
        python-numpy \
        nginx \
        tigervnc-standalone-server \
        less \
        qemu \
        openssh-server \
        p7zip-rar \
        p7zip-full \
        x11-xserver-utils \
        xdotool \
        x11-apps \
        golang-go \
        ffmpeg \
        python3-pip \
        cabextract \
        ./megacmd-xUbuntu_20.04_amd64.deb \
        ./zoom_amd64.deb \
        kazam \
        # fix problem in opening scripts from pcmanfm-qt
        xterm \
        # installed by lubuntu-desktop
        #x11-utils \
        #bc \
        #firefox \
        #transmission-qt \
        #vlc \
        #xz-utils \
        #zip \
        #unzip \
        # vim installed already
        #vim-tiny \
        # ark is used instead
        #file-roller \
        # qpdfview is used instead
        #evince \
        # for utorrent server
        ./libssl1.0.0_1.0.2n-1ubuntu6.2_amd64.deb ./libssl1.0-dev_1.0.2n-1ubuntu6.2_amd64.deb \
        #./libssl1.0.0_1.0.2n-1ubuntu6.2_i386.deb ./libssl1.0-dev_1.0.2n-1ubuntu6.2_i386.deb \
        #libssl1.0.0 libssl-dev \
        # for debconf-get-selections for not interactive apt/dpkg install
        #debconf-utils \
        # lower image size
        winbind \
        #samba \
        #thunderbird \
        #virtualenv \
        #default-jdk \
        #openjdk-8-jdk \
        #fonts-liberation libappindicator1 \
        && \
    echo '#############################################################################################################################' && \
    echo '                                           start tastksel install lubuntu-desktop                                            ' && \
    echo '#############################################################################################################################' && \
    # echo 1234 | sudo -S mv /usr/bin/debconf-apt-progress /usr/bin/debconf-apt-progress-old && \
    # echo '#!/bin/sh\n\nshift;$@' | sudo tee /usr/bin/debconf-apt-progress && \
    # sudo chmod +x /usr/bin/debconf-apt-progress && \
    echo 1234 | sudo -S sed -i 's:if (-x "/usr/bin/debconf-apt-progress"):if (0 \&\& -x "/usr/bin/debconf-apt-progress"):' /usr/bin/tasksel && \
    sudo tasksel install lubuntu-desktop && \
    # sudo python -c 'import pty; pty.spawn(["/usr/bin/tasksel", "install", "lubuntu-desktop"])' && \
    echo 1234 | sudo -S sed -i 's/NotShowIn=/NotShowIn=LXQt;/' /etc/xdg/xdg-Lubuntu/autostart/nm-applet.desktop && \
    echo 1234 | sudo -S sed -i 's/NotShowIn=/NotShowIn=LXQt;/' /etc/xdg/autostart/nm-applet.desktop && \
    sudo sed -i 's/NotShowIn=/NotShowIn=LXQt;/' /etc/xdg/autostart/nm-tray-autostart.desktop && \
    echo "NotShowIn=LXQt;" | sudo tee -a /etc/xdg/autostart/upg-notifier-autostart.desktop && \
    sudo sed -i 's/OnlyShowIn=LXQt/NotShowIn=LXQt/' /etc/xdg/autostart/lxqt-xscreensaver-autostart.desktop && \
    sudo sed -i 's/OnlyShowIn=LXQt/NotShowIn=LXQt/' /etc/xdg/autostart/lxqt-powermanagement.desktop && \
    #sudo rm /etc/xdg/autostart/lxpolkit.desktop && \
    #sudo mv /usr/bin/lxpolkit /usr/bin/lxpolkit.ORIG && \
    #echo 1234 | sudo -S sed -i 's/assistive_technologies=org.GNOME.Accessibility.AtkWrapper/#assistive_technologies=org.GNOME.Accessibility.AtkWrapper/' /etc/java-8-openjdk/accessibility.properties && \
    sudo sed -i 's/load-module module-udev-detect/#load-module module-udev-detect/' /etc/pulse/default.pa && \
    sudo sed -i 's/load-module module-bluetooth-discover/#load-module module-bluetooth-discover/' /etc/pulse/default.pa && \
    echo KexAlgorithms +diffie-hellman-group1-sha1 | sudo tee -a /etc/ssh/sshd_config && \
    echo "#HostKeyAlgorithms +ssh-dss" | sudo tee -a /etc/ssh/sshd_config && \
    echo "#MACs +hmac-sha1" | sudo tee -a /etc/ssh/sshd_config && \
    echo Ciphers +aes128-cbc | sudo tee -a /etc/ssh/sshd_config && \
    sudo sed -i 's/#Port 22/Port 2200/' /etc/ssh/sshd_config && \
    echo 1234 | sudo -S sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
    echo 1234 | sudo -S sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
    sudo sed -i 's/ShowHidden=false/ShowHidden=true/' /etc/xdg/xdg-Lubuntu/pcmanfm-qt/lxqt/settings.conf && \
    sudo sed -i 's/SplitterPos=275/SplitterPos=150/' /etc/xdg/xdg-Lubuntu/pcmanfm-qt/lxqt/settings.conf && \
    sudo sed -i 's/Width=640/Width=700\nLastWindowHeight=480\nLastWindowMaximized=false\nLastWindowWidth=700/' /etc/xdg/xdg-Lubuntu/pcmanfm-qt/lxqt/settings.conf && \
    #echo 1234 | sudo -S useradd -u 1000 -U -G adm,cdrom,sudo,dip,plugdev -s /bin/bash -m user && yes "1234" | sudo passwd user
#USER 1000
#WORKDIR /home/user
#ENV LANG=en_US.UTF-8
#ENV SHELL=/usr/bin/bash
#ENV HOME=/home/user
#ENV USER=user
#ENV PORT=3000
#EXPOSE 3000/tcp
#RUN 
    mkdir .ssh && \
    chmod 700 ~/.ssh && \
    echo 1234 | sudo -S git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    sudo git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    sudo sed -i 's/${WEBSOCKIFY} ${SSLONLY} --web ${WEB}/${WEBSOCKIFY} ${SSLONLY} --heartbeat=45 --web ${WEB}/' /opt/noVNC/utils/launch.sh && \
    #echo export JAVA_HOME=/usr/lib/jvm/default-java >> .profile && \
    echo export LANG=en_US.UTF-8 >> .profile && \
    echo export HOME=/home/user >> .profile && \
    echo export SHELL=/usr/bin/bash >> .profile && \
    echo export PATH=\"\$PATH:/home/user/.local/bin:/usr/games:/usr/local/games\" >> .profile && \
    wget https://github.com/novnc/websockify/raw/master/websockify/websocket.py && \
    wget https://github.com/chantzish/python-dewebsockify/raw/master/dewebsockify.py && \
    wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/ && \
    sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop && \
    sudo chown -R 1000:1000 /opt && \
    sudo chmod 755 -R /opt && \
    heroku version && \
    git clone https://github.com/gdrive-org/gdrive.git && \
    mkdir .gdrive && \
    cd gdrive && \
    go get github.com/prasmussen/gdrive && \
    cd .. && \
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
    sudo apt-get install -y nodejs && \
    git clone https://github.com/chantzish/dewebsockify.git && \
    cd dewebsockify && \
    npm install && \
    cd .. && \
    sudo wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O /usr/local/sbin/winetricks && \
    sudo chmod +x /usr/local/sbin/winetricks && \
    #mkdir -p ~/.cache/wine/ && \
    #wget http://dl.winehq.org/wine/wine-mono/4.9.4/wine-mono-4.9.4.msi -O ~/.cache/wine/wine-mono-4.9.4.msi && \
    #wget https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi -O ~/.cache/wine/wine-gecko-2.47.1-x86.msi && \
    #wget https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi -O ~/.cache/wine/wine-gecko-2.47.1-x86_64.msi && \
    #WINEPREFIX=/home/user/.wine WINEARCH=win32 wine wineboot && \
    #winetricks win98 && \
    #wine wineboot && \
    wget http://download-hr.utorrent.com/track/beta/endpoint/utserver/os/linux-x64-ubuntu-13-04 -O utserver-linux-x64-ubuntu-13-04.tar.gz && \
    sudo tar xvf utserver-linux-x64-ubuntu-13-04.tar.gz -C /opt/ && \
    sudo ln -s /opt/utorrent-server-alpha-v3_3/utserver /usr/bin/utserver && \
    sudo sed -i 's/worker_processes auto/worker_processes 4/' /etc/nginx/nginx.conf && \
    mkdir /opt/noVNC/user && \
    mkdir /opt/noVNC/gui && \
    heroku plugins:install heroku-builds && \
    sudo rm /var/lib/dpkg/statoverride && \
    if [ ! -d ".vnc" ]; then mkdir .vnc; fi && \
    echo 1234 | sudo -S chown -R 1000:1000 /etc/ssh && \
    # echo 1234 | sudo -S chmod -R 600 /etc/ssh/ssh_config.d/ && \
    echo 1234 | sudo -S chown -R 1000:1000 /etc/ssh /usr/lib/openssh /usr/share/openssh /etc/nginx /usr/lib/nginx /usr/share/nginx /var/lib/nginx /var/log/nginx /var/www && \
    echo 1234 | sudo -S chown 1000:1000 /etc/logrotate.d/nginx && \
    echo 1234 | sudo -S chmod a+w /run && \
    if [ ! -d ".local/bin" ]; then mkdir -p .local/bin; fi && \
    sudo mkdir /tmp/.X11-unix && \
    if [ ! -d ".config" ]; then mkdir .config; fi && \
    echo 1234 | sudo -S cp -R /etc/xdg/xdg-Lubuntu/* .config/ && \
    echo 1234 | sudo -S chown -R 1000:1000 .config
COPY heroku.yml /home/user/heroku.yml
COPY settings.dat /opt/utorrent-server-alpha-v3_3/settings.dat
COPY xstartup /home/user/.vnc/xstartup
COPY nginx.template /home/user/nginx.template
COPY launch.sh /home/user/launch.sh
COPY launch-gui.sh /home/user/launch-gui.sh
COPY Dockerfile /home/user/Dockerfile
RUN echo 1234 | sudo -S chown 1000:1000 heroku.yml .vnc/xstartup nginx.template launch.sh launch-gui.sh Dockerfile /opt/utorrent-server-alpha-v3_3/settings.dat && \
    chmod +x launch.sh launch-gui.sh .vnc/xstartup
CMD /home/user/launch-gui.sh & /home/user/launch.sh 
