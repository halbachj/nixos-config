# SPDX-FileCopyrightText: 2024 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darragh, who showed me NixOS
# https://codeberg.org/delliott/nixos-config

{ ... }:
{
  imports = [
    ./flatpak.nix
    ./wine.nix
    ./matlab.nix
    ./misc.nix
    ./openvpn.nix
  ];
}

