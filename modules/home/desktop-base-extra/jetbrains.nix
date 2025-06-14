{ inputs, pkgs, system, ... }: {

  home.packages = with pkgs.jetbrains; [
    jdk-no-jcef
    pycharm-professional
    gateway
    #clion
    #idea-ultimate
  ];

}
