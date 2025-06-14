#!/usr/bin/env bash
set -euo pipefail

### User-defined variables ###
GITHUB_REPO="https://github.com/halbachj/nixos-config"
HOSTNAME="laptop"               # Must match flake host name
TARGET_DISK="/dev/sda"         # Change to e.g. /dev/nvme0n1
TEMP_DIR="/mnt/etc/nixos"
################################

echo "[*] Installing tools..."
nix-shell -p git nixFlakes disko --run "true"

echo "[*] Cloning config from GitHub..."
mkdir -p "$TEMP_DIR"
git clone "$GITHUB_REPO" "$TEMP_DIR"

echo "[*] Applying Disko configuration for $HOSTNAME..."
nix run "$TEMP_DIR#diskoConfigurations.${HOSTNAME}.apply" -- --arg disk "\"${TARGET_DISK}\""

echo "[*] Mounting root..."
# Disko should have done this, but we make sure:
mountpoint -q /mnt || mount /dev/mapper/cryptroot /mnt

echo "[*] Generating hardware config..."
nixos-generate-config --root /mnt
mv /mnt/etc/nixos/hardware-configuration.nix "$TEMP_DIR/hosts/${HOSTNAME}/hardware.nix"

echo "[*] Installing NixOS from flake..."
nixos-install --flake "$TEMP_DIR#${HOSTNAME}"

echo "[✓] Done! You can now reboot."

