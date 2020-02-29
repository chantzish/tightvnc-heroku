FROM ubuntu
RUN apt update && apt install -y sudo && useradd -u 1000 -U -G adm,cdrom,sudo,dip,plugdev -m user && yes "1234" | passwd user
USER user
WORKDIR /home/user
ENV LANG=en_IL
RUN echo 1234 | sudo -S apt update && \
    sudo apt install -y whiptail apt-utils libterm-readline-gnu-perl locales apt-transport-https curl gnupg software-properties-common && \
    echo "deb https://cli-assets.heroku.com/apt ./" | sudo tee /etc/apt/sources.list.d/heroku.list && \
    curl https://cli-assets.heroku.com/apt/release.key | sudo apt-key add - && \
    sudo locale-gen en_IL en_US.UTF-8 && \
    sudo update-locale LANG=en_IL && \
    sudo dpkg-reconfigure --frontend=noninteractive locales && \
    sudo DEBIAN_FRONTEND=noninteractive apt install -y keyboard-configuration tzdata && \
    echo '# KEYBOARD CONFIGURATION FILE\n\n# Consult the keyboard(5) manual page.\n\nXKBMODEL="pc105"\nXKBLAYOUT="us,il"\nXKBVARIANT=","\nXKBOPTIONS="grp:alt_shift_toggle,grp_led:scroll"\n\nBACKSPACE="guess"' | sudo tee /etc/default/keyboard && \
    echo "Asia/Jerusalem" | sudo tee /etc/timezone && \
    sudo ln -snf /usr/share/zoneinfo/Asia/Jerusalem /etc/localtime && \
    sudo dpkg-reconfigure --frontend=noninteractive keyboard-configuration tzdata && \
    sudo dpkg --add-architecture i386 && \
    sudo apt update && \
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
    sudo apt install -y \
        binutils \
        build-essential \
        autoconf \
        fakeroot \
        xz-utils \
        vim-tiny \
        net-tools \
        git \
        gawk \
        telnet \
        python \
        python-numpy \
        nginx \
        tigervnc-standalone-server \
        megatools \
        less \
        zip \
        unzip \
        openssh-server \
        p7zip-rar \
        p7zip-full \
        #xrandr is in x11-xserver-utils
        x11-xserver-utils \
        xdotool \
        x11-apps \
        x11-utils \
        gettext-base \
        firefox \
        vlc \
        leafpad \
        file-roller \
        transmission \
        evince \
        lubuntu-core \
        ffmpeg \
        #default-jdk \
        libssl-dev libffi-dev python-dev python3-dev ncurses-dev python-pip python3-pip virtualenv python3-venv \
        #openjdk-8-jdk \
        fonts-liberation libappindicator1 \
        heroku \
        golang-go \
        nodejs \
        guacamole && \
    sudo sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
    mkdir .ssh && \
    chmod 700 ~/.ssh && \
    sudo git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    sudo git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    sudo sed -i 's/${WEBSOCKIFY} ${SSLONLY} --web ${WEB}/${WEBSOCKIFY} ${SSLONLY} --heartbeat=45 --web ${WEB}/' /opt/noVNC/utils/launch.sh && \
    sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
    echo export LANG=en_IL >> .profile && \
    #echo export JAVA_HOME=/usr/lib/jvm/default-java >> .profile && \
    echo export PATH=$PATH:/home/user/.local/bin/ >> .profile && \
    echo 1234 | sudo -S rm /etc/xdg/autostart/update-notifier.desktop && \
    #sudo rm /etc/xdg/autostart/lxpolkit.desktop && \
    #sudo mv /usr/bin/lxpolkit /usr/bin/lxpolkit.ORIG && \
    #echo "NotShowIn=GNOME;Unity;LXDE;" | sudo tee -a /etc/xdg/autostart/light-locker.desktop && \
    #sudo sed -i 's/assistive_technologies=org.GNOME.Accessibility.AtkWrapper/#assistive_technologies=org.GNOME.Accessibility.AtkWrapper/' /etc/java-8-openjdk/accessibility.properties
    sudo sed -i 's/load-module module-udev-detect/#load-module module-udev-detect/' /etc/pulse/default.pa && \
    sudo sed -i 's/load-module module-detect/#load-module module-detect/' /etc/pulse/default.pa && \
    sudo sed -i 's/load-module module-bluetooth-discover/#load-module module-bluetooth-discover/' /etc/pulse/default.pa && \
    sudo sed -i 's/load-module module-bluetooth-policy/#load-module module-bluetooth-policy/' /etc/pulse/default.pa && \
    sudo sed -i 's/#load-module module-native-protocol-tcp/load-module module-native-protocol-tcp auth-anonymous=1/' /etc/pulse/default.pa && \
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
    git clone https://github.com/chantzish/dewebsockify.git && \
    sudo rm /etc/dpkg/dpkg.cfg.d/excludes && \
    sudo rm /var/lib/dpkg/statoverride
COPY heroku.yml /home/user/heroku.yml
COPY xstartup /home/user/.vnc/xstartup
COPY nginx.template /home/user/nginx.template
COPY launch.sh /home/user/launch.sh
COPY launch-gui.sh /home/user/launch-gui.sh
COPY Dockerfile /home/user/Dockerfile
CMD /home/user/launch-gui.sh & /home/user/launch.sh 
