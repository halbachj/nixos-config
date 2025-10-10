{
  inputs,
  pkgs,
  system,
  ...
}:
{
  home.packages = with pkgs; [
    #veloren
    airshipper
    mindustry
    endless-sky
    bsdgames
  ];
}
