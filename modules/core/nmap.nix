{ pkgs, input, ... }: {

  environment.systemPackages = with pkgs; [
    nmap
  ];


}
