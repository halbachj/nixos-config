{ inputs, pkgs, ... }: {

  home.packages = with pkgs.jetbrains; [
    pycharm-professional
    #clion
    #idea-ultimate
  ];

}
