{ inputs, pkgs, ... }: {

  home.packages = with pkgs; [
    qucs-s
  ];

}
