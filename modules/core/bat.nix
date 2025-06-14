{ pkgs, userSettings, ... }:
{
  environment.systemPackages = with pkgs; [
    bat
  ];
}
