{ pkgs, input, ... }: {

  environment.systemPackages = with pkgs; [
    netcat
  ];


}
