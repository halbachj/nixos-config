{ pkgs, input, ... }: {

  environment.systemPackages = with pkgs; [
    tio
    screen
  ];


}
