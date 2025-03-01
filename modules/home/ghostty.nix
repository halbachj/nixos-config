{
  inputs,
  pkgs,
  systemSettings,
  ...
}:
let
  ghostty = inputs.ghostty.packages.x86_64-linux.default;
in
{
  home.packages = (with pkgs; [ ghostty ]);

  xdg.configFile."ghostty/config".text = ''
    # Font
    font-family = "Maple Mono"
    font-size = 16
    font-thicken = true
    font-feature = ss01
    font-feature = ss04

    bold-is-bright = false
    adjust-box-thickness = 1

    # Theme
    theme = "JetBrains Darcula"
    background-opacity = 0.88

    cursor-style = bar
    cursor-style-blink = false
    adjust-cursor-thickness = 1

    resize-overlay = never
    copy-on-select = false
    confirm-close-surface = false
    mouse-hide-while-typing = true

    window-theme = ghostty
    window-padding-x = 4
    window-padding-y = 6
    window-padding-balance = true
    window-padding-color = background
    window-inherit-working-directory = true
    window-inherit-font-size = true
    window-decoration = false

    gtk-titlebar = false
    gtk-single-instance = false
    gtk-tabs-location = bottom
    gtk-wide-tabs = false

    auto-update = off
    term = ghostty
    clipboard-paste-protection = false

    keybind = shift+end=unbind
    keybind = shift+home=unbind
    keybind = ctrl+shift+left=unbind
    keybind = ctrl+shift+right=unbind
    keybind = shift+enter=text:\n
  '';
  xdg.configFile."ghostty/themes/gruvbox".text = ''
  '';
}
