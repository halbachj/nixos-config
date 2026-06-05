{
  inputs,
  pkgs,
  system,
  ...
}:
{
  services.kdeconnect.enable = true;
  
  home.packages = with pkgs; [
    kdePackages.krdp
  ];
}
