FROM ubuntu
RUN apt update && apt install -y sudo && useradd -u 1000 -U -G root,adm,cdrom,sudo,dip,plugdev -m user && yes "1234" | passwd user
USER 1000
WORKDIR /home/user
ENV HOME=/home/user
ENV USER=user
ENV LANG=en_IL
RUN echo 1234 | sudo -S apt update && \
    sudo apt install -y whiptail apt-utils libterm-readline-gnu-perl locales apt-transport-https curl gnupg && \
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
    sudo apt install -y \
        libc6:i386 \
        libstdc++6:i386 \
        libssl1.0.0:i386 \
        libx11-6:i386 \
        libncurses5:i386 \
        zlib1g:i386 \
        libgtk2.0-0:i386 \
        libsdl1.2debian:i386 \
        libgtk-3-0:i386 \
        heroku \
#???????
        bzip2 \
        libbz2-1.0 \
        libbz2-1.0:i386 \
        libdb5.3:i386 \
        libexpat1:i386 \
        libffi6:i386 \
        libgpm2:i386 \
        libncursesw5:i386 \
        libpython-stdlib:i386 \
        libpython2.7-minimal:i386 \
        libpython2.7-stdlib:i386 && \
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
        device-tree-compiler \
        vim-tiny \
        net-tools \
        git \
        gawk \
        telnet \
        python \
        python-numpy \
        nginx \
        #xserver-xorg-video-dummy \
        #x11vnc \
        tigervnc-standalone-server vlc megatools \
        less \
        socat \
        vde2 \
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
        gettext-base \
        firefox \
        vlc \
        leafpad \
        file-roller \
        transmission \
        evince \
        lubuntu-core \
        golang-go \
        binutils-aarch64-linux-gnu \
        gcc-aarch64-linux-gnu \
        g++-aarch64-linux-gnu \
        binutils-arm-linux-gnueabi \
        gcc-arm-linux-gnueabi \
        g++-arm-linux-gnueabi \
        binutils-arm-linux-gnueabihf \
        gcc-arm-linux-gnueabihf \
        g++-arm-linux-gnueabihf \
        tint2 \
        ffmpeg \
        expect-dev \
        #default-jdk \
        libssl-dev libffi-dev python-dev python3-dev ncurses-dev python-pip python3-pip virtualenv \
        #openjdk-8-jdk \
        fonts-liberation libappindicator1 \
        qemu-user-static \
        debootstrap \
        schroot \
        cgroup-tools && \
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
    sudo sed -i 's/load-module module-bluetooth-discover/#load-module module-bluetooth-discover/' /etc/pulse/default.pa && \
    echo KexAlgorithms +diffie-hellman-group1-sha1 | sudo tee -a /etc/ssh/sshd_config && \
    echo "#HostKeyAlgorithms +ssh-dss" | sudo tee -a /etc/ssh/sshd_config && \
    echo "#MACs +hmac-sha1" | sudo tee -a /etc/ssh/sshd_config && \
    echo Ciphers +aes128-cbc | sudo tee -a /etc/ssh/sshd_config && \
    sudo sed -i 's/#Port 22/Port 2200/' /etc/ssh/sshd_config && \
    echo wget https://github.com/novnc/websockify/raw/master/websockify/websocket.py && \
    wget https://github.com/novnc/websockify/raw/master/websockify/websocket.py && \
    echo wget https://github.com/chantzish/python-dewebsockify/raw/master/dewebsockify.py && \
    wget https://github.com/chantzish/python-dewebsockify/raw/master/dewebsockify.py && \
    echo wget -O- https://telegram.org/dl/desktop/linux \| sudo tar xJ -C /opt/ && \
    wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/ && \
    sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop && \
    sudo chown -R user:user /opt && \
    sudo chmod 755 -R /opt && \
    heroku version && \
    echo sudo wget "https://github.com/gdrive-org/gdrive/releases/download/2.1.0/gdrive-linux-x64" -O /usr/local/sbin/gdrive && \
    sudo wget "https://github.com/gdrive-org/gdrive/releases/download/2.1.0/gdrive-linux-x64" -O /usr/local/sbin/gdrive && \
    sudo chmod +x /usr/local/sbin/gdrive && \
    mkdir .gdrive && \
    echo curl -sL https://deb.nodesource.com/setup_12.x \| sudo -E bash - && \
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
    sudo apt-get install -y nodejs && \
    git clone https://github.com/chantzish/dewebsockify.git && \
    #sudo bash -c -O extglob "chown -R `id -un`:`id -gn` /"'!(dev|etc|proc|run|sys|tmp|usr) /etc/!(bash.bashrc|group|hostname|hosts|passwd|profile|resolv.conf|sudoers|sudoers.d) /run/!(sudo) /usr/!(bin|lib) /usr/bin/!(sudo) /usr/lib/!(sudo) && chown '"`id -un`:`id -gn` / /tmp /etc /usr /run /usr/bin /usr/lib" && \
    echo 1234 | sudo -S rm /var/lib/dpkg/statoverride && \
    mkdir .ssh && \
    echo 1234 | sudo -S bash -c -O extglob 'chgrp -R 0 /!(sys|proc|etc|run|usr) /etc/!(resolv.conf|sudoers|sudoers.d|mtab) /run/!(sudo|initctl) /usr/!(bin|lib) /usr/bin/!(sudo) /usr/lib/!(sudo) && chgrp 0 / /etc /usr /run /usr/bin /usr/lib' && \
    echo 1234 | sudo -S bash -c -O extglob 'chmod -R g+u /!(sys|proc|etc|run|usr) /etc/!(resolv.conf|sudoers|sudoers.d|mtab) /run/!(sudo|initctl) /usr/!(bin|lib) /usr/bin/!(sudo) /usr/lib/!(sudo) && chmod g+u / /etc /usr /run /usr/bin /usr/lib'
COPY heroku.yml /home/user/heroku.yml
COPY xstartup /home/user/.vnc/xstartup
COPY nginx.template /home/user/nginx.template
COPY launch.sh /home/user/launch.sh
COPY launch-gui.sh /home/user/launch-gui.sh
COPY fix.sh /home/user/fix.sh
COPY Dockerfile /home/user/Dockerfile
EXPOSE 8000/tcp 
CMD /home/user/fix.sh && /home/user/launch-gui.sh & /home/user/launch.sh 
