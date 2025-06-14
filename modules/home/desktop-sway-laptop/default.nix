{ config, osConfig, ... }:
{
  imports = [
    ./sway.nix
    ./i3status-rs.nix
  ];
}
