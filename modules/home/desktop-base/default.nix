# SPDX-FileCopyrightText: 2024 2024
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darragh, who showed me NixOS

{ ... }:
{
  imports = [
    ./ghostty.nix
    ./anvim.nix
    ./mozilla.nix
                #./browser.nix
  ];
}

