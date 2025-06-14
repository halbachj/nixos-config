{ pkgs, lib, ... }:
{
  programs.nh = {
    enable = true;
    flake = "/home/twostone/nixos-config";
  };
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}

