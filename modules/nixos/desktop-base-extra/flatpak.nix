{ pkgs, ... }:
{
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    flatpak
    xdg-desktop-portal
    xdg-desktop-portal-gtk # GTK desktop; use xdg-desktop-portal-kde on KDE
  ];
}
