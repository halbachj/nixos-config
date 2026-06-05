{
  inputs,
  pkgs,
  system,
  ...
}:
{
  home.packages = with pkgs; [
    graphviz
    protonvpn-gui
    krusader
    rquickshare
    subsurface
    coder #TODO: move to engineering
    jellyfin-mpv-shim
    slack #TODO: Move to engineering
    awscli2
    poppler-utils #PDF utils
    feh
    viewnior
    vlc
    contact
    lazygit
  ];
}
