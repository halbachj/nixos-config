{
  config,
  osConfig,
  pkgs,
  ...
}:
{
  wayland.windowManager.sway = {
    config.keybindings = { } // {
      "XF86MonBrightnessDown" = "exec brightnessctl set 2%-";
      "XF86MonBrightnessUp" = "exec brightnessctl set 2%+";
    };
    config.input = { } // {
      "2:14:ETPS/2_Elantech_Touchpad" = {
        natural_scroll = "enabled";
        tap = "enabled";
        accel_profile = "flat";
        pointer_accel = "0";
        dwtp = "disabled";
        dwt = "disabled";
      };
      "2:14:ETPS/2_Elantech_TrackPoint" = {
        natural_scroll = "enabled";
        tap = "enabled";
        #accel_profile = "flat";
        #pointer_accel = "0";
        dwtp = "disabled";
        dwt = "disabled";
      };
    };
  };
}
