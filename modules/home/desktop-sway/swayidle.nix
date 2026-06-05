{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  services.swayidle =
    let
      # Lock command
      lock = "${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc  --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --font 'JetBrains Nerdfont Mono' --grace 2 --fade-in 0.4 --daemonize";
      #lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
      display = status: "swaymsg 'output * power ${status}'";
    in
    {
      enable = true;
      timeouts = [
        {
          timeout = 180; # in seconds
          command = "${pkgs.libnotify}/bin/notify-send 'Locking in 20 seconds' -t 20000";
        }
        {
          timeout = 200;
          command = lock;
        }
        {
          timeout = 300;
          command = display "off";
          resumeCommand = display "on";
        }
        {
          timeout = 600;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = {
        "before-sleep" = (display "off") + "; " + lock;
        "after-resume" = display "on";
        "lock" = (display "off") + "; " + lock;
        "unlock" = display "on";
      };
    };
}
