{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ausweisapp
  ];
}
