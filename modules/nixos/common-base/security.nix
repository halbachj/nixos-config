{ pkgs, lib, ... }:
{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  
  environment = {
    systemPackages = with pkgs; [
      yubikey-agent
      yubikey-manager
      gnupg
      bitwarden-cli
    ];
  };

}
