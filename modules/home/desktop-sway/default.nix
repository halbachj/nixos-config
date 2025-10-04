{ config, osConfig, ... }:
{
  imports = [
    ./sway2.nix
    ./i3status-rs.nix
    #./swayidle.nix
    #./rofi.nix.bak
    ./rofi
  ];
}
