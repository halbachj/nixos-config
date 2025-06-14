{ config, osConfig, ... }:
{
        imports = [
          ./sway2.nix
          ./i3status-rs.nix
          ./rofi.nix
];
}
