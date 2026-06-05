{
  config,
  lib,
  ...
}:
{
  users = {
    users.twostone = {
      isNormalUser = true;
      description = "twostone";
      linger = true;
      uid = 1000;
      extraGroups = [
        "wheel"
        "dialout"
        "video"
        "cdrom"
        "plugdev"
        "input"
      ]
      ++ lib.optionals config.networking.networkmanager.enable [ "networkmanager" ];

      name = "twostone";
    };
    groups.users.gid = 100;
  };
}
