#!/bin/bash
set -e

# inject memory size
if [ -n "$EXIST_MEMORY" ]; then
    sed -i "s/Xmx%{MAX_MEMORY}m/Xmx${EXIST_MEMORY}m/g" /opt/exist/bin/functions.d/eXist-settings.sh
else
    sed -i "s/Xmx%{MAX_MEMORY}m/Xmx512m/g" /opt/exist/bin/functions.d/eXist-settings.sh
fi

# catch missing password
if [ -n "$EXIST_ADMIN_PASSWORD" ]; then
# inject password
/opt/exist/bin/client.sh -l -s -u admin -P \$adminPasswd << EOF 
passwd admin
${EXIST_ADMIN_PASSWORD}
${EXIST_ADMIN_PASSWORD}
quit
EOF
fi

# lets start exist...
exec /opt/exist/bin/startup.sh
