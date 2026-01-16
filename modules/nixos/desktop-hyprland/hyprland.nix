{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    wl-clipboard-x11
    mako
    waypipe
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = "hyprland";
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };
}
