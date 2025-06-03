# SPDX-FileCopyrightText: 2024 2024
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy from Darragh, who showed me NixOS
# https://codeberg.org/delliott/nixos-config

{ pkgs, lib, ... }:
{
  # Select internationalisation properties.
  i18n.defaultLocale = "en_IE.UTF-8";

  environment = {
    systemPackages = with pkgs; [
      helix
      git
    ];
    variables = {
      VISUAL = "hx";
      EDITOR = "hx";
    };
    defaultPackages = with pkgs; [ rsync ];
  };

  # More modern user management
  services.userborn.enable = true;
  users.mutableUsers = false;
  
  services = {};
}

