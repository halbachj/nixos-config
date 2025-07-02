{ inputs, pkgs, system, ... }: {

  home.packages = with pkgs; [
    jetbrains-toolbox
    jetbrains.jdk-no-jcef
    jetbrains.pycharm-professional
    jetbrains.clion
    #idea-ultimate
  ];


}
