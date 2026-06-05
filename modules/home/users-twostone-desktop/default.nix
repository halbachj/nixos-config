# SPDX-FileCopyrightText: 2025 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darragh, who showed me NixOS

{ ... }:
{
  xdg.autostart.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
      "message/rfc822" = [ "thunderbird.desktop" ];
      "x-scheme-handler/mid" = [ "thunderbird.desktop" ];
      "x-scheme-handler/discord" = [ "legcord.desktop" ];
      "x-scheme-handler/mw-matlabconnector" = [ "mw-matlabconnector.desktop" ];
      "x-scheme-handler/mw-simulink" = [ "mw-simulink.desktop" ];
      "x-scheme-handler/mw-matlab" = [ "mw-matlab.desktop" ];
      "image/apng" = [ "feh.desktop" ];
      "image/avif" = [ "feh.desktop" ];
      "image/bmp" = [ "feh.desktop" ];
      "image/gif" = [ "feh.desktop" ];
      "image/jpeg" = [ "feh.desktop" ];
      "image/png" = [ "feh.desktop" ];
      "image/svg+xml" = [ "feh.desktop" ];
      "image/tiff" = [ "feh.desktop" ];
      "image/webp" = [ "feh.desktop" ];
    };
  };

  imports = [
    ./email.nix
    ./ausweis.nix
    ./keepassxc.nix
  ];
}
