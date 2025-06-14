{ pkgs, lib, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5"; #TODO should probably be synced with my limits set in boot
    };
    flake = "/home/twostone/nixos-config";
  };
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}

