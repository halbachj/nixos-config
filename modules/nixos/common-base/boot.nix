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
  };
in
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = systems;
    loader = {
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
        editor = false;
      };
    };
    initrd = {
                        #systemd.enable = lib.mkDefault true;
      supportedFilesystems = systems;
    };
  };
}

