# SPDX-FileCopyrightText: 2024 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy from Darragh who showed me NixOS
# https://codeberg.org/delliott/nixos-config

{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking = {
    # Turn a bunch of stuff off originally, and then enable as needed.
    # Disable this stuff, as its handled either by network manager on desktops, or systemd networkd on servers
    dhcpcd.enable = false;
    useDHCP = false;
    # Dont try and convert networking settings to networkd.
    useNetworkd = false;
    nameservers = [
      # Quad9 with default setup
      # https://www.quad9.net/service/service-addresses-and-features
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
    ];
    wireless = {
      # wireless.enable enables wpa_supplicant, which I dont want
      enable = false;
      # Required for networkManager
      dbusControlled = true;
      iwd = {
        enable = true;
        # https://iwd.wiki.kernel.org/networkconfigurationsettings
        settings = {
          General = {
            AddressRandomization = "network";
          };
          Network = {
            EnableIPv6 = true;
            NameResolvingService = "systemd";
          };
          Settings = {
            AutoConnect = true;
            AlwaysRandomizeAddress = true;
          };
        };
      };
    };
    networkmanager = {
      enable = lib.mkDefault true;
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        macAddress = "random";
        scanRandMacAddress = true;
        # powersave = true; # Seems to cause frequent connection drops
      };
    };
  };
}
