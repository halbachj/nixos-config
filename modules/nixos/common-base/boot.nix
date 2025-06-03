# SPDX-FileCopyrightText: 2024 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy from Darragh who showed me NixOS
# https://codeberg.org/delliott/nixos-config

{ pkgs, lib, ... }:
{
  boot = {
    loader = {
      timeout = 5;

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      systemd-boot.enable = false;
      grub = {
        enable = lib.mkDefault true;
        useOSProber = true;
        efiSupport = true;
        #efiInstallAsRemovable = true; # Other wise /boot/EFI/BOOT/BOOTX64.EFI isn't generated.
        devices = [ "nodev" ];
        extraEntriesBeforeNixOS = true;
        extraEntries = ''
          menuentry "Reboot" {
            reboot
          }
          menuentry "Poweroff" {
            halt
          }
          '';
      };
    };
    supportedFilesystems = [ "ntfs" ];
    initrd = {
      systemd.enable = lib.mkDefault true;
      supportedFilesystems = [ "ext4" "ntfs" "btrfs" "fat32" ];
    };
  };
}

