# SPDX-FileCopyrightText: 2025 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darragh, who showed me NixOS

{ lib, ... }:
{
  options.custom.hostname = lib.mkOption {
    type = lib.types.str;
    default = null;
    description = ''
      what is the hostname of the device?
    '';
  };
}

