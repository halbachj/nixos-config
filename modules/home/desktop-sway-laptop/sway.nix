{ config, osConfig, pkgs, ... }:
{
  wayland.windowManager.sway = {
    config.keybindings = {} // {
      "XF86MonBrightnessDown" = "exec brightnessctl set 2%-";
      "XF86MonBrightnessUp"   = "exec brightnessctl set 2%+";
    };
    config.input = {} // {
      "2:14:ETPS/2_Elantech_Touchpad" = {
        natural_scroll = "enabled";
      };
    };
  };
}
