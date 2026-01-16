{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jq
  ];

  xdg.configFile."waybar/keyboard-layout.sh" = {
    text = ''
      #!/usr/bin/env bash
      layout="$(hyprctl -j devices | jq -r '.keyboards[0].active_keymap // "unknown"')"
      echo " ${layout}"
    '';
    executable = true;
  };

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-right = [
          "custom/kblayout"
          "pulseaudio"
          "network"
          "memory"
          "cpu"
          "clock"
        ];
        "custom/kblayout" = {
          exec = "~/.config/waybar/keyboard-layout.sh";
          interval = 2;
          format = "{}";
        };
        "hyprland/window" = {
          max-length = 60;
        };
      }
    ];
  };
}
