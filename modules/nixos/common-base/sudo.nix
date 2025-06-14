# SPDX-FileCopyrightText: 2024 2024
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy from Darragh who showed me NixOS
# https://codeberg.org/delliott/nixos-config

_: {
  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };
  };
}

