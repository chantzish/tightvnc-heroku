FROM ubuntu
RUN apt update && apt install -y sudo && useradd -u 1000 -U -G adm,cdrom,sudo,dip,plugdev -m user && yes "1234" | passwd user
USER user
WORKDIR /home/user
ENV LANG=en_US.UTF-8
COPY apt-xapian-index_999.002_all.deb /home/user/apt-xapian-index_999.002_all.deb
RUN echo 1234 | sudo -S apt update && \
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
    wget 'https://ftp.hetzner.de/ubuntu/packages/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu6.2_i386.deb' && \
    wget 'https://ftp.hetzner.de/ubuntu/packages/pool/main/o/openssl1.0/libssl1.0-dev_1.0.2n-1ubuntu6.2_i386.deb' && \
    sudo dpkg --add-architecture i386 && \
    wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
    sudo apt-key add winehq.key && \
    sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' && \
    sudo apt-add-repository universe && \
    # try fix utorrent
    #sudo add-apt-repository ppa:ubuntu-security-proposed/ppa && \
    sudo apt update && \
    sudo apt install -y --install-recommends winehq-devel && \
    # prevent gdm3 from installing as dependency of lubuntu-desktop
    sudo apt install -y lxqt-notificationd && \
    sudo apt install -y \
        heroku \
        lubuntu-desktop \
        curl \
        binutils \
        build-essential \
        autoconf \
        fakeroot \
        fakechroot \
        xz-utils \
        bc \
        vim-tiny \
        net-tools \
        git \
        gawk \
        telnet \
        python \
        python-numpy \
        nginx \
        tigervnc-standalone-server \
        vlc \
        less \
        qemu \
        zip \
        unzip \
        openssh-server \
        p7zip-rar \
        p7zip-full \
        x11-xserver-utils \
        xdotool \
        x11-apps \
        x11-utils \
        firefox:i386 \
        vlc \
        # ark is used instead
        #file-roller \
        transmission-qt \
        # qpdfview is used instead
        #evince \
        golang-go \
        ffmpeg \
        python3-pip \
        cabextract \
        ./megacmd-xUbuntu_20.04_amd64.deb \
        ./zoom_amd64.deb \
        kazam \
        # for utorrent server
        ./libssl1.0.0_1.0.2n-1ubuntu6.2_amd64.deb ./libssl1.0-dev_1.0.2n-1ubuntu6.2_amd64.deb \
        ./libssl1.0.0_1.0.2n-1ubuntu6.2_i386.deb ./libssl1.0-dev_1.0.2n-1ubuntu6.2_i386.deb \
        #libssl1.0.0 libssl-dev \
        # for debconf-get-selections for not interactive apt/dpkg install
        #debconf-utils \
        # lower image size
        #winbind \
        #samba \
        #thunderbird \
        #virtualenv \
        #default-jdk \
        #openjdk-8-jdk \
        #fonts-liberation libappindicator1 \
        && \
    sudo sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
    mkdir .ssh && \
    chmod 700 ~/.ssh && \
    sudo git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    sudo git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    sudo sed -i 's/${WEBSOCKIFY} ${SSLONLY} --web ${WEB}/${WEBSOCKIFY} ${SSLONLY} --heartbeat=45 --web ${WEB}/' /opt/noVNC/utils/launch.sh && \
    sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
    #echo export JAVA_HOME=/usr/lib/jvm/default-java >> .profile && \
    echo export LANG=en_US.UTF-8 >> .profile && \
    echo export HOME=/home/user >> .profile && \
    echo export PATH=\"\$PATH:/home/user/.local/bin:/usr/games:/usr/local/games\" >> .profile && \
    #echo 1234 | sudo -S rm /etc/xdg/autostart/update-notifier.desktop && \
    #sudo rm /etc/xdg/autostart/lxpolkit.desktop && \
    #sudo mv /usr/bin/lxpolkit /usr/bin/lxpolkit.ORIG && \
    #echo "NotShowIn=GNOME;Unity;LXDE;" | sudo tee -a /etc/xdg/autostart/light-locker.desktop && \
    #echo 1234 | sudo -S sed -i 's/assistive_technologies=org.GNOME.Accessibility.AtkWrapper/#assistive_technologies=org.GNOME.Accessibility.AtkWrapper/' /etc/java-8-openjdk/accessibility.properties && \
    sudo sed -i 's/load-module module-udev-detect/#load-module module-udev-detect/' /etc/pulse/default.pa && \
    sudo sed -i 's/load-module module-bluetooth-discover/#load-module module-bluetooth-discover/' /etc/pulse/default.pa && \
    echo KexAlgorithms +diffie-hellman-group1-sha1 | sudo tee -a /etc/ssh/sshd_config && \
    echo "#HostKeyAlgorithms +ssh-dss" | sudo tee -a /etc/ssh/sshd_config && \
    echo "#MACs +hmac-sha1" | sudo tee -a /etc/ssh/sshd_config && \
    echo Ciphers +aes128-cbc | sudo tee -a /etc/ssh/sshd_config && \
    sudo sed -i 's/#Port 22/Port 2200/' /etc/ssh/sshd_config && \
    wget https://github.com/novnc/websockify/raw/master/websockify/websocket.py && \
    wget https://github.com/chantzish/python-dewebsockify/raw/master/dewebsockify.py && \
    wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/ && \
    sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop && \
    sudo chown -R user:user /opt && \
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
    sudo rm /var/lib/dpkg/statoverride
COPY heroku.yml /home/user/heroku.yml
COPY settings.dat /opt/utorrent-server-alpha-v3_3/settings.dat
COPY xstartup /home/user/.vnc/xstartup
COPY nginx.template /home/user/nginx.template
COPY launch.sh /home/user/launch.sh
COPY launch-gui.sh /home/user/launch-gui.sh
COPY Dockerfile /home/user/Dockerfile
CMD /home/user/launch-gui.sh & /home/user/launch.sh 
