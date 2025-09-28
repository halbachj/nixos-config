{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    wl-clipboard-x11
    mako # notification system developed by swaywm maintainer # TODO move to sway config
    waypipe
  ];

  services.gnome.gnome-keyring.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = "wlr";
      };
    };
    wlr.enable = true; # adds pkgs.xdg-desktop-portal-wlr to extraPortals
    wlr.settings.screencast = {
      output_name = "eDP-1";
      chooser_type = "simple";
      chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk # gtk portal needed to make gtk apps happy
    ];
  };

  #services.xserver.enable = true;
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = false;
  #programs.regreet.enable = true;
  #programs.gtkgreet.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  security.pam.loginLimits = [
    { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
  ];

  #environment.etc."sway-session.desktop".text = ''
  #[Desktop Entry]
  #Name=Sway
  #Comment=An i3-compatible Wayland compositor
  #Exec=sway
  #Type=Application
  #DesktopNames=Sway
  #''; 

}
