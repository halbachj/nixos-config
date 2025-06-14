# SPDX-FileCopyrightText: 2024 2024
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darragh, who showed me NixOS
# https://codeberg.org/delliott/nixos-config

{ pkgs, lib, ... }:
{
  # Much styling is done in theming
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      nerd-fonts.symbols-only
      # These are all required for full noto support
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-lgc-plus
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
    ];
    enableGhostscriptFonts = false;
    fontDir.enable = lib.mkForce false;
    fontconfig = {
      enable = true;
      allowType1 = false;
      allowBitmaps = false;
      useEmbeddedBitmaps = false;
      defaultFonts =
        let
          fallbacks = [
            "Symbols Nerd Font"
          ];
        in
        lib.attrsets.genAttrs [
          "serif"
          "sansSerif"
          "monospace"
          "emoji"
        ] (_name: fallbacks);
    };
  };
}

