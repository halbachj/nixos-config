{ inputs, pkgs, system, ... }: {

  home.packages = with pkgs.jetbrains; [
    jdk-no-jcef
    pycharm-professional
    #clion
    #idea-ultimate
  ];


}
