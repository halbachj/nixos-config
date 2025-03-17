{ inputs, pkgs, ... }: {

  home.packages = with pkgs; [
    arduino
    arduino-ide
    arduino-cli
  ];

}
