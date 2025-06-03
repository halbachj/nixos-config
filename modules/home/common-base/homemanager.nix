# SPDX-FileCopyrightText: 2024 2024
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darragh, who showed me NixOS

_: {
  programs.git = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

