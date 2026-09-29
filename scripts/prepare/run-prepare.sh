#!/bin/bash
set -e

# Find the directory of this script, then source common.sh from one level up
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

echo "Preparing environment.."

# Download toolchain
run_step /tools/3.1-download-tools.sh

# Build toolchain
run_step /tools/5.4-make-binutils.sh
run_step /tools/5.5-make-gcc.sh
run_step /tools/5.6-make-linux-api-headers.sh
run_step /tools/5.7-make-glibc.sh
run_step /tools/5.8-make-libstdc.sh
run_step /tools/5.9-make-binutils.sh
run_step /tools/5.10-make-gcc.sh
run_step /tools/5.11-make-tcl.sh
run_step /tools/5.12-make-expect.sh
run_step /tools/5.13-make-dejagnu.sh
run_step /tools/5.14-make-m4.sh
run_step /tools/5.15-make-ncurses.sh
run_step /tools/5.16-make-bash.sh
run_step /tools/5.17-make-bison.sh
run_step /tools/5.18-make-bzip2.sh
run_step /tools/5.19-make-coreutils.sh
run_step /tools/5.20-make-diffutils.sh
run_step /tools/5.21-make-file.sh
run_step /tools/5.22-make-findutils.sh
run_step /tools/5.23-make-gawk.sh
run_step /tools/5.24-make-gettext.sh
run_step /tools/5.25-make-grep.sh
run_step /tools/5.26-make-gzip.sh
run_step /tools/5.27-make-make.sh
run_step /tools/5.28-make-patch.sh
run_step /tools/5.29-make-perl.sh
run_step /tools/5.30-make-sed.sh
run_step /tools/5.31-make-tar.sh
run_step /tools/5.32-make-texinfo.sh
run_step /tools/5.33-make-util-linux.sh
run_step /tools/5.34-make-xz.sh
run_step /tools/5.35-strip.sh