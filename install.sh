#!/usr/bin/env bash
set -euo pipefail

# === CONFIGURATION ===
REPO_URL="https://github.com/halbachj/nixos-config"
MOUNT=/mnt
REPO_DIR="$MOUNT/etc/nixos"
DISKO_CONFIG="hosts/common/disks.nix"

# === PROMPT FOR INPUT ===
read -rp "Enter hostname: " HOSTNAME
read -rp "Enter target disk (e.g. /dev/nvme0n1): " DISK

# === CLONE CONFIG ===
git clone "$REPO_URL" "$REPO_DIR"
cd "$REPO_DIR"

# === APPLY DISKO PARTITIONING ===
nix run github:nix-community/disko -- --mode disko "$DISKO_CONFIG" --arg device " \"$DISK\""

# === MOUNT CHECK ===
if ! mount | grep -q "$MOUNT"; then
  echo "Error: Disk not mounted to $MOUNT after disko layout."
  exit 1
fi

# === GENERATE HARDWARE CONFIG ===
nixos-generate-config --root "$MOUNT"

# === MOVE HARDWARE CONFIG ===
HOST_DIR="hosts/$HOSTNAME"
mkdir -p "$HOST_DIR"
mv "$MOUNT/etc/nixos/hardware-configuration.nix" "$HOST_DIR/"

# === WRITE configuration.nix ===
cat > "$HOST_DIR/configuration.nix" <<EOF
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/common.nix
    ../../$DISKO_CONFIG
    ./hardware-configuration.nix
  ];

  networking.hostName = "$HOSTNAME";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-partlabel/luks";

  system.stateVersion = "24.05";
}
EOF

# === INSTALL NIXOS ===
nixos-install --flake "$REPO_DIR#$HOSTNAME"

echo "✅ NixOS installed successfully with hostname: $HOSTNAME"
