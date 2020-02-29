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
    echo guacamole guacamole-tomcat/restart-server boolean true | sudo debconf-set-selections && \
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
        # for debconf-get-selections
        debconf-utils \
        guacamole tomcat8-user tomcat8-admin tomcat8-examples && \
    sudo /etc/init.d/guacd stop && \
    sudo /etc/init.d/tomcat8 stop && \
    sudo apt install -y openjdk-8-jdk && \
    echo -e 'appletviewer                   manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/appletviewer\nclhsdb                         manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/clhsdb\nextcheck                       manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/extcheck\nhsdb                           manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/hsdb\nidlj                           manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/idlj\njar                            manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jar\njarsigner                      manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jarsigner\njava                           manual   /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java\njavac                          manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/javac\njavadoc                        manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/javadoc\njavah                          manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/javah\njavap                          manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/javap\njcmd                           manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jcmd\njconsole                       manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jconsole\njdb                            manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jdb\njdeps                          manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jdeps\njexec                          manual   /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/jexec\njhat                           manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jhat\njinfo                          manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jinfo\njjs                            manual   /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/jjs\njmap                           manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jmap\njps                            manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jps\njrunscript                     manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jrunscript\njsadebugd                      manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jsadebugd\njstack                         manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jstack\njstat                          manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jstat\njstatd                         manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/jstatd\nkeytool                        manual   /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/keytool\nnative2ascii                   manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/native2ascii\norbd                           manual   /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/orbd\npack200                        manual   /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/pack200\npolicytool                     manual   /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/policytool\nrmic                           manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/rmic\nrmid                           manual   /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/rmid\nrmiregistry                    manual   /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/rmiregistry\nschemagen                      manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/schemagen\nserialver                      manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/serialver\nservertool                     manual   /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/servertool\ntnameserv                      manual   /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/tnameserv\nunpack200                      manual   /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/unpack200\nwsgen                          manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/wsgen\nwsimport                       manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/wsimport\nxjc                            manual   /usr/lib/jvm/java-8-openjdk-amd64/bin/xjc' | sudo update-alternatives --set-selections && \
    sudo sed -i 's/assistive_technologies=org.GNOME.Accessibility.AtkWrapper/#assistive_technologies=org.GNOME.Accessibility.AtkWrapper/' /etc/java-8-openjdk/accessibility.properties && \
    wget http://downloads.sourceforge.net/project/guacamole/current/binary/guacamole-0.9.9.war && \
    sudo sed -i 's:JDK_DIRS="/usr/lib/jvm/default-java":JDK_DIRS="/usr/lib/jvm/java-8-openjdk-amd64":' /etc/init.d/tomcat8 && \
    sudo rm /var/lib/tomcat8/conf/Catalina/localhost/guacamole.xml && \
    sudo mv guacamole-0.9.9.war /var/lib/tomcat8/webapps/guacamole.war && \
    #sudo /etc/init.d/tomcat8 start && \
    #sleep 30s && \
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
    #echo "NotShowIn=GNOME;Unity;LXDE;" | sudo tee -a /etc/xdg/autostart/light-locker.desktop && \    sudo sed -i 's/load-module module-udev-detect/#load-module module-udev-detect/' /etc/pulse/default.pa && \
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
    #sudo /etc/init.d/tomcat8 stop && \
    sudo rm /etc/dpkg/dpkg.cfg.d/excludes && \
    sudo rm /var/lib/dpkg/statoverride
COPY heroku.yml /home/user/heroku.yml
COPY xstartup /home/user/.vnc/xstartup
COPY nginx.template /home/user/nginx.template
COPY launch.sh /home/user/launch.sh
COPY launch-gui.sh /home/user/launch-gui.sh
COPY Dockerfile /home/user/Dockerfile
CMD /home/user/launch-gui.sh & /home/user/launch.sh 
