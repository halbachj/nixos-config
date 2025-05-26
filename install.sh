#!/usr/bin/env bash
set -euo pipefail

# --- VARIABLES ---
REPO="https://github.com/halbachj/nixos-config.git"
REPO_DIR="./nixos-config"
MNT="/mnt"
TMP="/tmp/nixos-install"

# --- SCRIPT ---

# Clone repo
git clone -b "feat/install-script" "$REPO" "$REPO_DIR"
cd $REPO_DIR

# Ask for hostname
read -rp "Enter hostname for new system: " hostname
host_path="hosts/$hostname"

# Check if host already exists
if [ ! -f "$host_path" ]; then
  echo "[*] No disko config found for $hostname. Creating a minimal one..."

  # Create host structure
  mkdir -p "$host_path"
  nixos-generate-config --root "$TMP"
  cp "$TMP/etc/nixos/hardware-configuration.nix" "hosts/$hostname/hardware-configuration.nix"

  # Generate minimal configuration
  cat > "$host_path/configuration.nix" <<EOF
{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/disko.nix
  ];

  networking.hostName = "$hostname";
}
EOF

  echo "[✔] Created base configuration at $host_path"
  echo
fi

# Ask for disk
read -rp "Enter target disk device (e.g. /dev/sda or /dev/nvme0n1): " disk

# Confirm the disk exists
if [ ! -b "$disk" ]; then
  echo "[⚠] Device '$disk' not found or not a block device"
  exit 1
fi

# Confirm destructive action
read -rp "[⚠] This will erase all data on $disk. Are you sure? (yes/no): " confirm
if [[ "$confirm" != "yes" ]]; then
  echo "[X] Aborted."
  exit 1
fi


# Run disko-install
echo "[*] Running disko-install..."
nix run github:nix-community/disko/latest#disko-install -- --flake "${REPO_DIR}#$hostname" --disk main "$disk" --write-efi-boot-entries

echo "[✔] FInished install..."
