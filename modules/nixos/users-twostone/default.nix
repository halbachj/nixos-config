# SPDX-FileCopyrightText: 2024 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

# Curtesy to Darrag, who showed me NixOS

{ config, lib, ... }:
{

  users = {
    users.twostone = {
      isNormalUser = true;
      description = "twostone";
      linger = true;
      uid = 1000;
      extraGroups =
        [
          "wheel"
          "dialout"
          "video"
        ]
        ++ lib.optionals config.networking.networkmanager.enable [ "networkmanager" ];
      hashedPassword = "$6$eO9zT8YVzpR.Z1Eg$nnBg9ryZgmcXYzc9gdgEdWDFvSNgTysLo2HO0NGafk0RGi8PpyigVwtiwBTG1Z/0Rm9lWPTeLzbixLrdhkwsA/";

      name = "twostone"; # name/identifier
      #email = "johannes@halbachnet.de"; # email (used for certain configurations)
    };
    groups.users.gid = 100;
  };

}

