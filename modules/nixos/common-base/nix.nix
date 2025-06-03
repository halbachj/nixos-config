# SPDX-FileCopyrightText: 2024 2024
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy from Darragh, who showed me NixOS
# https://codeberg.org/delliott/nixos-config

{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # Enable flakes and better nix commands
  nix = {
    enable = true;
    package = pkgs.lix;
    # Disable channels
    channel.enable = false;
    # Automatically collect garbage delete old generations/profiles
    # As bootloaders are set to keep 10 entries, garbage collection does not remove those last 10 entries.
    # So can still rollback safely
    gc = {
      automatic = true;
      dates = "weekly";
      # Keep only the last 10 generations
      # see https://nix.dev/manual/nix/2.25/command-ref/nix-collect-garbage
      # and https://nix.dev/manual/nix/2.25/command-ref/nix-env/delete-generations#generations-count
      # See https://github.com/NixOS/nix/pull/10426 for why I cant set a number of generations to keep
      options = "--delete-older-than 5d";
    };
    # Optimise the store every day
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    settings = {
      # Lock down access to nix
      allowed-users = [ ];
      trusted-users = [ "@wheel" ];
      # Take advantage of some shiny linux specific features
      auto-allocate-uids = true;
      use-cgroups = true;
      sandbox = true;
      # Put config and etc in sensible places
      use-xdg-base-directories = true;
      # More substitors to avoid building the world
      substituters = [
        # Normal
        "https://cache.nixos.org/"
        # For ca derivations
        "https://cache.ngi0.nixos.org/"
        # Self explanatory
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
      ];
      # Set the nix path in the nix config file to the above nix path
      nix-path = config.nix.nixPath;
      # Disable global registry and hence ensure maximum usage of local flake definitions and reduce system contact with internet
      flake-registry = "";
    };
  };
  # Emulate other versions of linux I expect to deploy configs on.
  # All systems supported by the flake, except for the current platform and all darwin platforms
  boot.binfmt.emulatedSystems = builtins.filter (
    item: item != pkgs.system && (lib.strings.hasSuffix "linux" item)
  ) (import inputs.systems);

  # Use the new shiny rebuild and switch scripts
  system = {
    switch = {
      enable = false;
      enableNg = true;
    };
    rebuild = {
      enableNg = true;
    };
  };
}

