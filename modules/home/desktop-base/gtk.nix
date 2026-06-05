{
  config,
  inputs,
  lib,
  pkgs,
  flake,
  ...
}:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "elementary-Xfce-dark";
      package = pkgs.elementary-xfce-icon-theme;
    };

    theme = {
      name = "zukitre-dark";
      package = pkgs.zuki-themes;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4 = {
      theme = config.gtk.theme;
      extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };
  };

}
