# SPDX-FileCopyrightText: 2024 2024
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy from Darragh, who showed me NixOS
# https://codeberg.org/delliott/nixos-config

{ pkgs, lib, ... }:
{
  # Select internationalisation properties.
  #i18n.defaultLocale = "de_DE.UTF-8";
  i18n.defaultLocale = "en_US.UTF-8";

    # Optionally
  i18n.extraLocaleSettings = {
    # LC_ALL = "en_US.UTF-8"; # This overrides all other LC_* settings.
    LC_CTYPE = "en_US.UTF8";
    LC_ADDRESS = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_COLLATE = "en_US.UTF-8";
  };

  environment = {
    systemPackages = with pkgs; [
      #anvim
      bat
      wget
      git
      btop
      groff
      cp210x-program
      nix-search-cli
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

  services = {
    locate.enable = true; # for nix-locate and pay-respects
  };
}
