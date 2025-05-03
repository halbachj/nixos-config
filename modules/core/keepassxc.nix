{ pkgs, userSettings, ... }:
{
  environment.systemPackages = with pkgs; [
    keepassxc
  ];
}
