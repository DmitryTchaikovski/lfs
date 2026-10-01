#!/bin/bash
set -e
echo "Continue with chroot environment.."

export STEP_LOG_FILE="/sources/step_build_times.log"
# Find the directory of this script, then source common.sh from one level up
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# configure system
run_step /tools/7.2-make-lfs-bootscripts.sh
run_step /tools/7.4-manage-devices.sh
run_step /tools/7.5-configure-network.sh
run_step /tools/7.6-configure-systemv.sh
run_step /tools/7.x-configure-bash.sh

# make system bootable
run_step /tools/8.2-create-fstab.sh
run_step /tools/8.3-make-linux-kernel.sh
run_step /tools/8.4-setup-grub.sh

# end
run_step /tools/9.1-the-end.sh

exit
