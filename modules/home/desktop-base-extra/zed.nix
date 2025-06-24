{ inputs, pkgs, system, ... }: {
  home.packages = with pkgs; [
    zed-editor

    #python311  # or python3
    #python311Packages.pylsp  # or pyright
    #black
    #ruff
    #mypy
  ];
}
