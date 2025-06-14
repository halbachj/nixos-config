# SPDX-FileCopyrightText: 2024 2024
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy from Darragh, who showed me NixOS
# https://codeberg.org/delliott/nixos-config

{ pkgs, lib, ... }:
{
  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  environment = {
    systemPackages = with pkgs; [
                        #anvim
      bat
      wget
      git
    ];
    variables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
    defaultPackages = with pkgs; [ rsync ];
  };

  # More modern user management
  services.userborn.enable = true;
  users.mutableUsers = false;

  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true; # TODO: Replace with unfree predicate instead of allowing all

  services = {};
}

