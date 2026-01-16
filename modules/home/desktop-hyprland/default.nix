{ config, osConfig, ... }:
{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./hypridle.nix
    ./rofi
  ];
}
