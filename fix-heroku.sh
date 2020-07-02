#!/usr/bin/bash

mv /usr/sbin/groupadd /usr/sbin/groupadd-old
echo -e '#!/usr/bin/bash\n\nexit 0'> /usr/sbin/groupadd 
chmod +x /usr/sbin/groupadd
mv /usr/sbin/adduser /usr/sbin/adduser-old
echo -e '#!/usr/bin/bash\n\nexit 0'> /usr/sbin/adduser
chmod +x /usr/sbin/adduser
mv /usr/sbin/usermod /usr/sbin/usermod-old
echo -e '#!/usr/bin/bash\n\nexit 0'> /usr/sbin/usermod
chmod +x /usr/sbin/usermod
mv /usr/bin/chown /usr/bin/chown-old
echo -e '#!/usr/bin/bash\n\nexit 0'> /usr/bin/chown
chmod +x /usr/bin/chown
#mv /usr/bin/winedbg /usr/bin/winedbg-old
#echo -e '#!/usr/bin/bash\n\nexit 0' > /usr/bin/winedbg
#chmod +x /usr/bin/winedbg
#mv /opt/wine-devel/bin/winedbg /opt/wine-devel/bin/winedbg-old
#echo -e '#!/usr/bin/bash\n\nexit 0' > /opt/wine-devel/bin/winedbg
#chmod +x /opt/wine-devel/bin/winedbg
