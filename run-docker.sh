#!/bin/bash
set -euo pipefail

# Directory paths on host
#BUILD_DIR="$(pwd)/build-tmp"
OUTPUT_DIR="$(pwd)/output"
SOURCES_DIR="$(pwd)/sources"
#TOOLS_DIR="$(pwd)/tools"

echo "[+] Preparing host directories for inspection..."
mkdir -p  "$OUTPUT_DIR" "$SOURCES_DIR" # "$BUILD_DIR""$TOOLS_DIR"

# Allow container's non-root 'lfs' user to write to mounted volumes
chmod -R a+rwx "$OUTPUT_DIR" "$SOURCES_DIR" # "$BUILD_DIR" "$TOOLS_DIR"

# Clean up any lingering container
docker rm -f mylfs-my 2>/dev/null || true

echo "[+] Building Docker image..."
docker build --tag mylfs:8.2-my .

echo "[+] Running LFS build container with mounted artifacts..."
sudo docker run -it \
  --privileged \
  --device=/dev/loop-control \
  --device=/dev/loop0 \
  --device=/dev/loop1 \
  --device=/dev/loop2 \
  --device=/dev/loop3 \
  --ulimit stack=-1:-1 \
  --name mylfs-my \
  -v "$SOURCES_DIR:/mnt/lfs/sources" \
  -v "$OUTPUT_DIR:/output" \
  mylfs:8.2-my

 #-v "$BUILD_DIR:/tmp" \ # might be causing issues with assembler

echo "[+] Extracting final artifacts..."
# Attempt extraction from /output first, then fallback to /tmp or root if paths differ
if docker cp mylfs-my:/output/isolinux/ramdisk.img "$OUTPUT_DIR/" 2>/dev/null; then
  echo "[✓] Bootable image copied to $OUTPUT_DIR/ramdisk.img"
elif docker cp mylfs-my:/tmp/lfs.iso "$OUTPUT_DIR/" 2>/dev/null; then
  echo "[✓] ISO copied to $OUTPUT_DIR/lfs.iso"
fi

echo "[✓] Build finished. "