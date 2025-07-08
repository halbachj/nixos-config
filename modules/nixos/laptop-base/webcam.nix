{ pkgs, ... }:
{
  services.uvcvideo.dynctrl.enable = true;
  services.uvcvideo.dynctrl.packages = [
    pkgs.tiscamera
  ];
}

