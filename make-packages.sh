#!/data/data/com.termux/files/usr/bin/bash

REPO_DIR="${1:-.}"
POOL_DIR="$REPO_DIR/pool"

mkdir -p "$POOL_DIR"

echo "[*] Scanning for .deb files outside of pool/..."
find "$REPO_DIR" -type f -name "*.deb" ! -path "$POOL_DIR/*" -exec mv -v {} "$POOL_DIR" \;

echo "[*] Generating Packages file..."
apt-ftparchive packages "$POOL_DIR" > "$REPO_DIR/Packages"

echo "[*] Compressing Packages.gz..."
gzip -kf "$REPO_DIR/Packages"

echo "[✓] Local repo built at: $REPO_DIR"
