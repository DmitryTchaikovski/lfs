#!/bin/bash
set -e
echo "Continue with chroot environment.."

# SKIP remove the "I have no name!" promp

# Find the directory of this script, then source common.sh from one level up
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# exec /tools/bin/bash --login +h

# build toolchain
run_step /tools/6.5-create-directories.sh
run_step /tools/6.6-create-essentials.sh
run_step /tools/6.7-make-linux-api-headers.sh
run_step /tools/6.8-make-man-pages.sh
run_step /tools/6.9-make-glibc.sh
run_step /tools/6.10-adjust-toolchain.sh
run_step /tools/6.11-make-zlib.sh
run_step /tools/6.12-make-file.sh
run_step /tools/6.13-make-readline.sh
run_step /tools/6.14-make-m4.sh
run_step /tools/6.15-make-bc.sh
run_step /tools/6.16-make-binutils.sh
run_step /tools/6.17-make-gmp.sh
run_step /tools/6.18-make-mpfr.sh
run_step /tools/6.19-make-mpc.sh
run_step /tools/6.20-make-gcc.sh
run_step /tools/6.21-make-bzip2.sh
run_step /tools/6.22-make-pkg-config.sh
run_step /tools/6.23-make-ncurses.sh
run_step /tools/6.24-make-attr.sh
run_step /tools/6.25-make-acl.sh
run_step /tools/6.26-make-libcap.sh
run_step /tools/6.27-make-sed.sh
run_step /tools/6.28-make-shadow.sh
run_step /tools/6.29-make-psmisc.sh
run_step /tools/6.30-make-iana-etc.sh
run_step /tools/6.31-make-bison.sh
run_step /tools/6.32-make-flex.sh
run_step /tools/6.33-make-grep.sh
run_step /tools/6.34-make-bash.sh

# SKIP switching to built bash
#exec /bin/bash --login +h

run_step /tools/6.35-make-libtool.sh
run_step /tools/6.36-make-gdbm.sh
run_step /tools/6.37-make-gperf.sh
run_step /tools/6.38-make-expat.sh
run_step /tools/6.39-make-inetutils.sh
run_step /tools/6.40-make-perl.sh
run_step /tools/6.41-make-xml-parser.sh
run_step /tools/6.42-make-intltool.sh
run_step /tools/6.43-make-autoconf.sh
run_step /tools/6.44-make-automake.sh
run_step /tools/6.45-make-xz.sh
run_step /tools/6.46-make-kmod.sh
run_step /tools/6.47-make-gettext.sh
run_step /tools/6.48-make-libelf.sh
run_step /tools/6.49-make-libffi.sh
run_step /tools/6.50-make-openssl.sh
run_step /tools/6.51-make-python.sh
run_step /tools/6.52-make-ninja.sh
run_step /tools/6.53-make-meson.sh
run_step /tools/6.54-make-procps-ng.sh
run_step /tools/6.55-make-e2fsprogs.sh
run_step /tools/6.56-make-coreutils.sh
run_step /tools/6.57-make-check.sh
run_step /tools/6.58-make-diffutils.sh
run_step /tools/6.59-make-gawk.sh
run_step /tools/6.60-make-findutils.sh
run_step /tools/6.61-make-groff.sh
run_step /tools/6.62-make-grub.sh
run_step /tools/6.63-make-less.sh
run_step /tools/6.64-make-gzip.sh
run_step /tools/6.65-make-iproute2.sh
run_step /tools/6.66-make-kbd.sh
run_step /tools/6.67-make-libpipeline.sh
run_step /tools/6.68-make-make.sh
run_step /tools/6.69-make-patch.sh
run_step /tools/6.70-make-sysklogd.sh
run_step /tools/6.71-make-sysvinit.sh
run_step /tools/6.72-make-eudev.sh
run_step /tools/6.73-make-util-linux.sh
run_step /tools/6.74-make-man-db.sh
run_step /tools/6.75-make-tar.sh
run_step /tools/6.76-make-texinfo.sh
run_step /tools/6.77-make-vim.sh
run_step /tools/6.79-strip.sh
run_step /tools/6.80-clean.sh

exit
