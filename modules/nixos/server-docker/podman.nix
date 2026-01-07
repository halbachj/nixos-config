{ pkgs, lib, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  security.unprivilegedUsernsClone = true;

  environment.systemPackages = with pkgs; [
    distrobox
    podman
  ];
}
