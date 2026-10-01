#!/bin/bash
set -e
echo "Managing devices.."

# patch script with docker vendor MAC prefix
sed -i "/declare -A VENDORS$/aVENDORS['02:42:ac:']=\"docker\"" /lib/udev/init-net-rules.sh

# generate udev rules for networking (allow it to fail gracefully in docker if needed)
bash /lib/udev/init-net-rules.sh || true

# ensure the file exists to prevent 'cat' from crashing the build
if [ ! -f /etc/udev/rules.d/70-persistent-net.rules ]; then
    echo "Creating fallback persistent-net.rules for Docker environment..."
    mkdir -p /etc/udev/rules.d
    echo '# Fallback dummy rule for Docker' > /etc/udev/rules.d/70-persistent-net.rules
fi

# inspect generated
cat /etc/udev/rules.d/70-persistent-net.rules
