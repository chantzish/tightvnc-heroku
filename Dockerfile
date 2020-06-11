FROM ubuntu
RUN apt update && apt install -y sudo && useradd -u 1000 -U -G adm,cdrom,sudo,dip,plugdev -m user && yes "1234" | passwd user
USER user
WORKDIR /home/user
ENV LANG=en_IL
#ARG GIT_CONF
RUN echo 1234 | sudo -S apt update && \
    #???????????????????????????
    #printf "%s" "$GIT_CONF" > .gitconfig && \
    #env && \
    #???????????????????????????
    echo "Set disable_coredump false" | sudo tee /etc/sudo.conf && \
    sudo DEBIAN_FRONTEND=noninteractive apt install -y keyboard-configuration tzdata && \
    #echo -e "tzdata	tzdata/Zones/Asia	select	Jerusalem\ntzdata	tzdata/Zones/Indian	select	\ntzdata	tzdata/Zones/Africa	select	\ntzdata	tzdata/Zones/Pacific	select	\ntzdata	tzdata/Zones/Antarctica	select	\ntzdata	tzdata/Zones/US	select	\ntzdata	tzdata/Zones/SystemV	select	\ntzdata	tzdata/Areas	select	Asia\ntzdata	tzdata/Zones/Arctic	select	\ntzdata	tzdata/Zones/Australia	select	\ntzdata	tzdata/Zones/America	select	\ntzdata	tzdata/Zones/Europe	select	\ntzdata	tzdata/Zones/Etc	select	UTC\ntzdata	tzdata/Zones/Atlantic	select	\n" | sudo debconf-set-selections && \
    sudo apt install -y whiptail apt-utils libterm-readline-gnu-perl locales apt-transport-https curl wget gnupg  software-properties-common && \
    echo "deb https://cli-assets.heroku.com/apt ./" | sudo tee /etc/apt/sources.list.d/heroku.list && \
    curl https://cli-assets.heroku.com/apt/release.key | sudo apt-key add - && \
    wget https://zoom.us/client/latest/zoom_amd64.deb && \
    #wget https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megacmd-xUbuntu_18.04_amd64.deb && \
    #wget https://mega.nz/linux/MEGAsync/xUbuntu_19.10/amd64/megacmd-xUbuntu_19.10_amd64.deb && \
    wget https://mega.nz/linux/MEGAsync/xUbuntu_20.04/amd64/megacmd-xUbuntu_20.04_amd64.deb && \
    sudo locale-gen en_IL en_US.UTF-8 && \
    sudo update-locale LANG=en_IL && \
    sudo dpkg-reconfigure --frontend=noninteractive locales && \
    echo '# KEYBOARD CONFIGURATION FILE\n\n# Consult the keyboard(5) manual page.\n\nXKBMODEL="pc105"\nXKBLAYOUT="us,il"\nXKBVARIANT=","\nXKBOPTIONS="grp:alt_shift_toggle,grp_led:scroll"\n\nBACKSPACE="guess"' | sudo tee /etc/default/keyboard && \
    echo "Asia/Jerusalem" | sudo tee /etc/timezone && \
    sudo ln -snf /usr/share/zoneinfo/Asia/Jerusalem /etc/localtime && \
    sudo dpkg-reconfigure --frontend=noninteractive keyboard-configuration tzdata && \
    sudo dpkg --add-architecture i386 && \
    wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
    sudo apt-key add winehq.key && \
    #sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' && \
    #sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ eoan main' && \
    sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' && \
    #sudo add-apt-repository ppa:cybermax-dexter/sdl2-backport && \
    sudo apt-add-repository universe && \
    sudo apt update && \
    #sudo apt install -y libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386 && \
    sudo apt install -y --install-recommends winehq-devel && \
    sudo apt install -y \
        heroku && \
    #    libc6:i386 \
    #    libstdc++6:i386 \
        #libssl1.0.0:i386 \
    #    libx11-6:i386 \
    #    libncurses5:i386 \
    #    zlib1g:i386 \
    #    libgtk2.0-0:i386 \
    #    libsdl1.2debian:i386 \
    #    libgtk-3-0:i386 \
#???????
    #    bzip2 \
    #    libbz2-1.0 \
    #    libbz2-1.0:i386 \
    #    libdb5.3:i386 \
    #    libexpat1:i386 \
        #libffi6:i386 \
    #    libgpm2:i386 \
    #    libncursesw5:i386 \
        #libpython-stdlib:i386 \
    #    libpython2.7-minimal:i386 \
    #    libpython2.7-stdlib:i386 && \
    sudo DEBIAN_FRONTEND=noninteractive apt install -y lubuntu-desktop && \
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
        #xserver-xorg-video-dummy \
        #x11vnc \
        tigervnc-standalone-server vlc \
        #megatools \
        less \
        socat \
        #vde2 \
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
        #leafpad \
        file-roller \
        transmission \
        evince \
        #lubuntu-core \
        golang-go \
        tint2 \
        ffmpeg \
        #expect-dev \
        #default-jdk \
        #libssl-dev libffi-dev python-dev python3-dev ncurses-dev \
        #python-pip \
        python-pip-whl \
        python3-pip virtualenv \
        openjdk-8-jdk \
        fonts-liberation libappindicator1 \
        qemu-user-static \
        #debootstrap \
        #schroot \
        #ccache automake flex lzop bison gperf build-essential zip curl zlib1g-dev zlib1g-dev:i386 \
        #g++-multilib \
        #python-networkx \
        python3-networkx \
        #libxml2-utils bzip2 libbz2-dev libbz2-1.0 libghc-bzlib-dev \
        #squashfs-tools pngcrush schedtool dpkg-dev liblz4-tool make optipng maven libssl-dev pwgen \
        #libswitch-perl policycoreutils minicom libxml-sax-base-perl libxml-simple-perl bc libc6-dev-i386 \
        #lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev xsltproc\
        unzip \
        cabextract \
        #./megacmd-xUbuntu_18.04_amd64.deb \
        #./megacmd-xUbuntu_19.10_amd64.deb \
        ./megacmd-xUbuntu_20.04_amd64.deb \
        ./zoom_amd64.deb \
        kazam \
        # for debconf-get-selections for not interactive apt/dpkg install
        debconf-utils \
        winbind \
        samba \
        thunderbird \
        #cgroup-tools \
        && \
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
    #echo 1234 | sudo -S rm /etc/xdg/autostart/update-notifier.desktop && \
    #sudo rm /etc/xdg/autostart/lxpolkit.desktop && \
    #sudo mv /usr/bin/lxpolkit /usr/bin/lxpolkit.ORIG && \
    #echo "NotShowIn=GNOME;Unity;LXDE;" | sudo tee -a /etc/xdg/autostart/light-locker.desktop && \
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
    #git clone --depth=1 https://github.com/MiCode/Xiaomi_Kernel_OpenSource.git -b cactus-p-oss cactus-p-oss && \
    #cd cactus-p-oss && \
    #git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 toolchain && \
    #cd toolchain && \
    #git checkout d8df6b5a187d49fce217569ad493cdb8554afc4e -b toolchain && \
    #sed -i 's/time.sleep(3)/#time.sleep(3)/' ./bin/arm-linux-androideabi-gcc && \
    #sed -i 's/time.sleep(3)/#time.sleep(3)/' ./bin/arm-linux-androideabi-g++ && \
    #cd .. && \
    #mkdir out && \
    #export ARCH=arm && \
    #export SUBARCH=arm && \
    #export CROSS_COMPILE=${PWD}/toolchain/bin/arm-linux-androideabi- && \
    #export DTC_EXT=dtc && \
    #sed -i 's:CONFIG_BUILD_ARM_DTB_OVERLAY_IMAGE_NAMES="cereus":CONFIG_BUILD_ARM_DTB_OVERLAY_IMAGE=y\nCONFIG_BUILD_ARM_DTB_OVERLAY_IMAGE_NAMES="cereus":' arch/arm/configs/cereus_defconfig && \
    #make O=out cereus_defconfig && \
    #make -j$(nproc) O=out 2>&1 | tee kernel.log && \
    #cd .. && \
    #mkdir dummy && cd dummy && \
    #wget https://github.com/giometti/linux_device_driver_development_cookbook/raw/master/chapter_02/module/Makefile && \
    #wget https://github.com/giometti/linux_device_driver_development_cookbook/raw/master/chapter_02/module/dummy-code.c && \
    #sed -i 's/ARCH ?= arm64\nCROSS_COMPILE ?= aarch64-linux-gnu/ARCH ?= arm/' Makefile && \
    #Make KERNEL_DIR=cactus-p-oss O=../cactus-p-oss/out && \
    #unset ARCH && \
    #unset SUBARCH && \
    #unset CROSS_COMPILE && \
    #unset DTC_EXT && \
    #cd .. && \
    #sudo curl https://storage.googleapis.com/git-repo-downloads/repo -o /bin/repo && \
    #sudo chmod a+x /bin/repo && \
    #mkdir aosp && cd aosp && \
    #repo init -u https://android.googlesource.com/platform/manifest -b android-9.0.0_r3 -q --depth 1 && \
    #repo sync -c -j$(nproc) -q --no-clone-bundle --no-tags && \
    #cd .. && \
    #mkdir studio-master-dev && \
    #cd studio-master-dev && \
    #repo init -u https://android.googlesource.com/platform/manifest -b studio-master-dev -q --depth 1 && \
    #repo sync -c -j$(nproc) -q --no-clone-bundle --no-tags && \
    #cd ..  && \
    sudo wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O /usr/local/sbin/winetricks && \
    sudo chmod +x /usr/local/sbin/winetricks && \
    mkdir -p ~/.cache/wine/ && \
    wget http://dl.winehq.org/wine/wine-mono/4.9.4/wine-mono-4.9.4.msi -O ~/.cache/wine/wine-mono-4.9.4.msi && \
    wget https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi -O ~/.cache/wine/wine-gecko-2.47.1-x86.msi && \
    wget https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi -O ~/.cache/wine/wine-gecko-2.47.1-x86_64.msi && \
    #WINEPREFIX=/home/user/.wine WINEARCH=win32 wine wineboot && \
    #winetricks win98 && \
    #wine wineboot && \
    wget http://download-hr.utorrent.com/track/beta/endpoint/utserver/os/linux-x64-ubuntu-13-04 -O utserver-linux-x64-ubuntu-13-04.tar.gz && \
    sudo tar xvf utserver-linux-x64-ubuntu-13-04.tar.gz -C /opt/ && \
    # sudo apt install libssl1.0.0 libssl-dev && \
    sudo ln -s /opt/utorrent-server-alpha-v3_3/utserver /usr/bin/utserver && \
    sudo sed -i 's/worker_processes auto/worker_processes 2/' /etc/nginx/nginx.conf && \
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
