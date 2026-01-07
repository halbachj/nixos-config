{ pkgs, ... }:
{
  services = {
    udev.packages = [ pkgs.libdivecomputer ];
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        cnijfilter2
      ];
    };
  };
}
