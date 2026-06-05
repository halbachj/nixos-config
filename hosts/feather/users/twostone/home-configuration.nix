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
    flake.homeModules.desktop-sway-laptop

    flake.homeModules.games
    flake.homeModules.desktop-uni

    # User specific
    flake.homeModules.users-twostone-common
    flake.homeModules.users-twostone-desktop

    # Zen Browser Home Manager module
    inputs.zen-browser.homeModules.twilight
    
    # LaTeX terminal module
    flake.homeModules.latex-terminal
  ];
  
  programs.latex-terminal = {
    enable = true;
    fullSetup = true;
    blockFontSize = 10;
    inlineScaleFactor = 0.75;
    inlinePadding = 0.01;  # Slight padding
    blockPadding = 0.00;   # Slight padding
  };
  
  home.stateVersion = "25.05";
  custom.hostname = "feather";

}
