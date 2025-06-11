{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  services.blueman.enable = true;
  #hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };
}
