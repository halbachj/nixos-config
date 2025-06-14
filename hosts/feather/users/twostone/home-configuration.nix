# SPDX-FileCopyrightText: 2025 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darragh, who showed me NixOS

{
  flake,
  inputs,
  ...
}:
{
  imports = [
    flake.homeModules.hostname
    flake.homeModules.common-base
    flake.homeModules.desktop-base
    flake.homeModules.desktop-base-extra
    flake.homeModules.desktop-sway

    # User specific
    flake.homeModules.users-twostone-common
    flake.homeModules.users-twostone-desktop
  ];
  home.stateVersion = "25.05";
  custom.hostname = "feather";

}

