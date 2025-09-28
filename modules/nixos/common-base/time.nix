{ pkgs, lib, ... }:
{
  services.timesyncd.enable = true;
  services.geoclue2 = {
    enable = true;
  };
}

