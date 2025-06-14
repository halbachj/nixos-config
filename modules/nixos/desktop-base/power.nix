# SPDX-FileCopyrightText: 2025 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darragh, who showed me NixOS
# https://codeberg.org/delliott/nixos-config

_: {
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
}

