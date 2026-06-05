{
  inputs,
  pkgs,
  system,
  ...
}:
{

  home.packages = with pkgs; [
    jetbrains-toolbox
    jetbrains.jdk-no-jcef
    jetbrains.pycharm
    jetbrains.clion
    #idea-ultimate
  ];

}
