{ pkgs, lib, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 5d --keep 4";
    };
    flake = "/home/twostone/nixos-config";
  };
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}

