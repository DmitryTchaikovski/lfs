set +h
umask 022
# Remove process stack limit for massive GCC files
ulimit -s unlimited
