{ pkgs, input, ... }: {

  environment.systemPackages = with pkgs; [
    zip
    unzip
  ];


}
