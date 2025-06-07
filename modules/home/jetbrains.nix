{ inputs, pkgs, ... }: {

  home.packages = with pkgs.jetbrains; [
    pycharm-professional
    gateway
    #clion
    #idea-ultimate
  ];

}
