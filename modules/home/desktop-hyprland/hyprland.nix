{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprland
    hyprpaper
    hypridle
    hyprlock
    rofi-wayland
    wl-clipboard
    slurp
    grim
    swappy
    mako
    brightnessctl
  ];

  home.file.".config/hypr/background.jpg".source = ./background.jpg;

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.config/hypr/background.jpg
    wallpaper = ,~/.config/hypr/background.jpg
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "DVI-D-1,1920x1080@60,2970x0,1"
        "DP-1,1920x1080@60,1050x0,1"
        "HDMI-A-2,1680x1050@60,0x0,1,transform,1"
      ];

      input = {
        kb_layout = "de,us,ie";
        kb_options = "grp:alt_shift_toggle";
        numlock_by_default = true;
      };

      device = {
        "Keychron_K4_Keychron_K4" = {
          kb_layout = "us";
          kb_options = "caps:none";
        };
        "ETPS/2_Elantech_Touchpad" = {
          natural_scroll = true;
          tap_to_click = true;
          accel_profile = "flat";
          disable_while_typing = false;
          sensitivity = 0;
        };
        "ETPS/2_Elantech_TrackPoint" = {
          natural_scroll = true;
          accel_profile = "flat";
          disable_while_typing = false;
          sensitivity = 0;
        };
      };

      env = [
        "_JAVA_AWT_WM_NONREPARENTING,1"
      ];

      "exec-once" = [
        "mako"
        "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "sh -c 'export _JAVA_AWT_WM_NONREPARENTING=1'"
        "hyprpaper"
        "hyprctl dispatch moveworkspacetomonitor 1 DP-1"
        "hyprctl dispatch moveworkspacetomonitor 2 DP-1"
        "hyprctl dispatch moveworkspacetomonitor 3 DP-1"
        "hyprctl dispatch moveworkspacetomonitor 4 DP-1"
        "hyprctl dispatch moveworkspacetomonitor 5 DVI-D-1"
        "hyprctl dispatch moveworkspacetomonitor 6 DVI-D-1"
        "hyprctl dispatch moveworkspacetomonitor 7 DVI-D-1"
        "hyprctl dispatch moveworkspacetomonitor 8 HDMI-A-2"
        "hyprctl dispatch moveworkspacetomonitor 9 HDMI-A-2"
        "hyprctl dispatch moveworkspacetomonitor 10 HDMI-A-2"
      ];

      bind = [
        "SUPER SHIFT, R, exec, hyprctl reload"
        "SUPER, C, killactive"
        "SUPER, Return, exec, ghostty"
        "SUPER, D, exec, rofi -show drun"
        "SUPER, M, exec, rofi -show ssh"
        "SUPER SHIFT, S, exec, sh -c 'grim -g \"$(slurp)\" - | wl-copy --type image/png'"
        "SUPER SHIFT, C, exec, sh -c 'grim -g \"$(slurp)\" \"$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png\"'"

        "SUPER, H, movefocus, l"
        "SUPER, J, movefocus, d"
        "SUPER, K, movefocus, u"
        "SUPER, L, movefocus, r"

        "SUPER, Left, movefocus, l"
        "SUPER, Down, movefocus, d"
        "SUPER, Up, movefocus, u"
        "SUPER, Right, movefocus, r"

        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, J, movewindow, d"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, L, movewindow, r"

        "SUPER SHIFT, Left, movewindow, l"
        "SUPER SHIFT, Down, movewindow, d"
        "SUPER SHIFT, Up, movewindow, u"
        "SUPER SHIFT, Right, movewindow, r"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"

        "SUPER, F, fullscreen"
        "SUPER SHIFT, Space, togglefloating"
        "SUPER, Space, cyclenext"

        "SUPER, Tab, workspace, m+1"
        "SUPER SHIFT, Tab, workspace, m-1"

        "SUPER, W, togglegroup"
        "SUPER, bracketleft, changegroupactive, b"
        "SUPER, bracketright, changegroupactive, f"

        "SUPER, minus, togglespecialworkspace, scratch"
        "SUPER SHIFT, minus, movetoworkspace, special:scratch"

        "SUPER, K, exec, hyprctl switchxkblayout all next"
        "SUPER ALT, D, exec, hyprctl switchxkblayout all 0"
        "SUPER ALT, U, exec, hyprctl switchxkblayout all 1"
        "SUPER ALT, I, exec, hyprctl switchxkblayout all 2"

        ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +1%"
        ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -1%"
        ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"

        ",XF86MonBrightnessDown, exec, brightnessctl set 2%-"
        ",XF86MonBrightnessUp, exec, brightnessctl set 2%+"
      ];
    };

    extraConfig = ''
      bind = SUPER, R, submap, resize
      submap = resize
      binde = , H, resizeactive, -30 0
      binde = , J, resizeactive, 0 30
      binde = , K, resizeactive, 0 -30
      binde = , L, resizeactive, 30 0
      binde = , Left, resizeactive, -30 0
      binde = , Down, resizeactive, 0 30
      binde = , Up, resizeactive, 0 -30
      binde = , Right, resizeactive, 30 0
      bind = , Return, submap, reset
      bind = , Escape, submap, reset
      submap = reset
    '';
  };
}
