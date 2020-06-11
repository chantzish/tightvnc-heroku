#!/usr/bin/bash

echo -e '#!/usr/bin/bash\n\nexit 0'> /usr/sbin/groupadd 
chmod +x /usr/sbin/groupadd
echo -e '#!/usr/bin/bash\n\nexit 0'> /usr/sbin/adduser
chmod +x /usr/sbin/adduser
echo -e '#!/usr/bin/bash\n\nexit 0'> /usr/sbin/usermod
chmod +x /usr/sbin/usermod
echo -e '#!/usr/bin/bash\n\nexit 0'> /usr/bin/chown
chmod +x /usr/bin/chown
