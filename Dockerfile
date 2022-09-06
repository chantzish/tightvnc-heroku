# https://github.com/chantzish/tightvnc-heroku/blob/ubuntu18/Dockerfile
FROM ubuntu:18.04
RUN apt update && apt install -y sudo && useradd -D -s /bin/bash && useradd -u 1000 -U -G adm,cdrom,sudo,dip,plugdev -s /bin/bash -m user && yes "1234" | passwd user && mkdir -p /home/user/.local/share/applications && mkdir -p /home/user/.local/bin && chown -R 1000:1000 /home/user
USER 1000
WORKDIR /home/user
#COPY fly.toml /home/user/fly.toml
COPY nginx.template /home/user/nginx.template
COPY launch.sh /home/user/launch.sh
COPY launch-gui.sh /home/user/launch-gui.sh
COPY Dockerfile /home/user/Dockerfile
COPY appimagekit_46924f6eb8394393510aa1031f302145-Telegram_Desktop.desktop /home/user/.local/share/applications/appimagekit_46924f6eb8394393510aa1031f302145-Telegram_Desktop.desktop
COPY userapp-Telegram* /home/user/.local/share/applications/
COPY gdrive /home/user/.local/bin/gdrive
RUN export LANG=en_US.UTF-8 && \
    echo 1234 | sudo -S apt update && \
    echo "Set disable_coredump false" | sudo tee /etc/sudo.conf && \
    echo 1234 | sudo -S chown 1000:1000 nginx.template launch.sh launch-gui.sh Dockerfile ".local/share/applications/userapp-Telegram Desktop-0OX5L1.desktop" .local/share/applications/appimagekit_46924f6eb8394393510aa1031f302145-Telegram_Desktop.desktop .local/bin/gdrive && \
    chmod +x launch.sh launch-gui.sh .local/bin/gdrive && \
    echo 1234 | sudo -S DEBIAN_FRONTEND=noninteractive apt install -y keyboard-configuration locales tzdata && \
    echo 1234 | sudo -S apt install -y whiptail apt-utils libterm-readline-gnu-perl locales apt-transport-https curl wget gnupg software-properties-common lsb-release && \
    echo 1234 | sudo -S locale-gen en_IL en_US.UTF-8 && \
    echo 1234 | sudo -S update-locale LANG=en_US.UTF-8 && \
    echo 1234 | sudo -S dpkg-reconfigure --frontend=noninteractive locales && \
    echo 1234 | sudo -S locale-gen en_IL en_US.UTF-8 && \
    echo 1234 | sudo -S update-locale LANG=en_IL && \
    echo 1234 | sudo -S dpkg-reconfigure --frontend=noninteractive locales && \
    echo '# KEYBOARD CONFIGURATION FILE\n\n# Consult the keyboard(5) manual page.\n\nXKBMODEL="pc105"\nXKBLAYOUT="us,il"\nXKBVARIANT=","\nXKBOPTIONS="grp:alt_shift_toggle,grp_led:scroll"\n\nBACKSPACE="guess"' | sudo tee /etc/default/keyboard && \
    echo "Asia/Jerusalem" | sudo tee /etc/timezone && \
    echo 1234 | sudo -S ln -snf /usr/share/zoneinfo/Asia/Jerusalem /etc/localtime && \
    echo 1234 | sudo -S dpkg-reconfigure --frontend=noninteractive keyboard-configuration tzdata && \
    sudo add-apt-repository ppa:deadsnakes && \
    sudo apt-add-repository universe && \
    sudo apt-add-repository ppa:transmissionbt && \
    sudo add-apt-repository ppa:savoury1/ffmpeg4 && \
    sudo add-apt-repository ppa:sylvain-pineau/kazam && \
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    sudo apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" && \
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
    echo 1234 | sudo -S dpkg --add-architecture i386 && \
    echo 1234 | sudo -S apt update && \
    echo 1234 | sudo -S apt install -y --allow-downgrades \
        # fix bug
        libsystemd0=237-3ubuntu10.53 \
        libudev1=237-3ubuntu10.53 \
        # for development
        cmake \
        binutils \
        build-essential \
        autoconf \
        ncurses-dev \
        autotools-dev \
        dpkg-dev \
        libbz2-dev \
        libc-dev-bin \
        libc6-dev \
        libcryptui-dev \
        libcrypto++-dev \
        libexpat1-dev \
        libffi-dev \
        libgcc-8-dev \
        libgdbm-dev \
        libgmp-dev \
        libgnutls28-dev \
        libidn2-dev \
        libjbig2dec0-dev \
        libjpeg-dev \
        libjpeg-turbo8-dev \
        libjpeg8-dev \
        libltdl-dev \
        libncurses-dev \
        libncurses5-dev \
        libnspr4-dev \
        libnss3-dev \
        libp11-kit-dev \
        libpython3-dev \
        libpython3.8-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libstdc++-8-dev \
        libtasn1-6-dev \
        linux-libc-dev \
        manpages-dev \
        nettle-dev \
        python3-dev \
        python3.8-dev \
        zlib1g-dev \
        # general purpose
        fakeroot \
        fakechroot \
        xz-utils \
        vim \
        net-tools \
        git \
        gawk \
        telnet \
        #python \
        #python-pip \
        #python-dev \
        #python-virtualenv \
        #virtualenv \
        python3 \
        python3-pip \
        python3-venv \
        python3.8-venv \
        python3-numpy \
        nodejs \
        nginx \
        tigervnc-standalone-server \
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
        gettext \
        firefox \
        vlc \
        leafpad \
        file-roller \
        transmission \
        evince \
        lubuntu-core \
        golang-go \
        ffmpeg \
        openjdk-8-jdk \
        cabextract \
        xdg-user-dirs-gtk \
        chromium-browser \
        gpicview \
        # for kazam
        python3-xlib \
        python3-cairo \
        gir1.2-gudev-1.0 \
        kazam \
        && \
    echo 1234 | sudo -S git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    echo 1234 | sudo -S git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    wget https://github.com/novnc/websockify/raw/master/websockify/websocket.py && \
    wget https://github.com/chantzish/python-dewebsockify/raw/master/dewebsockify.py && \
    echo 1234 | sudo -S sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config && \
    echo 1234 | sudo -S sed -i 's/NotShowIn=/NotShowIn=LXDE;/' /etc/xdg/autostart/update-notifier.desktop && \
    #echo 1234 | sudo -S sed -i 's/\[Desktop Entry\]/[Desktop Entry]\nNotShowIn=LXDE;/' /etc/xdg/autostart/xdg-user-dirs.desktop && \
    echo 1234 | sudo -S sed -i 's/NotShowIn=/NotShowIn=LXDE;/' /etc/xdg/autostart/nm-applet.desktop && \
    (echo 1234 | sudo -S sed -i 's/assistive_technologies=org.GNOME.Accessibility.AtkWrapper/#assistive_technologies=org.GNOME.Accessibility.AtkWrapper/' /etc/java-8-openjdk/accessibility.properties || true) && \
    echo 1234 | sudo -S sed -i 's/load-module module-udev-detect/#load-module module-udev-detect/' /etc/pulse/default.pa && \
    echo 1234 | sudo -S sed -i 's/load-module module-detect/#load-module module-detect/' /etc/pulse/default.pa && \
    echo 1234 | sudo -S sed -i 's/load-module module-bluetooth-discover/#load-module module-bluetooth-discover/' /etc/pulse/default.pa && \
    echo 1234 | sudo -S sed -i 's/load-module module-bluetooth-policy/#load-module module-bluetooth-policy/' /etc/pulse/default.pa && \
    echo 1234 | sudo -S sed -i 's/#load-module module-native-protocol-tcp/load-module module-native-protocol-tcp auth-anonymous=1/' /etc/pulse/default.pa && \
    echo KexAlgorithms +diffie-hellman-group1-sha1 | sudo tee -a /etc/ssh/sshd_config && \
    echo "#HostKeyAlgorithms +ssh-dss" | sudo tee -a /etc/ssh/sshd_config && \
    echo "#MACs +hmac-sha1" | sudo tee -a /etc/ssh/sshd_config && \
    echo Ciphers +aes128-cbc | sudo tee -a /etc/ssh/sshd_config && \
    echo 1234 | sudo -S sed -i 's/#Port 22/Port 2200/' /etc/ssh/sshd_config && \
    echo 1234 | sudo -S sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
    echo 1234 | sudo -S mkdir -p /run/sshd && \
    if [ ! -d ".ssh" ]; then mkdir -p .ssh; fi && \
    chmod 700 ~/.ssh && \
    if [ ! -d ".vnc" ]; then mkdir -p .vnc; fi && \
    chmod 700 ~/.vnc && \
    if [ ! -d ".local/bin" ]; then mkdir -p .local/bin; fi && \
    #wget -q -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/ && \
    echo 1234 | sudo -S ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop && \
    echo 1234 | sudo -S chown -R 1000:1000 /opt && \
    echo 1234 | sudo -S chmod 755 -R /opt && \
    mkdir .gdrive && \
    #go get github.com/prasmussen/gdrive && \
    git clone https://github.com/chantzish/dewebsockify.git && \
    cd dewebsockify && \
    npm install && \
    cd .. && \
    echo 1234 | sudo -S rm /var/lib/dpkg/statoverride && \
    sudo sed -i 's/worker_processes .*;/worker_processes 1;/' /etc/nginx/nginx.conf && \
    sudo sed -i 's/user www-data;//' /etc/nginx/nginx.conf && \
    echo 1234 | sudo -S mkdir /tmp/.X11-unix && \
    echo 1234 | sudo -S chmod 1777 /tmp/.X11-unix && \
    echo 1234 | sudo -S sed -i 's/Exec=chromium-browser/Exec=chromium-browser --disable-dev-shm-usage --no-sandbox/' /usr/share/applications/chromium-browser.desktop && \
    echo 1234 | sudo -S xdg-settings set default-web-browser chromium-browser.desktop && \
    echo '#!/bin/sh\nexec /usr/bin/chromium-browser --disable-dev-shm-usage --no-sandbox "$@"' | sudo tee /usr/local/bin/chromium-browser && \
    echo 1234 | sudo -S chmod +x /usr/local/bin/chromium-browser && \
    echo 1234 | sudo -S update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/local/bin/chromium-browser 100 && \
    echo 1234 | sudo -S sed -i 's:#!/bin/sh:#!/bin/sh\nunset DBUS_SESSION_BUS_ADDRESS:' /usr/bin/xdg-open
CMD /home/user/launch-gui.sh & /home/user/launch.sh 
