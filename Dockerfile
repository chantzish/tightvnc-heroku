FROM ubuntu:18.04
RUN apt update && apt install -y sudo && useradd -u 1000 -U -G adm,cdrom,sudo,dip,plugdev -m user && yes "1234" | passwd user
#USER user
USER 1000
WORKDIR /home/user
ENV HOME=/home/user
ENV USER=user
ENV LANG=en_US.UTF-8
ENV PORT=8000
EXPOSE 8000/tcp
RUN export PATH="/home/user/.local/bin/:/usr/games:$PATH" && \
    export USER=user && \
    echo 1234 | sudo -S apt update && \
    sudo apt install -y whiptail apt-utils libterm-readline-gnu-perl locales apt-transport-https curl wget gnupg  software-properties-common && \
    #echo "Set disable_coredump false" | sudo tee /etc/sudo.conf && \
    sudo locale-gen en_IL en_US.UTF-8 && \
    sudo update-locale LANG=en_US.UTF-8 && \
    sudo dpkg-reconfigure --frontend=noninteractive locales && \
    sudo DEBIAN_FRONTEND=noninteractive apt install -y keyboard-configuration tzdata && \
    echo '# KEYBOARD CONFIGURATION FILE\n\n# Consult the keyboard(5) manual page.\n\nXKBMODEL="pc105"\nXKBLAYOUT="us,il"\nXKBVARIANT=","\nXKBOPTIONS="grp:alt_shift_toggle,grp_led:scroll"\n\nBACKSPACE="guess"' | sudo tee /etc/default/keyboard && \
    echo "Asia/Jerusalem" | sudo tee /etc/timezone && \
    sudo ln -snf /usr/share/zoneinfo/Asia/Jerusalem /etc/localtime && \
    sudo dpkg-reconfigure --frontend=noninteractive keyboard-configuration tzdata && \
    sudo dpkg --add-architecture i386 && \
    sudo apt-add-repository universe && \
    sudo apt update && \
    sudo apt install -y \
        curl \
        binutils \
        build-essential \
        autoconf \
#kernel compilation
        bison \
        flex \
        ncurses-dev \
        libssl-dev \
        fakeroot \
        fakechroot \
        xz-utils \
        libelf-dev \
        bc \
        vim-tiny \
        net-tools \
        git \
        gawk \
        telnet \
        python \
        python-numpy \
        nginx \
        tigervnc-standalone-server vlc \
        less \
        zip \
        unzip \
        openssh-server \
        p7zip-rar \
        p7zip-full \
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
        golang-go \
        ffmpeg \
        python3-pip virtualenv \
        openjdk-8-jdk \
        cabextract \
        # for debconf-get-selections for not interactive apt/dpkg install
        debconf-utils \
        && \
    echo 1234 | sudo -S sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
    mkdir .ssh && \
    chmod 700 ~/.ssh && \
    sudo git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    sudo git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    sudo sed -i 's/${WEBSOCKIFY} ${SSLONLY} --web ${WEB}/${WEBSOCKIFY} ${SSLONLY} --heartbeat=45 --web ${WEB}/' /opt/noVNC/utils/launch.sh && \
    sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
    echo export LANG=en_US.UTF-8 >> .profile && \
    #echo export JAVA_HOME=/usr/lib/jvm/default-java >> .profile && \
    echo export LANG=en_US.UTF-8 >> .profile && \
    echo export HOME=/home/user >> .profile && \
    echo "export PATH=\"/home/user/.local/bin/:/usr/games:\$PATH\"" >> .profile && \
    echo 1234 | sudo -S sed -i 's/assistive_technologies=org.GNOME.Accessibility.AtkWrapper/#assistive_technologies=org.GNOME.Accessibility.AtkWrapper/' /etc/java-8-openjdk/accessibility.properties && \
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
    sudo chmod 777 -R /opt && \
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
    sudo rm /var/lib/dpkg/statoverride
COPY heroku.yml /home/user/heroku.yml
COPY xstartup /home/user/.vnc/xstartup
COPY nginx.template /home/user/nginx.template
COPY launch.sh /home/user/launch.sh
COPY launch-gui.sh /home/user/launch-gui.sh
COPY Dockerfile /home/user/Dockerfile
CMD /home/user/launch-gui.sh & /home/user/launch.sh 
