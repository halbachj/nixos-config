{ pkgs, ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "hyprctl dispatch dpms off; hyprlock";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 180;
          on-timeout = "${pkgs.libnotify}/bin/notify-send 'Locking in 20 seconds' -t 20000";
        }
        {
          timeout = 200;
          on-timeout = "hyprlock";
        }
        {
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
