{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  powerManagement.cpuFreqGovernor = "performance";
  services.blueman.enable = true;
  #hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

}
