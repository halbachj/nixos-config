# SPDX-FileCopyrightText: 2024 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darragh, who showed me NixOS

_: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "twostone";
    homeDirectory = "/home/twostone";
    sessionVariables = { };
  };

  programs.git = {
    userEmail = "johannes@halbachnet.de";
    userName = "Johannes Halbach";
  };
}
