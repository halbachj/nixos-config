{ inputs, pkgs, system, ... }: {
  home.packages = [
    inputs.cursor.packages.${pkgs.system}.default
  ];
}
