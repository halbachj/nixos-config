{ pkgs, ... }:
{
  services.udev.packages = [ pkgs.libdivecomputer ];
}
