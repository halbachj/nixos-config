# SPDX-FileCopyrightText: 2024 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darragh, who showed me NixOS

{ pkgs, ... }:
{
  home = {
    username = "twostone";
    homeDirectory = "/home/twostone";
    sessionVariables = { };
  };
  programs.git.settings.user = {
    email = "johannes@halbachnet.de";
    name = "Johannes Halbach";
  };

  #home.packages = [ pkgs.distant ];

  #systemd.user.services.distant-manager = {
  #  Unit = {
  #    Description = "distant manager";
  #  };
  #  Service = {
  #    ExecStart = "${pkgs.distant}/bin/distant manager listen --user";
  #    Restart = "on-failure";
  #  };
  #  Install = {
  #    WantedBy = [ "default.target" ];
  #  }; # Home-Manager syntax
  #};
}
