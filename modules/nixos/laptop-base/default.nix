# SPDX-FileCopyrightText: 2024 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darragh, who showed me NixOS
# https://codeberg.org/delliott/nixos-config

{ ... }:
{
  imports = [
    ./power.nix
    ./backlight.nix
  ];
}

