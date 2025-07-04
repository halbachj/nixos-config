# SPDX-FileCopyrightText: 2024 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy from Darragh who showed me NixOS
# https://codeberg.org/delliott/nixos-config

{ pkgs, lib, ... }:
let
  lim = 15;
  systems = {
    ext4 = true;
    fat32 = true;
    btrfs = true;
    zfs = false;
    ntfs = true;
  };
in
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = systems;
    loader = {
      timeout = 5;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = lib.mkDefault false;
        configurationLimit = lim;
      };
      generic-extlinux-compatible = {
        enable = lib.mkDefault false;
        configurationLimit = lim;
      };
      systemd-boot = {
        enable = lib.mkDefault true;
        configurationLimit = lim;
        editor = true; # TODO: remove needed for debug
      };
    };
    initrd = {
      systemd.enable = lib.mkDefault true;
      supportedFilesystems = systems;
      verbose = false; # Used for plymouth
    };

    plymouth = {
      enable = true;
      theme = "glowing";
        themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "glowing" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };
}

