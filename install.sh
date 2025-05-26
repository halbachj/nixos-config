#!/usr/bin/env bash
set -euo pipefail

### USER CONFIG ###
REPO_URL="https://github.com/halbachj/nixos-config"
DEFAULT_STATE_VERSION="24.05"
###################

read -p "Enter hostname: " HOSTNAME
read -p "Target disk (e.g. /dev/sda or /dev/nvme0n1): " TARGET_DISK

MNT="/mnt"
REPO_PATH="$MNT/etc/nixos"
HOST_PATH="hosts/${HOSTNAME}"
DISKO_PATH="disko-configs/${HOSTNAME}.nix"

echo "[*] Installing tools..."
nix-shell -p git disko --run "true"

echo "[*] Cloning flake repo..."
git clone "$REPO_URL" "$REPO_PATH"

cd "$REPO_PATH"

if [[ -f "$HOST_PATH/configuration.nix" && -f "$DISKO_PATH" ]]; then
  echo "[✓] Host configuration found for $HOSTNAME. Proceeding with install..."
else
  echo "[*] No config for $HOSTNAME found. Generating one..."

  mkdir -p "$HOST_PATH" disko-configs

  echo "[*] Creating disko config for $TARGET_DISK..."
  cat > "$DISKO_PATH" <<EOF
{
  disko.devices.disk.main = {
    type = "disk";
    device = "${TARGET_DISK}";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          size = "512M";
          type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
        luks = {
          size = "100%";
          content = {
            type = "luks";
            name = "crypted";
            #passwordFile = "/tmp/secret.key"; # Interactive
            settings = {
              allowDiscards = true;
              keyFile = "/tmp/secret.key";
            };
            #additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                # Disable automatic swap creation for now... 
                #"/swap" = {
                #  mountpoint = "/.swapvol";
                #  swap.swapfile.size = "20M";
                #};
              };
            };
          };
        };
      };
    };
  };
}
EOF

  echo "[*] Applying disko layout..."
  nix --extra-experimental-features run ".#diskoConfigurations.${HOSTNAME}.apply" -- --arg disk "\"${TARGET_DISK}\""

  echo "[*] Generating hardware configuration..."
  nixos-generate-config --root "$MNT"

  mv "$MNT/etc/nixos/hardware-configuration.nix" "$HOST_PATH/hardware.nix"
  mv "$MNT/etc/nixos/configuration.nix" "$HOST_PATH/configuration.nix"

  echo "[*] Patching configuration.nix to import disko..."
  sed -i "1i\
{ config, pkgs, ... }:\n" "$HOST_PATH/configuration.nix"
  sed -i "/imports = \[/a\  ../../disko-configs/${HOSTNAME}.nix" "$HOST_PATH/configuration.nix"
  sed -i "s/system.stateVersion = .*/system.stateVersion = \"${DEFAULT_STATE_VERSION}\";/" "$HOST_PATH/configuration.nix"

  echo "[✓] Config for $HOSTNAME created."
fi

echo "[*] Installing NixOS via flake..."
nixos-install --flake ".#${HOSTNAME}"

echo "[✓] Done installing $HOSTNAME!"
