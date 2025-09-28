{ inputs, pkgs, system, ... }: {
  home.packages = with pkgs; [
    graphviz
    protonvpn-gui
    krusader
    rquickshare
    keepassxc
    subsurface
  ];
}
