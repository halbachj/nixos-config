{ pkgs, ... }:
{
  home.packages = [
    pkgs.rofi
  ];
  xdg.configFile."rofi/config.rasi".source = ./launcher/config.rasi;
  xdg.configFile."rofi/style.rasi".source = ./launcher/style-2.rasi;
  xdg.configFile."rofi/bg.jpg".source = ./launcher/bg.jpg;

  # POWERMENU
  xdg.configFile."rofi/powermenu/style.rasi".source = ./powermenu/style-5.rasi;
  xdg.configFile."rofi/powermenu/powermenu.sh".source = ./powermenu/powermenu.sh;

}
