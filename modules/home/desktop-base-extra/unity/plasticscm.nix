{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    plasticscm-client-gui
  ];
}
