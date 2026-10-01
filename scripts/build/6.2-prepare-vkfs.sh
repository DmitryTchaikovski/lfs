#!/bin/bash
echo "Preparing Virtual Kernel File Systems.."

# Find the directory of this script, then source common.sh from one level up
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

log_step_debug "Creating directories onto which the file systems will be mounted"

# create directories onto which the file systems will be mounted
mkdir -pv $LFS/{dev,proc,sys,run}

# create Initial Device Nodes
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3

# mount and populate /dev
mount -v --bind /dev $LFS/dev

# mount Virtual Kernel File Systems
mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

log_step_debug "DEBUG: Mounted Virtual Kernel File Systems onto $LFS"

